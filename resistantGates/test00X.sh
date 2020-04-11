#!/bin/bash
#
# Run test00X: get results for test 00X
#
# Currents are produced in uA; voltages in mV; times in ns

inputs=1
startIn="0"
initLevel="0V"
testName="$1"

results="results/${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "LaserPower; I_0; V_in0; V_o0; I_1; V_in1; V_o1;" > $results

# create dir for traces
mkdir -p traces

for laserPower in $( seq 0 50 1000 )
do
  echo -ne "$laserPower; " >> $results
  
  for i in $( seq $startIn $pow )
  do
      inp=$( echo "obase=02;$i" | bc )
      echo "Processing Input [$inp] ..."
      
      echo ".param showPlots = 0" > test00X_settings.inc
      echo ".param writeFile = 0" >> test00X_settings.inc
      echo ".param pLaser = $laserPower" >> test00X_settings.inc
      echo ".csparam pLaser = {pLaser}" >> test00X_settings.inc
      echo "* --- inputs" >> test00X_settings.inc
      
      if [ "$( echo "$i % 2" | bc )" = "1" ]
      then
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test00X_settings.inc
      else
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test00X_settings.inc
      fi
      
      cat test00X_settings.inc
      sleep 1
      
      # run ngSPICE
      ngspice $testName.spice > simOut 2>&1
      
      # get I_vdd
      peakVDD=$( cat simOut | grep "i(vvdd)\[" | awk '{print $3}' )     
      peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
      peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
      
      # get V_in
      vin=$( cat simOut  | grep "v(xbuff.o1)\[" | awk '{print $3}' )
      vin=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vin" )
      vin="$(echo "($vin)" | bc -l )"
      
      # get V_o
      vo=$( cat simOut  | grep "v(o)\[" | awk '{print $3}' )
      vo=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vo" )
      vo="$(echo "($vo)" | bc -l )"
      
      echo -ne "$peakVDD; $vin; $vo; " >> $results
  done
  echo "" >> $results
done
