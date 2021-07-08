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
    
    echo "if $&run_inputSet = $i" >> inputsD.inc
    # -------------------------------------------------
    
    echo "  let foo = @Vvin0[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 1) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin0[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin0D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 1) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin0D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin1[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 2) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin1[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin1D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 2) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin1D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin2[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 4) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin2[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin2D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 4) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin2D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin3[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 8) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin3[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin3D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 8) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin3D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin4[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 16) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin4[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin4D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 16) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin4D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin5[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 32) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin5[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin5D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 32) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin5D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin6[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 64) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin6[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin6D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 64) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin6D[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin7[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 128) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin7[PWL] = foo" >> inputsD.inc
    
    echo "  let foo = @Vvin7D[PWL]" >> inputsD.inc
    if [ "$( echo "($i / 128) % 2" | bc )" == "0" ]
    then
      echo "  let foo[5] = ${oneLevel}" >> inputsD.inc
    else
      echo "  let foo[5] = ${zeroLevel}" >> inputsD.inc
    fi
    echo "  alter @Vvin7D[PWL] = foo" >> inputsD.inc
    
    echo "end" >> inputsD.inc
    echo "" >> inputsD.inc
    
done

cat inputsD.inc
