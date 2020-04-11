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

| Test Name | Test Description                                     | Test Output                   |
| :---:     | :---                                                 | :---                          |
| 030       | Domino AND gate                                      | [test030](output/test030.pdf) |
| 031       | Domino AND gate with weak keeper                     | [test031](output/test031.pdf) |


## Leakage and Model Correctness Validation
  * tests for validation of NMOS leakage and stack effects are denoted "05X"
  
| Test Name | Run Script | Gnuplot Script  |  Test Description                                     | Test Output                   |
| :---:     | :---       | :---            | :---                                                  | :---                          |
| 050       | test050.sh | test050.gnuplot | leakage simulation for different NAND gate layouts    | [test050](output/test050.pdf) |
| 051       | test051.sh | test051.gnuplot | NMOS stack Overlaps evaluation - subthreshold leakage | [test051](output/test051.pdf) |
| 052       | test052.sh | test052.gnuplot | NMOS illuminated stack Overlaps evaluation            | [test051](output/test052.pdf) |
