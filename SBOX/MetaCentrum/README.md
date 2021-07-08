# Proces Simmulated Data


## Merge values from partitioned simmulation

```console
for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/100/100_${a}_ivdd_0.out pDualRail/100/100_${a}_ivdd_1.out pDualRail/100/100_${a}_ivdd_2.out pDualRail/100/100_${a}_ivdd_3.out -o pDualRail/100/100_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/100/100_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/200/200_${a}_ivdd_0.out pDualRail/200/200_${a}_ivdd_1.out pDualRail/200/200_${a}_ivdd_2.out pDualRail/200/200_${a}_ivdd_3.out -o pDualRail/200/200_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/200/200_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/300/300_${a}_ivdd_0.out pDualRail/300/300_${a}_ivdd_1.out pDualRail/300/300_${a}_ivdd_2.out pDualRail/300/300_${a}_ivdd_3.out -o pDualRail/300/300_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/300/300_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/400/400_${a}_ivdd_0.out pDualRail/400/400_${a}_ivdd_1.out pDualRail/400/400_${a}_ivdd_2.out pDualRail/400/400_${a}_ivdd_3.out -o pDualRail/400/400_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/400/400_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/500/500_${a}_ivdd_0.out pDualRail/500/500_${a}_ivdd_1.out pDualRail/500/500_${a}_ivdd_2.out pDualRail/500/500_${a}_ivdd_3.out -o pDualRail/500/500_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/500/500_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -f pDualRail/600/600_${a}_ivdd_0.out pDualRail/600/600_${a}_ivdd_1.out pDualRail/600/600_${a}_ivdd_2.out pDualRail/600/600_${a}_ivdd_3.out -o pDualRail/600/600_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm pDualRail/600/600_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/0/0_${a}_ivdd_0.out secLibDualRail/0/0_${a}_ivdd_1.out secLibDualRail/0/0_${a}_ivdd_2.out secLibDualRail/0/0_${a}_ivdd_3.out secLibDualRail/0/0_${a}_ivdd_4.out -o secLibDualRail/0/0_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/0/0_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/50/50_${a}_ivdd_0.out secLibDualRail/50/50_${a}_ivdd_1.out secLibDualRail/50/50_${a}_ivdd_2.out secLibDualRail/50/50_${a}_ivdd_3.out secLibDualRail/50/50_${a}_ivdd_4.out -o secLibDualRail/50/50_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/50/50_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/100/100_${a}_ivdd_0.out secLibDualRail/100/100_${a}_ivdd_1.out secLibDualRail/100/100_${a}_ivdd_2.out secLibDualRail/100/100_${a}_ivdd_3.out secLibDualRail/100/100_${a}_ivdd_4.out -o secLibDualRail/100/100_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/100/100_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/150/150_${a}_ivdd_0.out secLibDualRail/150/150_${a}_ivdd_1.out secLibDualRail/150/150_${a}_ivdd_2.out secLibDualRail/150/150_${a}_ivdd_3.out secLibDualRail/150/150_${a}_ivdd_4.out -o secLibDualRail/150/150_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/150/150_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/200/200_${a}_ivdd_0.out secLibDualRail/200/200_${a}_ivdd_1.out secLibDualRail/200/200_${a}_ivdd_2.out secLibDualRail/200/200_${a}_ivdd_3.out secLibDualRail/200/200_${a}_ivdd_4.out -o secLibDualRail/200/200_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/200/200_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/300/300_${a}_ivdd_0.out secLibDualRail/300/300_${a}_ivdd_1.out secLibDualRail/300/300_${a}_ivdd_2.out secLibDualRail/300/300_${a}_ivdd_3.out secLibDualRail/300/300_${a}_ivdd_4.out -o secLibDualRail/300/300_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/300/300_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/400/400_${a}_ivdd_0.out secLibDualRail/400/400_${a}_ivdd_1.out secLibDualRail/400/400_${a}_ivdd_2.out secLibDualRail/400/400_${a}_ivdd_3.out secLibDualRail/400/400_${a}_ivdd_4.out -o secLibDualRail/400/400_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/400/400_${a}_ivdd.out; fi; done

for a in $( seq 0 255 ); do echo "${a} ..."; python merge_timeVectors.py -r 49 -f secLibDualRail/500/500_${a}_ivdd_0.out secLibDualRail/500/500_${a}_ivdd_1.out secLibDualRail/500/500_${a}_ivdd_2.out secLibDualRail/500/500_${a}_ivdd_3.out secLibDualRail/500/500_${a}_ivdd_4.out -o secLibDualRail/500/500_${a}_ivdd.out; if [ "$?" = "1" ] ; then rm secLibDualRail/500/500_${a}_ivdd.out; fi; done
```

## Get CSVs

