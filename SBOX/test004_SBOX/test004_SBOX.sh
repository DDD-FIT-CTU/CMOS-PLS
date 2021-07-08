#!/bin/bash
#
# Run test004 partitioned runner
#

inputs=8
startIn="$2"
stopIn="$3"
testName="$4"
laserPower="$1"

# create dir for traces
mkdir -p traces

# pow=$( echo "2^$inputs - 1" | bc )
# for i in $( seq $startIn $pow )
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
    
    ngspice test004_SBOX_0.spice
    python3 out2PWL.py -f outputs_0.out -o outputs_0.plw
    #python3 out2PWL.py -f outputs_0.out -o outputs_0.plw -w 0.1 
    
    ngspice test004_SBOX_1.spice
    python3 out2PWL.py -f outputs_1.out -o outputs_1.plw
    #python3 out2PWL.py -f outputs_1.out -o outputs_1.plw -w 0.1 
    
    ngspice test004_SBOX_2.spice
    python3 out2PWL.py -f outputs_2.out -o outputs_2.plw
    #python3 out2PWL.py -f outputs_2.out -o outputs_2.plw -w 0.1 
    
    ngspice test004_SBOX_3.spice
    python3 out2PWL.py -f outputs_3.out -o outputs_3.plw
    #python3 out2PWL.py -f outputs_3.out -o outputs_3.plw -w 0.1 
    
    mv ivdd_0.out traces/${laserPower}_${i}_ivdd_0.out
    mv ivdd_1.out traces/${laserPower}_${i}_ivdd_1.out
    mv ivdd_2.out traces/${laserPower}_${i}_ivdd_2.out
    mv ivdd_3.out traces/${laserPower}_${i}_ivdd_3.out
    
    mv ivss_0.out traces/${laserPower}_${i}_ivss_0.out
    mv ivss_1.out traces/${laserPower}_${i}_ivss_1.out
    mv ivss_2.out traces/${laserPower}_${i}_ivss_2.out
    mv ivss_3.out traces/${laserPower}_${i}_ivss_3.out
    
#     mv sim_0.snap traces/${laserPower}_${i}_sim_0.snap
#     mv sim_1.snap traces/${laserPower}_${i}_sim_1.snap
#     mv sim_2.snap traces/${laserPower}_${i}_sim_2.snap
#     mv sim_3.snap traces/${laserPower}_${i}_sim_3.snap
    
    mv outputs_0.out traces/${laserPower}_${i}_outputs_0.out
    mv outputs_1.out traces/${laserPower}_${i}_outputs_1.out
    mv outputs_2.out traces/${laserPower}_${i}_outputs_2.out
    mv outputs_3.out traces/${laserPower}_${i}_outputs_3.out
    
    mv outputs_0.plw traces/${laserPower}_${i}_outputs_0.plw
    mv outputs_1.plw traces/${laserPower}_${i}_outputs_1.plw
    mv outputs_2.plw traces/${laserPower}_${i}_outputs_2.plw
    mv outputs_3.plw traces/${laserPower}_${i}_outputs_3.plw
    
    python merge_timeVectors.py -f traces/${laserPower}_${i}_ivdd_0.out traces/${laserPower}_${i}_ivdd_1.out traces/${laserPower}_${i}_ivdd_2.out traces/${laserPower}_${i}_ivdd_3.out -o traces/${laserPower}_${i}_ivdd.out
    
     if [ "$?" = "1" ]
     then
       rm traces/${laserPower}_${i}_ivdd.out
     fi
done