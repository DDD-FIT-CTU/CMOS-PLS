# Attack-Resistant Structures

  * This test-set is dedicated to the testing of proposed attack-resistant structures
  * The attack-resistant structures are subject of the patent application submitted in March 2020 to the [Czech Industrial Property Office](www.upv.cz/)

Requirements:
  * ngspice (tested in v30 and v31)
  * gnuplot
  * bash

The test groups can be executed by [run_tests.sh](run_tests.sh), the generated graphs are automatically placed into [output](output) directory.

## Inverter Chains
  * inverter chain tests are denoted "00X"
  * test running script name: "test00X.sh"
  * Gnuplot script: "test00X.gnuplot"
  * two graphs are provided as the test output:
    * voltage graph: one of the internal node voltage and the output voltage node is provided
    * current graph: VDD node currents for bot input patterns are provided

| Test Name | Test Description                                     | Test Output                   |
| :---:     | :---                                                 | :---                          |
| 001       | 1-input buffer                                       | [test001](output/test001.pdf) |
| 002       | 1-input buffer driven by affected inputs             | [test002](output/test002.pdf) |
| 003       | modified 1-input buffer                              | [test003](output/test003.pdf) |
| 004       | modified 1-input buffer  driven by affected inputs   | [test004](output/test004.pdf) |
| 005       | 3-inverter chain optimized by hand                   | [test005](output/test005.pdf) |
| 006       | 5-inverter chain - unoptimized                       | [test006](output/test006.pdf) |
| 007       | Test of the DualRail Wire Reset proposal             | -                             |
| 008       | 3-inverter chain compensed by the feedback inverter  | [test008](output/test008.pdf) |
| 009       | 3-inverter chain compensed by the parallel inverter  | [test009](output/test009.pdf) |
  
  
## NAND Compensation
  * NAND compensation tests are denoted "01X"
  * test running script name: "test01X.sh"
  * Gnuplot script: "test01X.gnuplot"
  * two graphs are provided as the test output:
    * voltage graph: one of the internal node voltage and the output voltage node is provided
    * current graph: VDD node currents for bot input patterns are provided

| Test Name | Test Description                                                            | Test Output                   |
| :---:     | :---                                                                        | :---                          |
| 010       | NAND std. cell + output INVERTER std. cell                                  | [test010](output/test010.pdf) |
| 011       | NAND std. cell with symetrized NMOS stack                                   | [test011](output/test011.pdf) |
| 012       | NAND std. cell with symetrized NMOS stack and output inverter(s)            | [test012](output/test012.pdf) |
| 013       | symetrized NAND std. cell + serialR + output inverter(s)                    | [test013](output/test013.pdf) |
| 014       | compensed AND2 structure                                                    | [test014](output/test014.pdf) |
| 014       | compensed AND2 structure -- MonteCarlo simulation - MOS models are varied   | [test014](output/test014_varmodelmc.ps) |
| 014       | compensed AND2 structure -- MonteCarlo simulation - gate inputs are varied  | [test014](output/test014_varinputmc.ps) |
| 015       | AND2 structure ballanced by std. cells only                                 | [test015](output/test015.pdf) |
| 016       | Symetrized NAND and inverter chains to emulate illumination-affected inputs | [test016](output/test016.pdf) |
| 017       | AND std. cell test                                                          | [test010](output/test017.pdf) |
| 018       | NAND2X1 std. cell test                                                      | [test018](output/test018.pdf) |


## NOR Compensation
  * NOR compensation tests are denoted "02X"
  * test running script name: "test02X.sh"
  * Gnuplot script: "test02X.gnuplot"
  * two graphs are provided as the test output:
    * voltage graph: one of the internal node voltage and the output voltage node is provided
    * current graph: VDD node currents for bot input patterns are provided

| Test Name | Test Description                                      | Test Output                   |
| :---:     | :---                                                  | :---                          |
| 020       | NOR + output inverter std. cells                      | [test020](output/test020.pdf) |
| 021       | OR std. cell test                                     | [test021](output/test021.pdf) |
| 022       | compensed OR2 structure                               | [test022](output/test022.pdf) |
| 023       | NOR2X1 std. cell test                                 | [test023](output/test023.pdf) |

  
## Domino Logic Evaluation
  * Domino logic tests are denoted "03X"
  * test running script name: "test03X.sh"
  * Gnuplot script: "test03X.gnuplot"
  * two graphs are provided as the test output:
    * voltage graph: one of the internal node voltage and the output voltage node is provided
    * current graph: VDD node currents for bot input patterns are provided

