#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 09/2020
#
# Plot Laser power vs. BIN cnt
#

import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
import statistics 

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Draw data.')
parser.add_argument('-b', '--bin_size', help='Bin size', type=int, default=5)
parser.add_argument('-l', '--largest', help='Largest bin size', action='store_true', default=False)
parser.add_argument('-d', '--deviation', help='Display deviations', action='store_true', default=False)
parser.add_argument('-f', '--fifty', help='In how many bins is 50% of traces', action='store_true', default=False)
args = parser.parse_args()

#LASER_POWERS = [50, 100, 150, 200, 300, 400, 500, 600]
LASER_POWERS = [100, 200, 300, 400, 500, 600]

DATASET_MARKER=['o', '^', 'x', 'D']
DATASET_DATA=[]

BIN_COUNTS_SINGLE = []
BIN_COUNTS_DR = []
BIN_COUNTS_DRAS = []
BIN_COUNTS_PDR = []

DEVIATIONS_SINGLE = []
DEVIATIONS_DR = []
DEVIATIONS_DRAS = []
DEVIATIONS_PDR = []

LARGEST_SINGLE = []
LARGEST_DR = []
LARGEST_DRAS = []
LARGEST_PDR = []

FIFTY_SINGLE = []
FIFTY_DR = []
FIFTY_DRAS = []
FIFTY_PDR = []

FIFTY_BORDER=0.5

INDEX_LASER = 10
TRACES=[]

for lp in LASER_POWERS:
    DATASET_DATA.append(np.genfromtxt("singleRail_" + str(lp) + "mW.csv", delimiter=';'))
    DATASET_DATA.append(np.genfromtxt("dualRail_" + str(lp) + "mW.csv", delimiter=';'))
    DATASET_DATA.append(np.genfromtxt("dualRailAS_" + str(lp) + "mW.csv", delimiter=';'))
    DATASET_DATA.append(np.genfromtxt("pDualRail_" + str(lp) + "mW.csv", delimiter=';'))

mult = 10.0 ** (-1 * args.bin_size)

for i in range(0,len(DATASET_DATA)):
    TRACES.append(len((DATASET_DATA[i])[:, INDEX_LASER]) - 1)

for lp in range(0,len(LASER_POWERS)):
    dataset = 0 + lp * 4
    
    tmpArray = []
    for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_LASER])):
        tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_LASER]/mult))
    BIN_COUNTS_SINGLE.append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
    DEVIATIONS_SINGLE.append(statistics.stdev((DATASET_DATA[dataset])[1:-1, INDEX_LASER])*1000)
    # Compute the given set mode
    mode = statistics.mode(tmpArray)
    # get the biggest bin size
    biggest = tmpArray.count(mode)
    LARGEST_SINGLE.append(100*biggest/TRACES[dataset])
    # compute # of bins, where 50% of traces is stored
    summ = biggest
    cnt = 1
    while summ < TRACES[dataset] * FIFTY_BORDER:
        tmpArray = [i for i in tmpArray if i != mode]
        mode = statistics.mode(tmpArray)
        summ = summ + tmpArray.count(mode)
        cnt = cnt + 1
    FIFTY_SINGLE.append(cnt)    
    
    dataset = 1 + lp * 4
    
    tmpArray = []
    for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_LASER])):
        tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_LASER]/mult))
    BIN_COUNTS_DR.append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
    DEVIATIONS_DR.append(statistics.stdev((DATASET_DATA[dataset])[1:-1, INDEX_LASER])*1000)
    # Compute the given set mode
    mode = statistics.mode(tmpArray)
    # get the biggest bin size
    biggest = tmpArray.count(mode)
    LARGEST_DR.append(100*biggest/TRACES[dataset])
    # compute # of bins, where 50% of traces is stored
    summ = biggest
    cnt = 1
    while summ < TRACES[dataset] * FIFTY_BORDER:
        tmpArray = [i for i in tmpArray if i != mode]
        mode = statistics.mode(tmpArray)
        summ = summ + tmpArray.count(mode)
        cnt = cnt + 1
    FIFTY_DR.append(cnt)    
    
    dataset = 2 + lp * 4
    
    tmpArray = []
    for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_LASER])):
        tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_LASER]/mult))
    BIN_COUNTS_DRAS.append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
    DEVIATIONS_DRAS.append(statistics.stdev((DATASET_DATA[dataset])[1:-1, INDEX_LASER])*1000)
    # Compute the given set mode
    mode = statistics.mode(tmpArray)
    # get the biggest bin size
    biggest = tmpArray.count(mode)
    LARGEST_DRAS.append(100*biggest/TRACES[dataset])
    # compute # of bins, where 50% of traces is stored
    summ = biggest
    cnt = 1
    while summ < TRACES[dataset] * FIFTY_BORDER:
        tmpArray = [i for i in tmpArray if i != mode]
        mode = statistics.mode(tmpArray)
        summ = summ + tmpArray.count(mode)
        cnt = cnt + 1
    FIFTY_DRAS.append(cnt)    
    
    dataset = 3 + lp * 4
    
    tmpArray = []
    for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_LASER])):
        tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_LASER]/mult))
    BIN_COUNTS_PDR.append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
    DEVIATIONS_PDR.append(statistics.stdev((DATASET_DATA[dataset])[1:-1, INDEX_LASER])*1000)
    # Compute the given set mode
    mode = statistics.mode(tmpArray)
    # get the biggest bin size
    biggest = tmpArray.count(mode)
    LARGEST_PDR.append(100*biggest/TRACES[dataset])
    # compute # of bins, where 50% of traces is stored
    summ = biggest
    cnt = 1
    while summ < TRACES[dataset] * FIFTY_BORDER:
        tmpArray = [i for i in tmpArray if i != mode]
        mode = statistics.mode(tmpArray)
        summ = summ + tmpArray.count(mode)
        cnt = cnt + 1
    FIFTY_PDR.append(cnt)    
        


    
