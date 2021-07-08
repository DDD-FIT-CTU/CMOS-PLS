#!/bin/bash
#
# AES SBOX input gen
#
#

inputs=8
zeroLevel="0V"  # logic 0
oneLevel="SUPP" # logic 1
testName="test001_AES_SBOX"

pow=$( echo "2^$inputs - 1" | bc )

for i in $( seq 0 1 $pow )
do
    inp=$( echo "obase=02;$i" | bc )
    echo "Processing Input [$inp] ..."
    
    echo "if $&run_inputSet = $i" >> inputs.inc
    # -------------------------------------------------
    
    echo "  let foo = @Vvin0[PWL]" >> inputs.inc
    if [ "$( echo "($i / 1) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin0[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin1[PWL]" >> inputs.inc
    if [ "$( echo "($i / 2) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin1[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin2[PWL]" >> inputs.inc
    if [ "$( echo "($i / 4) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin2[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin3[PWL]" >> inputs.inc
    if [ "$( echo "($i / 8) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin3[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin4[PWL]" >> inputs.inc
    if [ "$( echo "($i / 16) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin4[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin5[PWL]" >> inputs.inc
    if [ "$( echo "($i / 32) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin5[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin6[PWL]" >> inputs.inc
    if [ "$( echo "($i / 64) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin6[PWL] = foo" >> inputs.inc
    
    echo "  let foo = @Vvin7[PWL]" >> inputs.inc
    if [ "$( echo "($i / 128) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputs.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputs.inc
    fi
    echo "  alter @Vvin7[PWL] = foo" >> inputs.inc
    
    echo "end" >> inputs.inc
    echo "" >> inputs.inc
    
done

cat inputs.inc