| Test Name | Test Description                                     | Test Output                         |
| :---:     | :---                                                 | :---                                |
| 030       | Domino AND gate                                      | [test030](output/test030.pdf)       |
| 031       | Domino AND gate with weak keeper                     | [test031](output/test031.pdf)       |
| 030 + 031 | A combined current graph                             | [test030+31](output/test030+31.pdf) |


## Evaluation of netlists exported directly from layout
  * those tests are used for evaluation of netlists exported directly from magic - not netlists synthetized (partially) by hand as in 00X, 01X and 02X cases
  * those tests are denoted "04X"
  * test running script name: "test04X.sh"
  * Gnuplot script: "test04X.gnuplot"
  * three graphs are provided as the test output:
    * voltage graph: one of the internal node voltage and the output voltage node is provided
    * current graph: VDD node currents for all input patterns are provided
    * voltage graph: CTRL node voltage (light-sensitive inverter output or it's inverted value)
    
| Test Name | Magic Source File                | LEF File (Technology File)       | EXT File (Magic Extaracted netlist) |  Test Description                                                                                                       | Test Output                   |
| :---:     | :---                             | :---                             | :---                                | :---                                                                                                                    | :---                          |
| 041       | --                               | --                               | --                                  | Protected AND gate simulation for all input patterns with increased supply voltage                                      | [test041](output/test041.pdf) |
| 042       | --                               | --                               | --                                  | Protected OR gate simulation for all input patterns with increased supply voltage                                       | [test042](output/test042.pdf) |
| 043       | [PAND2X1.mag](magic/PAND2X1.mag) | [PAND2X1.lef](magic/PAND2X1.lef) | [PAND2X1.ext](magic/PAND2X1.ext)    | Protected AND gate simulation for all input patterns                                                                    | [test043](output/test043.pdf) |
| 044       | [POR2X1.mag](magic/POR2X1.mag)   | [POR2X1.lef](magic/POR2X1.lef)   | [POR2X1.ext](magic/POR2X1.ext)      | Protected OR gate simulation for all input patterns                                                                     | [test044](output/test044.pdf) |
| 045       | [PAND2X1.mag](magic/PAND2X1.mag) | [PAND2X1.lef](magic/PAND2X1.lef) | [PAND2X1.ext](magic/PAND2X1.ext)    | Protected AND gate simulation for all input patterns with voltage drops @ gate inputs                                   | [test045](output/test045.pdf) |
| 046       | [POR2X1.mag](magic/POR2X1.mag)   | [POR2X1.lef](magic/POR2X1.lef)   | [POR2X1.ext](magic/POR2X1.ext)      | Protected OR gate simulation for all input patterns  with voltage drops @ gate inputs                                   | [test046](output/test046.pdf) |
| 047       | --                               | --                               | --                                  | Protected OR gate simulation for all input patterns with increased supply voltage and 3rd/4th control inverter          | [test047](output/test047.pdf) |
| 048       | --                               | --                               | --                                  | Protected AND gate simulation for all input patterns with increased supply voltage and 3rd/4th control inverter         | [test048](output/test048.pdf) |

## Leakage and Model Correctness Validation
  * tests for validation of NMOS leakage and stack effects are denoted "05X"
  
| Test Name | Run Script | Gnuplot Script  |  Test Description                                     | Test Output                   |
| :---:     | :---       | :---            | :---                                                  | :---                          |
| 050       | test050.sh | test050.gnuplot | leakage simulation for different NAND gate layouts    | [test050](output/test050.pdf) |
| 051       | test051.sh | test051.gnuplot | NMOS stack Overlaps evaluation - subthreshold leakage | [test051](output/test051.pdf) |
| 052       | test052.sh | test052.gnuplot | NMOS illuminated stack Overlaps evaluation            | [test051](output/test052.pdf) |

## SecLib Evaluation
  * tests for SecLib evaluation "06X"
  * those tests are denoted "06X"
  * test running script name: "test06X.sh"
  * Gnuplot script: "test06X.gnuplot"
  * two graphs are provided as the test output:
    * voltage graph: both dual-rail output voltages
    * current graph: VDD/VSS node currents for all input patterns are provided
    
| Test Name |  Test Description                                                                                                                                                 | Test Output                                                                                                                   |
| :---:     | :---                                                                                                                                                              | :---                                                                                                                          |
| 060       | Dual-Rail SecLib simulation; dual-rail gate composed of dynamic C-elements;                                                                                       | [test060](output/test060.pdf) |
| 061       | Dual-Rail SecLib simulation; dual-rail gate composed of dynamic C-elements + one additional C-element is used to balance zero-input generation symetrization      | [test061](output/test061.pdf) |
