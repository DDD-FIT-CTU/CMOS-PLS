#!/bin/bash
#
# Run test050
#
# Currents are produced in nA; voltages in mV; times in ns

inputs=2
startIn="0"
initLevel="0V"
testName="test050_leakage"
gateVersions="AND2X1 NAND2X1 NAND2X1_INV NAND2X1_SYMMETRY NAND2X1_SYMMETRY_INV NAND2X1_SYMMETRY_INV_SERIALR NAND_ALL INVX1 2INVX1 NAND_ALL_CTRL_CENTER"

results="results/${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "Gate Version; Gate Index; I_00; I_01; I_10; I_11; " > $results

# create dir for traces
mkdir -p traces

gateIndex=0
for gateVersion in $( echo -ne "$gateVersions" )
do
  echo -ne "$gateVersion; $gateIndex; " >> $results
  
  for i in $( seq $startIn $pow )
  do
      inp=$( echo "obase=02;$i" | bc )
      echo "Processing Input [$inp] ..."
      
      echo ".param showPlots = 0" > test050_settings.inc
      echo ".param writeFile = 0" >> test050_settings.inc
      echo ".param gateVersion = gateVersion_$gateVersion" >> test050_settings.inc
      echo ".csparam gateVersion = {gateVersion}" >> test050_settings.inc
      echo "* --- inputs" >> test050_settings.inc
      
      if [ "$( echo "$i % 2" | bc )" = "1" ]
      then
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test050_settings.inc
      else
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test050_settings.inc
      fi
      
      if [ "$( echo "($i / 2) % 2" | bc )" == "1" ]
      then
        echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INHIGH)" >> test050_settings.inc
      else
        echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INLOW)" >> test050_settings.inc
      fi
      
      cat test050_settings.inc
      sleep 1
      
      # run ngSPICE
      ngspice $testName.spice > simOut05 2>&1
      
      # get I_vdd
      peakVDD=$( cat simOut05 | grep "i(vvdd)\[" | awk '{print $3}' )     
      peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
      peakVDD="$(echo "($peakVDD_new) * 1000000000" | bc -l )"
      
      echo -ne "$peakVDD; " >> $results
  done
  echo "" >> $results
  gateIndex=$(( $gateIndex + 1 ))
done
