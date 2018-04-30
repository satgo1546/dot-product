# MCEdit filter

from albow import alert

displayName = "Find Command"

inputs = (
    ("Command:", ("string", "value=")),
)

def perform(level, box, options):
    command = options["Command:"]
    n = 0
    result = ""
    for (chunk, slices, point) in level.getChunkSlices(box):
        for e in chunk.TileEntities:
            x = e["x"].value
            y = e["y"].value
            z = e["z"].value
            if (x, y, z) in box:
                t = e["id"].value
                if t == "Control":
                    c = e["Command"].value
                    if c.find(command) >= 0:
                        n += 1
                        result += "(%d, %d, %d) %s\n" % (x, y, z, c)
    result += "(%d)" % n
    alert(result)
