# Tests

This directory contains simple tests for particular (sub)circuit(s). Tests are used for lightweight validation or functional view of basic models.

## PLS of CMOS Models
Circuit models used for PLS of CMOS are exercised in tests 001 - 007.

For details, see referenced papers [1], [2] and [3].

## Generating Important Graphs

```console
$ # NMOS + PMOS
$ bash test004+6.sh test004_nmos
$ bash test004+6.sh test006_pmos
$ gnuplot -c test004+6.gnuplot results/test004_nmos.csv results/test006_pmos.csv output/test004+6.pdf
$
$ # INVERTER
$ bash test009.sh test009_invGate
$ gnuplot -c test009.gnuplot results/test009_invGate.csv output/test009.pdf
```

## Basic Standard Cell Simulation
Basic standard cell simulation files are provided: test 007 - 013.

## TSMC180nm Subthreshold Leakage Model
The TSMC180nm [Subthreshold Leakage Model](output/output/test014_Vgs_Vds_Vsb.pdf) in GNUplot for NMOS transistor with 0.2u x 2.0u channel is provided; and the [Temperature Dependency Leakage Model](output/output/output/test014_Vgs_Vsb_Temp.pdf) is provided.

The ngSPICE simulation [file](test014_nmosSubthresholdLeakage.spice) is also available.
