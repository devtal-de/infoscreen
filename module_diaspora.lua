local json = require "json"
local utils = require "utils"
local anims = require "anims"

local M = {}

local posts = {}
local post_idx = 0

local unwatch = util.file_watch("diaspora.json", function(raw)
    posts = json.decode(raw)
    post_idx = 0
    for idx = #posts,1,-1 do
        local post = posts[idx]
        local ok, profile = pcall(resource.open_file, post.profile_image)
        if not ok then
            print("cannot use this post. profile image missing", profile)
            table.remove(posts, idx)
        end
        post.profile = profile
        post.lines = utils.wrap(post.text, 27)
    end
end)

function M.unload()
    unwatch()
end

function M.can_schedule()
    return #posts > 0
end

function M.prepare(options)
    local post
    post, post_idx = utils.cycled(posts, post_idx)
    return options.duration or 10, post
end

function M.run(duration, post, fn)
    local img = resource.load_image{
        file = post.profile:copy(),
        mipmap = true,
    }

    local start_y = 100

    local x = 150
    local y = start_y
    local a = utils.Animations()

    local S = 0
    local E = duration

    a.add(anims.moving_font(S, E, x+140, y, post.diaspora_id, 70, 1,1,1,1)); y=y+75
    a.add(anims.moving_font(S, E, x+140, y, "@"..post.author, 40, 1,1,1,.8)); S=S+0.1; y=y+90
    for idx = 1, #post.lines do
        local line = post.lines[idx]
        a.add(anims.moving_font(S, E, x, y, line, 100, 1,1,1,1)); S=S+0.1; y=y+100
    end
    y = y + 20

    local age = Time.unixtime() - post.created_at
    if age < 100 then
        age = string.format("%ds", age)
    elseif age < 3600 then
        age = string.format("%dm", age/60)
    else
        age = string.format("%dh", age/3600)
    end
    a.add(anims.moving_font(S, E, x, y, age .. " ago", 50, 1,1,1,1)); S=S+0.1; y=y+60

    a.add(anims.post_profile(S, E, x, start_y, img, 120))

    for now in fn.upto_t(E) do
        a.draw(now)
    end

    img:dispose()
    return true
end

return M
