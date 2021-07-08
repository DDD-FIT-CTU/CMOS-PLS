#!/bin/bash
#
# Run test00X: get results for test 06X
#
# Currents are produced in uA; voltages in mV; times in ns

inputs=2
startIn="0"
initLevel="0V"
testName="$1"

results="results/${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "LaserPower; I_00; V_Y100; V_Y000; I_01; V_Y101; V_Y001; I_10; V_Y110; V_Y010; I_11; V_Y111; V_Y011;" > $results

# create dir for traces
mkdir -p traces

for laserPower in $( seq 0 1 1000 )
do
  echo -ne "$laserPower; " >> $results
  
  for i in $( seq $startIn $pow )
  do
      inp=$( echo "obase=02;$i" | bc )
      echo "Processing Input [$inp] ..."
      
      echo ".param showPlots = 0" > test06X_settings.inc
      echo ".param writeFile = 0" >> test06X_settings.inc
      echo ".param pLaser = $laserPower" >> test06X_settings.inc
      echo ".csparam pLaser = {pLaser}" >> test06X_settings.inc
      echo "* --- inputs" >> test06X_settings.inc
      
      if [ "$( echo "$i % 2" | bc )" = "1" ]
      then
        echo "Vvin00 A0 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test06X_settings.inc
        echo "Vvin01 A1 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test06X_settings.inc
      else
        echo "Vvin00 A0 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test06X_settings.inc
        echo "Vvin01 A1 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test06X_settings.inc
      fi
      
      if [ "$( echo "($i / 2) % 2" | bc )" == "1" ]
      then
        echo "Vvin10 B0 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INLOW)" >> test06X_settings.inc
        echo "Vvin11 B1 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INHIGH)" >> test06X_settings.inc
      else
        echo "Vvin10 B0 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INHIGH)" >> test06X_settings.inc
        echo "Vvin11 B1 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INLOW)" >> test06X_settings.inc
      fi
      
      cat test06X_settings.inc
      sleep 1
      
      # run ngSPICE
      ngspice $testName.spice > simOut06 2>&1
      
      # get I_vdd
      peakVDD=$( cat simOut06 | grep "i(vvdd)\[" | awk '{print $3}' )     
      peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
      peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
      
      # get V_y0
      vin=$( cat simOut06  | grep "v(y0)\[" | awk '{print $3}' )
      vin=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vin" )
      vin="$(echo "($vin)" | bc -l )"
      
      # get V_y1
      vo=$( cat simOut06  | grep "v(y1)\[" | awk '{print $3}' )
      vo=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vo" )
      vo="$(echo "($vo)" | bc -l )"
      
      echo -ne "$peakVDD; $vin; $vo; " >> $results
  done
  echo "" >> $results
done