if args.largest == True:
    plt.plot(LASER_POWERS, LARGEST_SINGLE, ls='--', marker=DATASET_MARKER[0], label="Single Rail")
    plt.plot(LASER_POWERS, LARGEST_DR, ls=':', marker=DATASET_MARKER[1], label="Dual Rail")
    plt.plot(LASER_POWERS, LARGEST_DRAS, ls='-', marker=DATASET_MARKER[2], label="Dual Rail AS")
    plt.plot(LASER_POWERS, LARGEST_PDR, ls='-.', marker=DATASET_MARKER[3], label="Protected Dual Rail")
        
    plt.ylim(0, 100)
    plt.ylabel("Biggest Bin [%]")
    
    plt.xlim(min(LASER_POWERS), max(LASER_POWERS))
    plt.xlabel("Laser Power [mW]")
    plt.legend(loc='best')
    plt.show()
if args.fifty == True:
    #plt.plot(LASER_POWERS, FIFTY_SINGLE, ls='--', marker=DATASET_MARKER[0], label="Single Rail")
    #plt.plot(LASER_POWERS, FIFTY_DR, ls=':', marker=DATASET_MARKER[1],      label="Dual Rail")
    #plt.plot(LASER_POWERS, FIFTY_DRAS, ls='-', marker=DATASET_MARKER[2],    label="Dual Rail AS")
    #plt.plot(LASER_POWERS, FIFTY_PDR, ls='-.', marker=DATASET_MARKER[3],    label="Protected Dual Rail")

    y_pos = np.arange(len(LASER_POWERS))
    plt.bar(y_pos-0.30, FIFTY_SINGLE, align='center', alpha=0.5, width=0.15, label="Single Rail")
    plt.bar(y_pos-0.10, FIFTY_DR,     align='center', alpha=0.5, width=0.15, label="Dual Rail")
    plt.bar(y_pos+0.10, FIFTY_DRAS,   align='center', alpha=0.5, width=0.15, label="Dual Rail AS")
    plt.bar(y_pos+0.30, FIFTY_PDR,    align='center', alpha=0.5, width=0.15, label="Protected Dual Rail")
    NAMES = [str(i) for i in LASER_POWERS]
    plt.xticks(y_pos, NAMES)
    plt.ylabel("# of Bin with at least 50% of Traces")
    
    plt.legend(loc='best')
    plt.show()
elif args.deviation == True:
    plt.plot(LASER_POWERS,DEVIATIONS_SINGLE, ls='--', marker=DATASET_MARKER[0], label="Single Rail")
    plt.plot(LASER_POWERS,DEVIATIONS_DR, ls=':', marker=DATASET_MARKER[1], label="Dual Rail")
    plt.plot(LASER_POWERS,DEVIATIONS_DRAS, ls='-', marker=DATASET_MARKER[2], label="Dual Rail AS")
    plt.plot(LASER_POWERS,DEVIATIONS_PDR, ls='-.', marker=DATASET_MARKER[3], label="Protected Dual Rail")
        
    #plt.ylim(0, 100)
    plt.ylabel("Value Deviations [mA]")
    
    plt.xlim(min(LASER_POWERS), max(LASER_POWERS))
    plt.xlabel("Laser Power [mW]")
    plt.legend(loc='best')
    plt.show()
else:
    plt.plot(LASER_POWERS, BIN_COUNTS_SINGLE, ls='--', marker=DATASET_MARKER[0], label="Single Rail")
    plt.plot(LASER_POWERS, BIN_COUNTS_DR, ls=':', marker=DATASET_MARKER[1], label="Dual Rail")
    plt.plot(LASER_POWERS, BIN_COUNTS_DRAS, ls='-', marker=DATASET_MARKER[2], label="Dual Rail AS")
    plt.plot(LASER_POWERS, BIN_COUNTS_PDR, ls='-.', marker=DATASET_MARKER[3], label="Protected Dual Rail")
        
    plt.ylim(0, 100)
    plt.ylabel("Unique Current Imprints for All Input Patterns [%]")
    
    plt.xlim(min(LASER_POWERS), max(LASER_POWERS))
    plt.xlabel("Laser Power [mW]")
    plt.legend(loc='best')
    plt.show()
        

