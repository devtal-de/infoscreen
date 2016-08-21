gl.setup(1920, 1080)

font = resource.load_font("DejaVuSerif.ttf")
logo = resource.load_image("wsw-logo.gif")

json = require "json"

util.file_watch("fahrplan.json", function(content)
    fahrplan = json.decode(content)
    last_update = sys.now
end)

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(50, 40, "Fahrplan", 60, 1,1,1,1)
    font:write(350, 50, "[Schleswiger Strasse]", 30, 1,1,1,1)
    logo:draw(700, 60, 845, 103)

    font:write(5, 140, "Uhrzeit", 40, 1,1,1,1)
    font:write(250, 140, "Linie", 40, 1,1,1,1)
    font:write(370, 140, "Richtung", 40, 1,1,1,1)
    font:write(1100, 140, "Verspätung", 40, 1,1,1,1)
    rowhight = 70
    for idx, fahrt in ipairs(fahrplan) do
        font:write(50, 150 + rowhight * idx, fahrt.uhrzeit, 40, 1,1,1,1)
        font:write(270, 150 + rowhight * idx, fahrt.linie, 40, 1,1,1,1)
        font:write(370, 150 + rowhight * idx, fahrt.ziel, 40, 1,1,1,1)
        if 0+fahrt.verspaetung > 0 then
            font:write(1100, 150 + rowhight * idx, "+" .. fahrt.verspaetung, 40, 1,0,0,1)
        else
            font:write(1100, 150 + rowhight * idx, "+" .. fahrt.verspaetung, 40, 1,1,1,1)
        end
        if idx > 10 then
           break 
        end
    end
end
