#!/bin/bash
#
# Run test00X: get results for test 009
#
# Currents are produced in uA; voltages in mV; times in ns

startIn="0"
initLevel="0V"
testName="test009_invGate"

results="results/${testName}.csv"

echo "LaserPower; I_0; V_Y; I_1; V_Y;" > $results

# create dir for traces
mkdir -p traces

for laserPower in $( seq 0 1 600 )
do
  echo -ne "$laserPower; " >> $results
  
  for i in $( seq 0 1 )
  do
      inp=$( echo "obase=02;$i" | bc )
      echo "Processing Input [$inp] ..."
      
      echo ".param showPlots = 0" > test009_settings.inc
      echo ".param writeFile = 0" >> test009_settings.inc
      echo ".param pLaser = $laserPower" >> test009_settings.inc
      echo ".csparam pLaser = {pLaser}" >> test009_settings.inc
      echo "* --- inputs" >> test009_settings.inc
      
      if [ "$( echo "$i % 2" | bc )" = "1" ]
      then
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test009_settings.inc
      else
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test009_settings.inc
      fi
      
      cat test009_settings.inc
      sleep 1
      
      # run ngSPICE
      ngspice $testName.spice > simOut01 2>&1
      
      # get I_vdd
      peakVDD=$( cat simOut01 | grep "i(vvdd)\[" | awk '{print $3}' )     
      peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
      peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
      
      # get V_y
      vy=$( cat simOut01  | grep "v(y)\[" | awk '{print $3}' )
      vy=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vy" )
      vy="$(echo "($vy)" | bc -l )"
      
      echo -ne "$peakVDD; $vy; " >> $results
  done
  echo "" >> $results
done
