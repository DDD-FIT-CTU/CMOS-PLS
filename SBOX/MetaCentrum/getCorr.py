#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 11/2019
#
# Get correlation value for SBOX variant. Based on Pearson Correlation method.
#

import csv
# generate random integer values
from random import seed
from random import randint
# seed random number generator
seed(1)

from scipy.stats.stats import pearsonr  

# plotting
import matplotlib.pyplot as plt

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Process SBOX Pearson correlations')
parser.add_argument('-f', '--file', help='SBOX power lookup table', type=argparse.FileType('r'), required=True)
parser.add_argument('-s', '--step', help='# simulated power traces in one step', type=int, default=100)
parser.add_argument('-e', '--end',  help='# simulated power traces', type=int, default=50000)
parser.add_argument('-b', '--sbox', help='# SBOXes used to represet the circuit complexity', type=int, default=16) # 16 represents AES-128
parser.add_argument('-p', '--poi', help='Select POI: 0 == laser; 1 == static; 2 == dynamic', type=int, default=0)
parser.add_argument('-r', '--rand', help='# simulated random power traces for comparison', type=int, default=20)
parser.add_argument('-l', '--limit',help='show convergence (limit) value', action='store_true', default=False)
parser.add_argument('-g', '--graph',help='show graphs', action='store_true', default=False)
parser.add_argument('-d', '--debug',help='show debug info', action='store_true', default=False)
args = parser.parse_args()

# Configuration variables
DEBUG = args.debug
GRAPHS = args.graph
STEP = args.step # number of simulated traces between two computations of difference of means
STOP = args.end # number of simulated power traces to stop
SHOW_LIMIT = args.limit
SBOXES = args.sbox

# set row containing current/power
if args.poi == 0:
    SELECTED_ROW = 10
elif args.poi == 1:
    SELECTED_ROW = 7
else:
    SELECTED_ROW = 8

# simulated power lookup table
lookupTable = []
for i in range(256):
    lookupTable.append(0.0)

# simulated power traces
TRACE_VALUE = []
TRACE_DATA  = []
TRACE_MODEL = []
TRACE_RND_MODEL = [[]]

STEPS = [] # array of steps (x-axes)
CORR = [] # arrays of computed correlations
CORR_RND = [[]] # array(s) of random correlations for comparison
DIFF = []


with args.file as csv_file:
#with open('results_photo.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=';')
    lineCnt = 0
    for row in csv_reader:
        if lineCnt == 0:
            if DEBUG == True:
                print("Colums: {" + str(row) + "}")
        else:
            # insert simulated current to the index given by SBOX input value
            lookupTable[int(row[3])] = float(row[SELECTED_ROW]) * 1000000 # compute in uA
        lineCnt += 1

if DEBUG == True:
    for i in range(256):
        print(lookupTable[i])

# generate random values for coparison
for i in range(args.rand):
    TRACE_RND_MODEL.append([])
    CORR_RND.append([])

# create random intermediate values with given step
currStep = 0
while currStep < STOP:
    # generate random traces for 128-bit AES
    TRACE_VALUE.append(0)
    TRACE_DATA.append(0)
    TRACE_MODEL.append(0)
    for i in range(SBOXES):
        index = randint(0, 255)
        TRACE_VALUE[-1] += lookupTable[index]
        # use the last SBOX as the sbox under attack
        TRACE_DATA[-1] = index
        TRACE_MODEL[-1] = lookupTable[index]
    for i in range(args.rand):
        TRACE_RND_MODEL[i].append(lookupTable[randint(0, 255)])
    # increment currents step value
    currStep += 1
    
    # analyze values every STEP ...
    if (currStep % STEP) == 0:
        STEPS.append(currStep)
        # Pearson returns:
        #  - correlation coef
        #  - p-value (indicates the probability of an uncorrelated system)
        CORR.append(pearsonr(TRACE_VALUE, TRACE_MODEL)[0])
        maxDiff = 0
        for i in range(args.rand):
            CORR_RND[i].append(pearsonr(TRACE_VALUE, TRACE_RND_MODEL[i])[0])
            if maxDiff < abs(CORR_RND[i][-1]):
                maxDiff = abs(CORR_RND[i][-1])
        DIFF.append(abs(CORR[-1] - maxDiff))

# Plot values
# red dashes, blue squares and green triangles
if GRAPHS == True:
    plt.plot(STEPS, CORR, 'r-', label='Pearson correlation for valid model')
    for i in range(args.rand):
        plt.plot(STEPS, CORR_RND[i], ' .')
    plt.legend()
    plt.xlabel('# Model Traces')
    plt.ylabel('Pearson Correlation')
    plt.title('Pearson correlation for VALID model vs. RND model')
    plt.show()
    
    plt.plot(STEPS, DIFF)
    plt.show()

# show limit value of the converging sequence
if SHOW_LIMIT == True:
    print(str(CORR[-1]))