```console
bash get_csv.sh dualRail/50mW/traces dualRail_50mW
bash get_csv.sh dualRail/100mW/traces dualRail_100mW
bash get_csv.sh dualRail/150mW/traces dualRail_150mW
bash get_csv.sh dualRail/200mW/traces dualRail_200mW
bash get_csv.sh dualRail/300mW/traces dualRail_300mW
bash get_csv.sh dualRail/400mW/traces dualRail_400mW
bash get_csv.sh dualRail/500mW/traces dualRail_500mW
bash get_csv.sh dualRail/600mW/traces dualRail_600mW
# 
bash get_csv.sh dualRailAS/50mW/traces dualRailAS_50mW
bash get_csv.sh dualRailAS/100mW/traces dualRailAS_100mW
bash get_csv.sh dualRailAS/150mW/traces dualRailAS_150mW
bash get_csv.sh dualRailAS/200mW/traces dualRailAS_200mW
bash get_csv.sh dualRailAS/300mW/traces dualRailAS_300mW
bash get_csv.sh dualRailAS/400mW/traces dualRailAS_400mW
bash get_csv.sh dualRailAS/500mW/traces dualRailAS_500mW
bash get_csv.sh dualRailAS/600mW/traces dualRailAS_600mW
# 
bash get_csv.sh pDualRail/50mW/traces pDualRail_50mW
bash get_csv.sh pDualRail/100mW/traces pDualRail_100mW
bash get_csv.sh pDualRail/150mW/traces pDualRail_150mW
bash get_csv.sh pDualRail/200mW/traces pDualRail_200mW
bash get_csv.sh pDualRail/250mW/traces pDualRail_250mW
bash get_csv.sh pDualRail/300mW/traces pDualRail_300mW
bash get_csv.sh pDualRail/400mW/traces pDualRail_400mW
bash get_csv.sh pDualRail/500mW/traces pDualRail_500mW
bash get_csv.sh pDualRail/600mW/traces pDualRail_600mW
# 
bash get_csv.sh singleRail/50mW/traces singleRail_50mW
bash get_csv.sh singleRail/100mW/traces singleRail_100mW
bash get_csv.sh singleRail/150mW/traces singleRail_150mW
bash get_csv.sh singleRail/200mW/traces singleRail_200mW
bash get_csv.sh singleRail/300mW/traces singleRail_300mW
bash get_csv.sh singleRail/400mW/traces singleRail_400mW
bash get_csv.sh singleRail/500mW/traces singleRail_500mW
bash get_csv.sh singleRail/600mW/traces singleRail_600mW
#  
bash get_csv_seclib.sh secLibDualRail/50mW/traces secLibDualRail_50mW
bash get_csv_seclib.sh secLibDualRail/100mW/traces secLibDualRail_100mW
bash get_csv_seclib.sh secLibDualRail/150mW/traces secLibDualRail_150mW
bash get_csv_seclib.sh secLibDualRail/200mW/traces secLibDualRail_200mW
bash get_csv_seclib.sh secLibDualRail/300mW/traces secLibDualRail_300mW
bash get_csv_seclib.sh secLibDualRail/400mW/traces secLibDualRail_400mW
bash get_csv_seclib.sh secLibDualRail/500mW/traces secLibDualRail_500mW
bash get_csv_seclib.sh secLibDualRail/600mW/traces secLibDualRail_600mW

```

# Evaluation

## Share of Unique Bins depending on Measurement Resolution: drawComp.py
  * This works for all circuit types and all powers: static, dynamic and laser
  * Parameters:

```
    -l | --laser: laser power
    -b | --bin_size: bin size/measurement resolution (reduction)
    -p | --poi: select POI: 0 == laser-induced imprint; 1 == static power; 2 == dynamic power
    -g | --gauss: show gaussian curve to illustrate dataset variance
    -f | --file: output pdf file
```
    
### Example
  * plot # of bins for every circuit type and resolution for 200mW laser power
  
```console
python drawComp.py -l 200
```

### Example
  * power imprint variances for all datasets, given laser power and POI

  ```console
python drawComp.py -l 200 -b -6 -p 0 -g
```  

## Laser-Induced Static Power: drawComp2.py

  * Parameters:

```
    -b | --bin_size: size of bin/measurement resolution: 3 -> mA; 6 -> uA; 9 -> pA
    -l | --largest: plot largest bin
    -d | --deviation: plot deviations
    -f | --fifty: plot # of bins with at least 50% of traces
    default: plot # of bins
```
    
### Example
  * plot # of bins with at least 50% of traces with (bin) resolution 1mA
  
```console
python drawComp2.py -b 3 -f
```

## Difference of Means Method as a Function of Bit used as a Distinguisher

SBOX input is used as distinguisher:

```console
for ctype in $( echo "singleRail dualRail dualRailAS pDualRail" )
do
   for current in $( seq 0 1 2 )
   do   
     for bit in $( seq 0 1 7 )
     do
       if [ -e diffMeans2/${ctype}_200mW_${current}_${bit}.csv ]
       then
         continue
       fi
       echo "diffMeans2/${ctype}_200mW_${current}_${bit}.csv"
       for N in $( seq 1 1 100 )
       do 
         echo -ne "$N; " >> diffMeans2/${ctype}_200mW_${current}_${bit}.csv
         python3 getDiffOfMeans.py -f ${ctype}_200mW.csv -v -b 16 -i ${bit} -p ${current} >> diffMeans2/${ctype}_200mW_${current}_${bit}.csv
       done
     done
   done
done

python drawDiffMeanResults.py -d diffMeans_1uA
```

  * Output is the graph indicating how many vectors (the mean value) is needed to get meaningfull difference in diifferenceOfMeans method
