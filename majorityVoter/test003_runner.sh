#!/bin/bash
#
# Run test003 and get results for laser moving across the NAND gate array
#
#

results="results.csv"

echo "x; y; peak0; peak1; " > $results

for x in $( seq 0 5 )
do
  for y in $( seq 0 1 )
  do
    echo "Processing position [$x, $y] ..."
    echo -ne "$x; $y; " >> $results
    for value in $( seq 0 1 )
    do
      echo ".param laserLocationX = $x" > test003_settings.inc
      echo ".param laserlocationY = $y" >> test003_settings.inc
      echo ".param majorityInputValue = $value" >> test003_settings.inc
      echo ".param showPlots = 0" >> test003_settings.inc
      peak=$( ngspice test003_laserPositionMoved.spice | grep "i(vvdd)" | awk '{print $3}' )
      echo -ne "$peak;" >> $results
    done
    echo "" >> $results
  done
done
