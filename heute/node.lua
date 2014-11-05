gl.setup(1024, 768)

font = resource.load_font("SuperGroteskC-Rg.ttf")

json = require "json"

util.file_watch("heute.json", function(content)
    eventss = json.decode(content)
    last_update = sys.now
end)


function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(50, 40, "Heute:", 80, 1,1,1,1)
    for idx, event in ipairs(eventss) do
        if event.start ==  "00:00" then
        else
            font:write(30, 135 + 100 * idx, event.start .. " -" , 30, 1,1,1,1)
            font:write(30, 165 + 100 * idx, event.ende .. " Uhr" , 30, 1,1,1,1)
        end
        font:write(170, 145 + 100 * idx, event.summary , 50, 1,1,1,1)
    end
--    font:write(50, 240, "Spieletag", 50, 1,1,1,1)
--    font:write(50, 340, "Trassenküche", 50, 1,1,1,1)
--    font:write(50, 440, "Stadt Wiki Treffen", 50, 1,1,1,1)
--    font:write(50, 540, "Diensthack", 50, 1,1,1,1)
end
