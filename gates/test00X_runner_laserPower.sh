#!/bin/bash
#
# Run test00X and get results for changing gate inputs
#
# Currents are produced in muAmps; voltages in milliVolts

inputs=2
initLevel="0V"
#testName="test006_INV1"
#testName="test001_NAND2"
#testName="test003_NOR2"
testName="test005_XOR2"
#testName="test004_NOR3"
#testName="test002_NAND3"

results="resultsMovinLaserPower_${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "LaserPower; currStatVDD/00; currStatVDD/01; currStatVDD/10; currStatVDD/11 " > $results

for laserPower in $( seq 50 50 1000 )
do
  echo -ne "$laserPower; " >> $results
  for i in $( seq 0 $pow )
  do
    inp=$( echo "obase=02;$i" | bc )
    echo "Processing Input [$inp] ..."
    
    echo ".param showPlots = 0" > test00X_settings.inc
    echo ".param pLaser = $laserPower" >> test00X_settings.inc
    echo ".csparam pLaser = {pLaser}" >> test00X_settings.inc
    echo "* --- inputs" >> test00X_settings.inc
    
    if [ "$( echo "$i % 2" | bc )" = "1" ]
    then
      echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 20ns SUPP 22ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin0 A 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 20ns 0V 22ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 2) % 2" | bc )" == "1" ]
    then
      echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 21ns SUPP 22ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin1 B 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 21ns 0V 22ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 4) % 2" | bc )" == "1" ]
    then
      echo "Vvin2 C 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 22ns SUPP 22ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin2 C 0 0 PWL(0ns ${initLevel} 18ns ${initLevel} 22ns 0V 22ns 0V)" >> test00X_settings.inc
    fi
    
    cat test00X_settings.inc
    sleep 1
    
    peakVDD=$( ngspice $testName.spice | grep "i(vvdd))/2" | awk '{print $3}' )
    
    peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
    peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
    
    echo -ne "$peakVDD; " >> $results
  done
  
  echo ";" >> $results
done
