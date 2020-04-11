#!/bin/bash
#
# Execute all tests from specified group
#
# Params:
#  $1 - group: 0, 1, 2, 3, 5
#


# Group 0 -- Inverter
if [ "$1" = "0" ]
then

bash test00X.sh test001_buffer
bash test00X.sh test002_buffer
bash test00X.sh test003_buffer_modified
bash test00X.sh test004_buffer_modified
bash test00X.sh test005_inverter_modified
bash test00X.sh test006_inverter_modified
bash test00X.sh test008_inverter_fb
bash test00X.sh test009_inverter_parallel

gnuplot -c test00X.gnuplot results/test001_buffer.csv output/test001.pdf
gnuplot -c test00X.gnuplot results/test002_buffer.csv output/test002.pdf
gnuplot -c test00X.gnuplot results/test003_buffer_modified.csv output/test003.pdf
gnuplot -c test00X.gnuplot results/test004_buffer_modified.csv output/test004.pdf
gnuplot -c test00X.gnuplot results/test005_inverter_modified.csv output/test005.pdf
gnuplot -c test00X.gnuplot results/test006_inverter_modified.csv output/test006.pdf
gnuplot -c test00X.gnuplot results/test008_inverter_fb.csv output/test008.pdf
gnuplot -c test00X.gnuplot results/test009_inverter_parallel.csv output/test009.pdf

fi

# Group 1 -- NAND2/AND2
if [ "$1" = "1" ]
then

bash test01X.sh test010_nand_inverter
bash test01X.sh test011_nand_symmetry
bash test01X.sh test012_nand_symmetry_inverter
bash test01X.sh test013_nand_symmetry_inverter_serialR
bash test01X.sh test014_nand_all
bash test01X.sh test015_nand_stdCell
bash test01X.sh test016_nand_all_ModifiedInput
bash test01X.sh test017_and_stdCell
bash test01X.sh test018_nand_stdCell

gnuplot -c test01X.gnuplot results/test010_nand_inverter.csv output/test010.pdf
gnuplot -c test01X.gnuplot results/test011_nand_symmetry.csv output/test011.pdf
gnuplot -c test01X.gnuplot results/test012_nand_symmetry_inverter.csv output/test012.pdf
gnuplot -c test01X.gnuplot results/test013_nand_symmetry_inverter_serialR.csv output/test013.pdf
gnuplot -c test01X.gnuplot results/test014_nand_all.csv output/test014.pdf
gnuplot -c test01X.gnuplot results/test015_nand_stdCell.csv output/test015.pdf
gnuplot -c test01X.gnuplot results/test016_nand_all_ModifiedInput.csv output/test016.pdf
gnuplot -c test01X.gnuplot results/test017_and_stdCell.csv output/test017.pdf
gnuplot -c test01X.gnuplot results/test018_nand_stdCell.csv output/test018.pdf

# MC tests
ngspice test014_AND2_MC.spice > simOut 2>&1
ngspice test014_AND2_varInputMC.spice > simOut 2>&1

fi

# Group 2 -- NOR2/OR2
if [ "$1" = "2" ]
then

bash test02X.sh test020_nor_inverter
bash test02X.sh test021_or_stdCell
bash test02X.sh test022_nor_all
bash test02X.sh test023_nor

gnuplot -c test02X.gnuplot results/test020_nor_inverter.csv output/test020.pdf
gnuplot -c test02X.gnuplot results/test021_or_stdCell.csv output/test021.pdf
gnuplot -c test02X.gnuplot results/test022_nor_all.csv output/test022.pdf
gnuplot -c test02X.gnuplot results/test023_nor.csv output/test023.pdf

fi

# Group 3 -- Dynamic logic
if [ "$1" = "3" ]
then

bash test03X.sh test030_domino_and
bash test03X.sh test031_domino_and

gnuplot -c test03X.gnuplot results/test030_domino_and.csv output/test030.pdf
gnuplot -c test03X.gnuplot results/test031_domino_and.csv output/test031.pdf

fi

# Group 5 -- Dynamic logic
if [ "$1" = "5" ]
then

bash test050.sh
bash test051.sh
bash test052.sh

gnuplot -c test050.gnuplot
gnuplot -c test051.gnuplot
gnuplot -c test052.gnuplot

fi
