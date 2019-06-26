#!/bin/bash
#
# Run test00X and get results for changing gate inputs
#
# Currents are produced in muAmps; voltages in milliVolts

inputs=2
initLevel="0V"
#testName="test006_INV1"
testName="test001_NAND2"
#testName="test002_NAND3"
#testName="test003_NOR2"
#testName="test004_NOR3"
#testName="test005_XOR2"

#initLevel="0V"
#testName="test007_dynamicNOR"
#testName="test008_dynamicNAND"

#initLevel="SUPP"
#testName="test009_dynamicNANDp"
#testName="test010_dynamicNORp"


results="results_${testName}.csv"
pow=$( echo "2^$inputs - 1" | bc )

echo "IN; currStatVDD; currStatVSS; currVDD; currVSS; out; " > $results

for i in $( seq 0 $pow )
do
    inp=$( echo "obase=02;$i" | bc )
    echo "Processing Input [$inp] ..."
    echo -ne "$inp; " >> $results
    
    echo ".param showPlots = 0" > test00X_settings.inc
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
    
    peakStatVDD=$( ngspice $testName.spice | grep "i(vvdd)) - 1" | awk -F"=" '{print $2}' )
    peakStatVSS=$( ngspice $testName.spice | grep "i(vvss)) - 1" | awk -F"=" '{print $2}' )
    
    peakVDD=$( ngspice $testName.spice | grep "i(vvdd))/2" | awk '{print $3}' )
    peakVSS=$( ngspice $testName.spice | grep "i(vvss))/2" | awk '{print $3}' )
    
    outv=$(    ngspice $testName.spice | grep "v(out)"  | awk '{print $3}' )
    
    peakStatVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakStatVDD" )
    peakStatVDD="$(echo "($peakStatVDD_new) * 1000000000" | bc -l )"
    peakStatVSS_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakStatVSS" )
    peakStatVSS="$(echo "($peakStatVSS_new) * 1000000000" | bc -l )"
    
    peakVDD_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVDD" )
    peakVDD="$(echo "($peakVDD_new) * 1000000" | bc -l )"
    peakVSS_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$peakVSS" )
    peakVSS="$(echo "($peakVSS_new) * 1000000" | bc -l )"
    outv_new=$( sed -E 's/([+-]?[0-9.]+)[eE]\+?(-?)([0-9]+)/(\1*10^(\2\3))/g' <<<"$outv" )
    outv="$(echo "$outv_new * 1000" | bc -l )"
    
    echo -ne "$peakStatVDD; $peakStatVSS; $peakVDD; $peakVSS; $outv" >> $results
  
  echo "" >> $results
done
