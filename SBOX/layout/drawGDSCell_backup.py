#!/usr/bin/python
#
# Export GDSII file to SVG
#
# 


import gdspy
import tempfile

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Draw data.')
parser.add_argument('-g', '--gds',  help='GDS file', type=str, default=None,  required=True)
parser.add_argument('-s', '--svg',  help='SVG file', type=str, default=None,  required=True)
args = parser.parse_args()

# Load a GDSII file into a new library
gdsii = gdspy.GdsLibrary()
# Use a previously-created library to load the file contents into
#gdsii.read_gds('sizeCmp.gds')
gdsii.read_gds(args.gds)

# Define style for TSMC180
style={}

#psub
style[(41,0)] = {'fill': 'white', 'stroke': 'none'}
#nwell
style[(42,0)] = { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#NwellPattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' }

#diffusion
#style[(43,0)] = { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#DiffusionPattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' }
style[(43,0)] = {'fill': 'gray', 'stroke': 'gray', 'opacity' : '0.5'}
# poly
style[(46,0)] = {'fill': '#bf1500', 'stroke': '#bf1500', 'opacity' : '0.9'}

# diff/m contact
style[(47,0)] = {'fill': '#db00c8', 'stroke': '#3800b9', 'opacity' : '1.0'}
# pcontact
style[(48,0)] = {'fill': 'white', 'stroke': 'black'}
# m2/m1 contact
style[(50,0)] = {'fill': '#ff00ff', 'stroke': '#0000ff', 'opacity' : '1.0'}


# m1
#style[(49,0)] = {'fill': '#4da5ff', 'stroke': 'none', 'opacity' : '0.8'}
style[(49,0)] = { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#M1Pattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' }
# m2
#style[(51,0)] = {'fill': '#e28bff', 'stroke': 'none', 'opacity' : '0.8'}
style[(51,0)] = { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#M2Pattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' }

# hide
style[(31,0)] = {'fill': 'white', 'opacity': '0.0'}
# select around pdiffusion
style[(44,0)] = {'fill': '#fba940', 'stroke': 'none', 'opacity': '0.0'}
# select around ndiffusion
style[(45,0)] = {'fill': '#8aff4a', 'stroke': 'none', 'opacity': '0.0'}


for cell in gdsii.top_level():
    print(str(cell))
    flat = cell.flatten()


    print("Layers:")
    for layer in flat.get_layers():
        print(str(layer))


    print("Data types: ")
    for dt in flat.get_datatypes():
        print(str(dt))
    
    #flat.write_svg(args.svg, style=style, background='#fff')
    fp = tempfile.NamedTemporaryFile(delete=False)
    with open(fp.name, 'w') as f:
        f.write("test")
        print(str(f.name))
        flat.to_svg(f, scaling=1)
        exit(1)


PATTERNS="""
<pattern id="M1Pattern"
inkscape:stockid="M1 pattern"
x="0" y="0" width="0.7086614173228347" height="0.7086614173228347"
patternUnits="userSpaceOnUse">
  <path
     style="stroke:#4da5ff;stroke-width:0.05mm"
     d="M -3.5433070866141736,4.251968503937008 4.251968503937008,-3.5433070866141736"/>
  <path
     style="stroke:#4da5ff;stroke-width:0.05mm"
     d="M -3.5433070866141736,-3.5433070866141736 4.251968503937008,4.251968503937008"/>
</pattern>
<pattern id="M2Pattern"
inkscape:stockid="M2 pattern"
x="0" y="0" width="0.7086614173228347" height="0.7086614173228347"
patternUnits="userSpaceOnUse">
  <path
     style="stroke:#e28bff;stroke-width:0.05mm"
     d="M -3.5433070866141736,4.251968503937008 4.251968503937008,-3.5433070866141736"/>
  <path
     style="stroke:#e28bff;stroke-width:0.05mm"
     d="M -3.5433070866141736,-3.5433070866141736 4.251968503937008,4.251968503937008"/>
</pattern>
<pattern id="DiffusionPattern"
inkscape:stockid="Cross hatch 0.2"
x="0" y="0" width="0.8427451996082276" height="0.8427451996082276"
patternUnits="userSpaceOnUse">
  <path
     style="stroke:#000000;stroke-width:0.05mm"
     d="M -3.5433070866141736,4.386052286222402 4.386052286222402,-3.5433070866141736"/>
  <path
     style="stroke:#000000;stroke-width:0.05mm"
     d="M -3.5433070866141736,-3.5433070866141736 4.386052286222402,4.386052286222402"/>
</pattern>
<pattern id="NwellPattern"
inkscape:stockid="Hatch 0.4 x 45°"
x="0" y="0" width="2.0043971750169858" height="2.0043971750169858"
patternUnits="userSpaceOnUse">
  <path
     style="stroke:#000000;stroke-width:0.05mm"
     d="M -3.5433070866141736,3.5433070866141736 3.5433070866141736,-3.5433070866141736"/>
  <path
     style="stroke:#000000;stroke-width:0.05mm"
     d="M -3.5433070866141736,5.547704261631159 5.547704261631159,-3.5433070866141736"/>
  <path
     style="stroke:#000000;stroke-width:0.05mm"
     d="M -1.5389099115971878,5.547704261631159 5.547704261631159,-1.5389099115971878"/>
</pattern>
"""

print(PATTERNS)
