gl.setup(1024, 768)

font = resource.load_font("SuperGroteskC-Rg.ttf")

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(50, 40, "Morgen:", 80, 1,1,1,1)

    font:write(50, 240, "Spieletag", 50, 1,1,1,1)
    font:write(50, 340, "Trassenküche", 50, 1,1,1,1)
    font:write(50, 440, "Stadt Wiki Treffen", 50, 1,1,1,1)
    font:write(50, 540, "Diensthack", 50, 1,1,1,1)
end
