#!/usr/bin/python
#
# Export GDSII file exported from magic to SVG
# The resulting file is rendered faster than if rendered directly to PostScript
#
# Notes:
#   It is recommended to export GDW with no labels: 
#     calma labels no
#     cama write NAME
#
# 


import gdspy
import tempfile
import tsmc180style

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='GDS2SVG for TSMC180')
parser.add_argument('-g', '--gds',  help='GDS file', type=str, default=None,  required=True)
parser.add_argument('-s', '--svg', help='SVG file', type=argparse.FileType('w'), required=True)
args = parser.parse_args()


gdsii = gdspy.GdsLibrary()
gdsii.read_gds(args.gds)

for cell in gdsii.top_level():
    print(str(cell))
    flat = cell.flatten()


    print("Layers:")
    for layer in flat.get_layers():
        print(str(layer))


    print("Data types: ")
    for dt in flat.get_datatypes():
        print(str(dt))
    
    #flat.write_svg(args.svg, style=tsmc180style.STYLES, background='#fff')
    #exit(1)
    
    with args.svg as svg:
        svg.write(tsmc180style.SVG_HEAD)
        svg.write("\n<defs>\n")
        svg.write('<style type="text/css">\n')
        for style in tsmc180style.STYLES:
            sstring=".l"+str(style[0])+"d"+str(style[1])+" {"
            for item in tsmc180style.STYLES[style]:
                sstring = sstring + str(item)+ ": " + str(tsmc180style.STYLES[style][item]) + "; "
            sstring = sstring + "}\n"
            svg.write(sstring)
            
        svg.write('</style>\n')
        svg.write(tsmc180style.FILL_PATTERNS)
        svg.write("</defs>\n")
        
        
        flat.to_svg(svg, scaling=10)
        svg.write("\n</svg>\n")
