# AES SBOX evaluation

## Source files
  * the [src](src/) directory contains the SBOX source files in different formats
      * the original VHDL file was converted to Verilog by [vhd2vl](http://www.geda-project.org/tools/vhd2vl/)
    * the BLIF file was synthesized by [yosys](http://www.clifford.at/yosys/)
    * the AAG file was written by [abc](https://github.com/berkeley-abc/abc)
  * the [layout](layout/) directory contains the (post-)layout files
    * (post-)layout source files are provided in form readable by open source tools, namely [Magic](https://github.com/RTimothyEdwards/magic), [ngSPICE](http://ngspice.sourceforge.net/) and [qflow](https://github.com/RTimothyEdwards/qflow
    * Magic was used to generate SPICE netlist
    * the cell maping procedure was done by a custom tool [TSaCt2](https://github.com/DDD-FIT-CTU/TSaCt2) using AAG source file as input
    * technology node is TSMC 180nm
  * protected cells [PAND2X1](../resistantGates/magic/PAND2X1.mag) and [POR2X1](../resistantGates/magic/POR2X1.mag) were drawn by Magic
    * the [LEF](https://web.archive.org/web/20181031162337/http://www.ispd.cc/contests/18/lefdefref.pdf) descriptions were exported by Magic built-in commands, customized by hand (offsets, etc.) and incorporated into the custom version of the [OSU018 library](../.magic/inc/osu018_stdcells.lef)
    * the custom [technology file](../.magic/inc/SCN6M_SUBM.10_pls.tech) allowing direct usage of the (annotated !! be careful with drain/source identification - this must be done manually !! )SPICE netlist exported by Magic (since Magic v8.3.48) is provided
  

## SPICE Tests

| Circuit type      | SPICE test                    | Description                                                                                    | BLIF map file                                       | Magic file                                         | SPICE netlist                                         | 
| :---:             | :---:                         | :---                                                                                           | :---                                                | :---                                               | :---                                                  |
| singleRail        | [test001](test001_SBOX.spice) | The single-rail circuit implemented by 2-input NAND and NOR gates and inverters only           | [singleRail.blif](layout/singleRail.blif)           | [singleRail.mag](layout/singleRail.mag)            | [singleRail.spice](layout/singleRail.spice)           |
| dualRailAS        | [test002](test002_SBOX.spice) | The dual-rail circuit (with alternating spacer) implemented by 2-input NAND and NOR gates only | [dualRailAS.blif](layout/dualRailAS.blif)           | [dualRailAS.mag](layout/dualRailAS.mag)            | [dualRailAS.spice](layout/dualRailAS.spice)           |
| dualRail          | [test003](test003_SBOX.spice) | The dual-rail circuit implemented by by 2-input AND and OR gates only                          | [dualRail.blif](layout/dualRail.blif)               | [dualRail.mag](layout/dualRail.mag)                | [dualRail.spice](layout/dualRail.spice)               |
| pDualRail         | [test004](test004_SBOX.sh)    | The dual-rail circuit implemented by protected AND and OR gates only                           | [pDualRail.blif](layout/pDualRail.blif)             | [pDualRail.mag](layout/pDualRail.mag)              | [pDualRail.spice](layout/pDualRail.spice)             |
| secLibDualRail    | [test005](test005_SBOX.sh)    | The dual-rail circuit implemented by dual-rail secLib gates                                    | [secLibDualRail.blif](layout/secLibDualRail.blif)   | [secLibDualRail.mag](layout/secLibDualRail.mag)    | [secLibDualRail.spice](layout/secLibDualRail.spice)   |

The pDualRail and secLibDualRail netlists are huge; thus these netlists were partitioned by a custom tool and simulated "per-partes". 
All partitions of pDualRail can be simulated by the upstream ngSPICE.
The secLibDualRail partitions tend to have huge subcircuit interfaces exceeding the ngSPICE limits: modified version of ngSPICE must be used (N_GLOBAL_NODES define was increased from 1005 to 10000).

## Generate SBOX Inputs

```console
$ bash gen_SBOX_inputs.sh
$ bash gen_SBOX_dinputs.sh
```

## Run Simulation(s) 

```console
START=0   # SBOX input begin
START=255 # SBOX input end
PWR=300   # 300mW laser power
TEST="test001_SBOX"

$ bash test00X_runner.sh ${PWR} ${START} ${STOP} ${TEST} 
```
