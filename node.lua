local INTERVAL = 10
gl.setup(1920, 1080)

logo = resource.load_image("devtal-logo.png")

deck = {"fahrplan"}

slide_source = util.generator(function()
    return deck
end)

next_slide = sys.now() + INTERVAL
current_slide = "fahrplan"

function node.render()
    gl.clear(0, 0, 0, 1)
    

    if sys.now() > next_slide then
        next_slide = sys.now() + INTERVAL
        current_slide = slide_source:next()
    end

    resource.render_child(current_slide):draw(0, 0, WIDTH, HEIGHT)

    logo:draw(WIDTH -300, 0, WIDTH - 150, 150)
    local clock = resource.render_child("analogclock")
    clock:draw(WIDTH - 150, 0, WIDTH, 150)
end
