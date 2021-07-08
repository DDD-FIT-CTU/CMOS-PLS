#!/bin/bash
#
# Run test04X: get results for test 04X
#
# Currents are produced in uA; voltages in mV; times in ns

inputs=2
startIn="0"
initLevel="0V"
testName="$1"

results="results/${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "LaserPower; I_00; V_Y00; V_O00; V_CTRL00; V_CTRL200; I_01; V_Y01; V_O01; V_CTRL01; V_CTRL201; I_10; V_Y10; V_O10; V_CTRL10; V_CTRL210; I_11; V_Y11; V_O11; V_CTRL11; V_CTRL211; " > $results

# create dir for traces
mkdir -p traces

for laserPower in $( seq 0 1 1000 )
do
  echo -ne "$laserPower; " >> $results
  
  for i in $( seq $startIn $pow )
  do
      inp=$( echo "obase=02;$i" | bc )
      echo "Processing Input [$inp] ..."
      
      echo ".param showPlots = 0" > test04X_settings.inc
      echo ".param writeFile = 0" >> test04X_settings.inc
      echo ".param pLaser = $laserPower" >> test04X_settings.inc
      echo ".csparam pLaser = {pLaser}" >> test04X_settings.inc
      echo "* --- inputs" >> test04X_settings.inc
      
      if [ "$( echo "$i % 2" | bc )" = "1" ]
      then
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INHIGH)" >> test04X_settings.inc
      else
        echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 30ns ${initLevel} 31ns INLOW)" >> test04X_settings.inc
      fi
      
      if [ "$( echo "($i / 2) % 2" | bc )" == "1" ]
      then
        echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INHIGH)" >> test04X_settings.inc
      else
        echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 31ns ${initLevel} 32ns INLOW)" >> test04X_settings.inc
      fi
      
      cat test04X_settings.inc
      sleep 1
      
      # run ngSPICE
      ngspice $testName.spice > simOut04 2>&1
      
      # get I_vdd
      peakVDD=$( cat simOut04 | grep "i(vvdd)\[" | awk '{print $3}' )     
      peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
      peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
      
      # get V_in
      vin=$( cat simOut04  | grep "v(y)\[" | awk '{print $3}' )
      vin=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vin" )
      vin="$(echo "($vin)" | bc -l )"
      
      # get V_o
      vo=$( cat simOut04  | grep "v(o)\[" | awk '{print $3}' )
      vo=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vo" )
      vo="$(echo "($vo)" | bc -l )"
      
      # get V_ctrl
      vctrl=$( cat simOut04  | grep "v(ctrl)\[" | awk '{print $3}' )
      vctrl=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vctrl" )
      vctrl="$(echo "($vctrl)" | bc -l )"
      
      # get V_ctrl2
      vctrl2=$( cat simOut04  | grep "v(ctrl2)\[" | awk '{print $3}' )
      vctrl2=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$vctrl2" )
      vctrl2="$(echo "($vctrl2)" | bc -l )"
      
      echo -ne "$peakVDD; $vin; $vo; $vctrl; $vctrl2; " >> $results
  done
  echo "" >> $results
done
