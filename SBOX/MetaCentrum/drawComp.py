#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 09/2020
#
# Plot BIN size vs. BIN cnt
#

import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
import scipy.stats as stats
import math
import statistics 
from scipy.stats import norm


# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Draw data.')
parser.add_argument('-l', '--laser', help='Laser Power', type=str, default=None)
parser.add_argument('-b', '--bin_size', help='Bin size', type=int, default=None)
parser.add_argument('-p', '--poi',  help='Select POI: 0 == laser; 1 == static; 2 == dynamic', type=int, default=0)
parser.add_argument('-g', '--gauss', help='Show gaussian curve to illustrate density', action='store_true', default=False)
parser.add_argument('-f', '--file', help='output pdf file', type=str, required=False)
args = parser.parse_args()

if args.laser == "50":
    DATASET_NAMES=["singleRail_50mW",  "dualRailAS_50mW",  "dualRail_50mW",  "pDualRail_50mW", "secLibDualRail_50mW" ]
elif args.laser == "100":
    DATASET_NAMES=["singleRail_100mW", "dualRailAS_100mW", "dualRail_100mW", "pDualRail_100mW", "secLibDualRail_100mW" ]
elif args.laser == "150":
    DATASET_NAMES=["singleRail_150mW", "dualRailAS_150mW", "dualRail_150mW", "pDualRail_150mW", "secLibDualRail_150mW"]
elif args.laser == "200":
    DATASET_NAMES=["singleRail_200mW", "dualRailAS_200mW", "dualRail_200mW", "pDualRail_200mW", "secLibDualRail_300mW"]
elif args.laser == "300":
    DATASET_NAMES=["singleRail_300mW", "dualRailAS_300mW", "dualRail_300mW", "pDualRail_300mW", "secLibDualRail_300mW"]
elif args.laser == "400":
    DATASET_NAMES=["singleRail_400mW", "dualRailAS_400mW", "dualRail_400mW", "pDualRail_400mW", "secLibDualRail_400mW"]
elif args.laser == "500":
    DATASET_NAMES=["singleRail_500mW", "dualRailAS_500mW", "dualRail_500mW", "pDualRail_500mW", "secLibDualRail_500mW"]
elif args.laser == "600":
    DATASET_NAMES=["singleRail_600mW", "dualRailAS_600mW", "dualRail_600mW", "pDualRail_600mW", "secLibDualRail_600mW"]
else:
    print("Data for dataset \"" + str(args.laser) + "\" not available!")
    exit(1)

DATASET_DISPLAY_NAMES=["singleRail",  "dualRailAS",  "dualRail",  "pDualRail" ,"secLibDualRail" ]
DATASET_MARKER=['o', '^', 'x', 'D', 'v']
DATASET_LINE=[':', '-', '--', '-.', (0, (1, 1, 1, 1, 1, 1, 6, 1))]
DATASET_DATA=[]

BIN_SIZE = [-1, -2, -3, -4, -5, -6, -7, -8, -9 ] # order coeficients 0 == 1A; 1 = 10A; -1 = 0.1A; -3 = 1mA; ...
BIN_COUNTS_STATIC = []
BIN_COUNTS_DYNAMIC = []
BIN_COUNTS_LASER = []

INDEX_INPUT = 3
INDEX_STATIC = 7
INDEX_DYNAMIC = 8
INDEX_LASER = 10

GAUSS_NAME=[]
GAUSS_X=[]
GAUSS_Y=[]
TRACES=[]
GAUSS_MEAN=[]
GAUSS_VAR=[]

# TODO remove this hack whe data are filtered: filter bad dynamic data
FILTER_DYNAMIC_BORDER=0.0001

for name in DATASET_NAMES:
    print(name + ".csv")
    DATASET_DATA.append(np.genfromtxt(name + ".csv", delimiter=';'))
    TRACES.append(len((DATASET_DATA[-1])[:, INDEX_STATIC]) - 1)

