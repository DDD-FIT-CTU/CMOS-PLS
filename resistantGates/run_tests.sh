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
# ngspice test014_AND2_MC.spice > simOut 2>&1
# ngspice test014_AND2_varInputMC.spice > simOut 2>&1

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
gnuplot -c test03X_joined.gnuplot results/test030_domino_and.csv results/test031_domino_and.csv output/test030+31.pdf

fi

# Group 4 -- MAGIC layouts
if [ "$1" = "4" ]
then

# bash test04X.sh test040_and_strong_serial_pmos
# bash test04X.sh test041_and_weak_serial_pmos
# bash test04X.sh test042_and_weak_serial_pmos_nolightdet

bash test04X.sh test041_and_incSupp
bash test04X.sh test042_or_incSupp
bash test04X.sh test043_and_final
bash test04X.sh test044_or_final
bash test04X.sh test045_and_final_affectedInputs
bash test04X.sh test046_or_final_affectedInputs
bash test04X.sh test047_or_3rdCtrlInverter
bash test04X.sh test048_and_3rdCtrlInverter
bash test04X.sh test049_and_final

# gnuplot -c test04X.gnuplot results/test040_and_strong_serial_pmos.csv output/test040.pdf
# gnuplot -c test04X.gnuplot results/test041_and_weak_serial_pmos.csv output/test041.pdf
# gnuplot -c test04X.gnuplot results/test042_and_weak_serial_pmos_nolightdet.csv output/test042.pdf

gnuplot -c test04X.gnuplot results/test041_and_incSupp.csv output/test041.pdf
gnuplot -c test04X.gnuplot results/test042_or_incSupp.csv output/test042.pdf
gnuplot -c test04X.gnuplot results/test043_and_final.csv output/test043.pdf
gnuplot -c test04X.gnuplot results/test044_or_final.csv output/test044.pdf
gnuplot -c test04X.gnuplot results/test045_and_final_affectedInputs.csv output/test045.pdf
gnuplot -c test04X.gnuplot results/test046_or_final_affectedInputs.csv output/test046.pdf
gnuplot -c test04X.gnuplot results/test047_or_3rdCtrlInverter.csv output/test047.pdf
gnuplot -c test04X.gnuplot results/test048_and_3rdCtrlInverter.csv output/test048.pdf
gnuplot -c test04X.gnuplot results/test049_and_final.csv output/test049.pdf

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

# Group 6 -- SecLib
if [ "$1" = "6" ]
then

bash test06X.sh test060_secLib
bash test06X.sh test061_secLib_opt

gnuplot -c test06X.gnuplot results/test060_secLib.csv output/test060.pdf
gnuplot -c test06X.gnuplot results/test061_secLib_opt.csv output/test061.pdf

fi
