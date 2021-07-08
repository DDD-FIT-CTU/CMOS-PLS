
SVG_HEAD="""<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
     width="118.0" height="121.0" viewBox="-13.5 -110.5 118.0 121.0">
"""

# Define style for TSMC180 in the same way as required by gdspy.write_svg()
STYLES = {
    
#psub
(41,0) : {'fill': 'white', 'stroke': 'none'},
#nwell
(42,0) : { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#NwellPattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' },

#diffusion
#style[(43,0)] = { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#DiffusionPattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' }
(43,0) : {'fill': 'gray', 'stroke': 'gray', 'opacity' : '0.8'},

# diff/m contact
(47,0) : {'fill': '#db00c8', 'stroke': '#3800b9', 'opacity' : '1.0'},
# pcontact
(48,0) : {'fill': 'white', 'stroke': 'black'},
# m2/m1 contact
(50,0) : {'fill': '#ff00ff', 'stroke': '#0000ff', 'opacity' : '1.0'},

# poly
(46,0) : {'fill': '#bf1500', 'stroke': '#bf1500', 'opacity' : '0.9'},
# m1
#style[(49,0)] = {'fill': '#4da5ff', 'stroke': 'none', 'opacity' : '0.8'}
(49,0) : { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#M1Pattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' },
# m2
#style[(51,0)] = {'fill': '#e28bff', 'stroke': 'none', 'opacity' : '0.8'}
(51,0) : { 'font-variation-settings' : 'normal', 'opacity' : '1', 'vector-effect' : 'none', 'fill' : 'url(#M2Pattern)', 'fill-opacity' : '1', 'stroke' : '#000000', 'stroke-width' : '0.0mm', 'stroke-linecap' : 'butt', 'stroke-linejoin' : 'miter' , 'stroke-miterlimit' : '4', 'stroke-dasharray' : 'none' , 'stroke-dashoffset' : '0', 'stroke-opacity' : '1', 'stop-color' : '#000000', 'stop-opacity' : '1' },

# hide
(31,0) : {'fill': 'white', 'opacity': '0.0'},
# select around pdiffusion
(44,0) : {'fill': '#fba940', 'stroke': 'none', 'opacity': '0.0'},
# select around ndiffusion
(45,0) : {'fill': '#8aff4a', 'stroke': 'none', 'opacity': '0.0'},

}

#
#
# Patterns come from https://inkscape.org/~henkjan_nl/%E2%98%85classical-hatch-patterns-for-mechanical-drawings
# By using different pitch (pitch/10) and line width (0.05mm instead of 0.25mm)
#
#
FILL_PATTERNS="""
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
