#!/bin/bash
#
# Run test004: get results for test 004+6
#
# Currents are produced in uA


#testName="test004_nmos"
testName="$1"

mkdir -p "results"

results="results/${testName}.csv"

echo "LaserPower; I_VDD" > $results


for laserPower in $( seq 0 50 1000 )
do
  echo -ne "$laserPower; " >> $results
  
  echo ".param showPlots = 0" > test004_settings.inc
  echo ".param pLaser = $laserPower" >> test004_settings.inc
  echo ".csparam pLaser = {pLaser}" >> test004_settings.inc
  
  cat test004_settings.inc
  
  # run ngSPICE
  ngspice $testName.spice > simOut01 2>&1
  
  # get I_vdd
  peakVDD=$( cat simOut01 | grep "i(vvdd)\[" | awk '{print $3}' )     
  peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
  peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
  
  echo "$peakVDD;  " >> $results
done