for dataset in range(0,len(DATASET_NAMES)):
    
    BIN_COUNTS_STATIC.append([])
    BIN_COUNTS_DYNAMIC.append([])
    BIN_COUNTS_LASER.append([])
    
    for binSize in BIN_SIZE:
        mult = 10.0 ** binSize
        
        tmpArray = []
        for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_STATIC])):
            if abs((DATASET_DATA[dataset])[i, INDEX_DYNAMIC]) < abs(FILTER_DYNAMIC_BORDER):
                continue
            tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_STATIC]/mult))
        BIN_COUNTS_STATIC[dataset].append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
        
        if (args.bin_size == binSize) and (args.poi == 1):
            GAUSS_NAME.append(DATASET_NAMES[dataset] + " static")
            GAUSS_X.append(sorted(set(tmpArray)))
            GAUSS_Y.append([])
            tmpArray2=[]
            GAUSS_MEAN.append(statistics.mean(tmpArray))
            for a in tmpArray:
                tmpArray2.append((a-GAUSS_MEAN[-1])*mult*1000)
            mu, std = norm.fit(tmpArray2)
            GAUSS_VAR.append(std)
            for i in range(0, len(GAUSS_X[-1])):
                GAUSS_Y[-1].append(100*tmpArray.count(GAUSS_X[-1][i])/TRACES[dataset])
                GAUSS_X[-1][i] = GAUSS_X[-1][i]*mult
        
        tmpArray = []
        for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_DYNAMIC])):
            if abs((DATASET_DATA[dataset])[i, INDEX_DYNAMIC]) < abs(FILTER_DYNAMIC_BORDER):
                continue
            tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_DYNAMIC]/mult))
        BIN_COUNTS_DYNAMIC[dataset].append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
        
        if (args.bin_size == binSize) and (args.poi == 2):
            GAUSS_NAME.append(DATASET_NAMES[dataset] + " dynamic")
            GAUSS_X.append(sorted(set(tmpArray)))
            GAUSS_Y.append([])
            tmpArray2=[]
            GAUSS_MEAN.append(statistics.mean(tmpArray))
            for a in tmpArray:
                tmpArray2.append((a-GAUSS_MEAN[-1])*mult*1000)
            mu, std = norm.fit(tmpArray2)
            GAUSS_VAR.append(std)
            for i in range(0, len(GAUSS_X[-1])):
                GAUSS_Y[-1].append(100*tmpArray.count(GAUSS_X[-1][i])/TRACES[dataset])
                GAUSS_X[-1][i] = GAUSS_X[-1][i]*mult
        
        
        tmpArray = []
        for i in range(1, len((DATASET_DATA[dataset])[:, INDEX_LASER])):
            if abs((DATASET_DATA[dataset])[i, INDEX_DYNAMIC]) < abs(FILTER_DYNAMIC_BORDER):
                continue
            tmpArray.append(int((DATASET_DATA[dataset])[i, INDEX_LASER]/mult))
        BIN_COUNTS_LASER[dataset].append((len(sorted(set(tmpArray)))/TRACES[dataset])*100)
        
        if (args.bin_size == binSize) and (args.poi == 0):
            GAUSS_NAME.append(DATASET_NAMES[dataset] + " laser")
            GAUSS_X.append(sorted(set(tmpArray)))
            GAUSS_Y.append([])
            tmpArray2=[]
            GAUSS_MEAN.append(statistics.mean(tmpArray))
            for a in tmpArray:
                tmpArray2.append((a-GAUSS_MEAN[-1])*mult*1000)
            mu, std = norm.fit(tmpArray2)
            GAUSS_VAR.append(std)
            for i in range(0, len(GAUSS_X[-1])):
                GAUSS_Y[-1].append(100*tmpArray.count(GAUSS_X[-1][i])/TRACES[dataset])
                GAUSS_X[-1][i] = GAUSS_X[-1][i]*mult

if args.bin_size == None:
    ATTACK_COST = []
    for b in BIN_SIZE:
        ATTACK_COST.append(abs(b))
    
    for dataset in range(0,len(DATASET_NAMES)):
        plt.plot(ATTACK_COST, BIN_COUNTS_STATIC[dataset], ls='--', marker=DATASET_MARKER[dataset], label="Static " + DATASET_NAMES[dataset])
    
    for dataset in range(0,len(DATASET_NAMES)):
        plt.plot(ATTACK_COST, BIN_COUNTS_DYNAMIC[dataset], ls='-', marker=DATASET_MARKER[dataset], label="Dynamic " + DATASET_NAMES[dataset])
        
    for dataset in range(0,len(DATASET_NAMES)):
        plt.plot(ATTACK_COST, BIN_COUNTS_LASER[dataset], ls=':', marker=DATASET_MARKER[dataset], label="Laser " + DATASET_NAMES[dataset])
        
    plt.xlim(min(ATTACK_COST), max(ATTACK_COST))
    plt.ylim(0, 100)
    plt.xlabel("Measurement Resolution 10$^{-x}$ [A]")
    plt.ylabel("Unique Current Imprints for All Input Patterns [%]")
    
    plt.legend(loc='best')
    plt.show()
else:
    if args.gauss == True:
        maxSigma = 0
        for i in range(0,len(DATASET_NAMES)):
            #mu = GAUSS_MEAN[i]
            mu = 0 # display around 0 to enable comparison
            sigma = GAUSS_VAR[i] # show in miliamps
            #print(str(GAUSS_VAR[i]))
            x = np.linspace(mu - 100*sigma, mu + 100*sigma, 10000)
            plt.plot(x, stats.norm.pdf(x, mu, sigma), label=DATASET_DISPLAY_NAMES[i], ls=DATASET_LINE[i])
            if (abs(sigma)) > maxSigma:
                maxSigma = abs(sigma)
        plt.xlim(-3*maxSigma, 3*maxSigma)
        #plt.xlim(-1, 1)
        plt.xlabel("Power Imprint Variability [mA]")
        plt.ylabel("Density Function")
    else:
        w = abs(min(min(GAUSS_X[:][:])))/1000
        for i in range(0,len(DATASET_NAMES)):
            plt.bar(x=GAUSS_X[i], height=GAUSS_Y[i], width=w, label=GAUSS_NAME[i])
        
        plt.ylim(0, 100)
        
    plt.legend(loc='best')
    if args.file == None:
        plt.show()
    else:
        plt.savefig(args.file)
        

