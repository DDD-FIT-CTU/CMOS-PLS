#!/bin/bash
#
# Run test00X and get results for changing C17 inputs
#
# Currents are produced in muAmps; voltages in milliVolts

inputs=5
initLevel="0V"
testName="test001_C17Illuminated"
laserPower=50

results="resultsInputs_${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "input pattern; currLaser" > $results

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
      echo "Vvin0 in0 0 0 PWL(0ns ${initLevel} 20ns ${initLevel} 22ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin0 in0 0 0 PWL(0ns ${initLevel} 20ns ${initLevel} 22ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 2) % 2" | bc )" == "1" ]
    then
      echo "Vvin1 in1 0 0 PWL(0ns ${initLevel} 21ns ${initLevel} 23ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin1 in1 0 0 PWL(0ns ${initLevel} 21ns ${initLevel} 23ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 4) % 2" | bc )" == "1" ]
    then
      echo "Vvin2 in2 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin2 in2 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 8) % 2" | bc )" == "1" ]
    then
      echo "Vvin3 in3 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin3 in3 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns 0V)" >> test00X_settings.inc
    fi
    
    if [ "$( echo "($i / 16) % 2" | bc )" == "1" ]
    then
      echo "Vvin4 in4 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns SUPP)" >> test00X_settings.inc
    else
      echo "Vvin4 in4 0 0 PWL(0ns ${initLevel} 22ns ${initLevel} 24ns 0V)" >> test00X_settings.inc
    fi
    
    cat test00X_settings.inc
    sleep 1
    
    peakVDD=$( ngspice $testName.spice | grep "i(vvdd)\[500\]" | awk '{print $3}' )
    
    peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
    peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
    
    echo "$inp; $peakVDD; " >> $results
done
