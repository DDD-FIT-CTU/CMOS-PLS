#!/bin/bash
#
# Extract data from power traces: 
#              - circuit static power
#              - circuit dynamic power 
#              - circuit static power under laser illumination
#
# $1 - dataSet PATH
# $2 - output file PATH

echo "P [mW]; data_bin; data_hex; data_dec; hamming_in; hamming_out; time [ns]; I (static) [A]; I (dynamic) [A]; time [ns]; I (laser) [A]" > ${2}.csv

for fname in $( ls $1 | sort | grep "ivdd.out" )
do
    f=$( echo "${1}/${fname}" | sed -e 's://:/:g' )
    echo "$f ..."
    
    pow=$( echo $fname | awk -F"_" '{print $1}' )
    dat_dec=$( echo $fname | awk -F"_" '{print $2}' )
    dat_bin=$( echo "obase=02;$dat_dec" | bc )
    dat_hex=$( printf '%X\n' "$((2#$dat_bin))" )
    hamming_tmp=$( echo "$dat_bin" | tr -d "0" | wc -c )
    hamming_in=$(( $hamming_tmp - 1 ))
    sbox_out_dec=$( python3 get_sbox.py -i $dat_dec )
    sbox_out_bin=$( echo "obase=2;$sbox_out_dec" | bc )
    hamming_tmp=$( echo "$sbox_out_bin" | tr -d "0" | wc -c )
    hamming_out=$(( $hamming_tmp - 1 ))
    static=$( python3 get_val.py -f $f -t 0.000000040 )
    dynamic=$( python3 get_int.py -f $f -s .000000005 -e .000000030 )
    laser=$( python3 get_val.py -f $f -t 0.000000045 )
    
    echo "$pow; $dat_bin; $dat_hex; $dat_dec; $hamming_in; $hamming_out; $static; $dynamic; $laser"
    echo "$pow; $dat_bin; $dat_hex; $dat_dec; $hamming_in; $hamming_out; $static; $dynamic; $laser" >> ${2}.csv
    
done
