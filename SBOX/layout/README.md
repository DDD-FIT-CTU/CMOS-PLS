# SBOX Layouts

Four different implementations of SBOX layout were synthetized.

The circuit versions were generated from the [aes_sbox.aag](aes_sbox.aag) file by a custom tool.

## Static Single-Rail Implementation
  * standard single-rail static CMOS AES SBOX implementation
  * Files:
    * [standard cell map file](singleRail.blif)
    * [Magic source](singleRail.mag)
    * [extracted Magic netlist](singleRail.ext)
    * [extracted SPICE netlist](singleRail.spice)

## Static Dual-Rail Implementation
  * standard dual-rail static CMOS AES SBOX implementation using library cells (AND2X1 and OR2X1) and automated routing without dual-rail ballancing
  * Files:
    * [standard cell map file](dualRail.blif)
    * [Magic source](dualRail.mag)
    * [extracted Magic netlist](dualRail.ext)
    * [extracted SPICE netlist](dualRail.spice)

## Static Dual-Rail Implementation with Alternating Spacer
  * alternative dual-rail static CMOS AES SBOX implementation with alternating spacer using library cells (NAND2X1 and NOR2X1) and automated routing without dual-rail ballancing
  * Files:
    * [standard cell map file](dualRailAS.blif)
    * [Magic source](dualRailAS.mag)
    * [extracted Magic netlist](dualRailAS.ext)
    * [extracted SPICE netlist](dualRailAS.spice)
    
##  Protected Dual-Rail Implementation
  * dual-rail static CMOS AES SBOX implementation using custom protedted cells (PAND2X1 and POR2X1) and automated routing without dual-rail ballancing
  * qrouter requires 0.9 initial density to finish routing
  * Files:
    * [standard cell map file](pDualRail.blif)
    * [Magic source](pDualRail.mag)
    * [extracted Magic netlist](pDualRail.ext)
    * [extracted SPICE netlist](pDualRail.spice)

##  SecLib Dual-Rail Implementation
  * dual-rail static CMOS AES SBOX implementation using (modified) SecLib method employing dynamic C-elements
  * qrouter requires 0.75 initial density to finish routing
  * Files:
    * [standard cell map file](secLibDualRail.blif)
    * [Magic source](secLibDualRail.mag)
    * [extracted Magic netlist](secLibDualRail.ext)
    * [extracted SPICE netlist](secLibDualRail.spice)
    
## GDS2SVG Export

```console
for FNAME in $( echo "PAND2X1 POR2X1" )
do
  python drawGDSCell.py -g ${FNAME}.gds -s ${FNAME}.svg
  inkscape -g --batch-process --actions="select:${FNAME}; ObjectFlipVertically; ObjectFlipHorizontally; export-filename:${FNAME}.pdf; export-id:${FNAME}; export-do; FileClose" ${FNAME}.svg
done
```
