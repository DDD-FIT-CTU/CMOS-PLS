#!/bin/bash
#
# Run test00X runner
#
# Currents are produced in milliAmps

inputs=8
startIn="$2"
stopIn="$3"
initLevel="0V"
testName="$4"
laserPower="$1"

results="resultsInputs_${testName}_${laserPower}mW.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "input; input pattern; currLaser" > $results

# create dir for traces
mkdir -p traces

#for i in $( seq $startIn $pow )
for i in $( seq $startIn $stopIn )
do
    inp=$( echo "obase=02;$i" | bc )
    echo "Processing Input [$inp] ..."

    echo ".param showPlots = 0" > test00X_settings.inc
    echo ".param run_inputSet = $i" >> test00X_settings.inc
    echo ".param pLaser = $laserPower" >> test00X_settings.inc
    echo ".csparam pLaser = {pLaser}" >> test00X_settings.inc
    
    cat test00X_settings.inc
    sleep 1
    
    peakVDD=$( ngspice $testName.spice | grep "i(vvdd)\[" | awk '{print $3}' )
    
    peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
    peakVDD="$(echo "($peakVDD_new) * 1000" | bc -l )"
    
    echo "$i; $inp; $peakVDD; " >> $results
    
    mv ivdd.out traces/${laserPower}_${i}_ivdd.out
    mv ivss.out traces/${laserPower}_${i}_ivss.out
    *mv sim.snap traces/${laserPower}_${i}_sim.snap
done
