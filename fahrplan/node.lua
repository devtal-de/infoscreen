gl.setup(1024, 768)

font = resource.load_font("SuperGroteskC-Rg.ttf")
logo = resource.load_image("wsw-logo.gif")

json = require "json"

util.file_watch("fahrplan.json", function(content)
    fahrplan = json.decode(content)
    last_update = sys.now
end)

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(50, 40, "Fahrplan", 80, 1,1,1,1)
    font:write(350, 80, "[Schleswiger Strasse]", 20, 1,1,1,1)
    logo:draw(700, 60, 845, 103)

    font:write(50, 140, "Uhrzeit", 50, 1,1,1,1)
    font:write(250, 140, "Linie", 50, 1,1,1,1)
    font:write(360, 140, "Richtung", 50, 1,1,1,1)
    font:write(750, 140, "Verspätung", 50, 1,1,1,1)
    for idx, fahrt in ipairs(fahrplan) do
        font:write(50, 150 + 40 * idx, fahrt.uhrzeit, 40, 1,1,1,1)
        font:write(270, 150 + 40 * idx, fahrt.linie, 40, 1,1,1,1)
        font:write(360, 150 + 40 * idx, fahrt.ziel, 40, 1,1,1,1)
        if 0+fahrt.verspaetung > 0 then
            font:write(870, 150 + 40 * idx, "+" .. fahrt.verspaetung, 40, 1,0,0,1)
        else
            font:write(870, 150 + 40 * idx, "+" .. fahrt.verspaetung, 40, 1,1,1,1)
        end
        if idx > 10 then
           break 
        end
    end
end
