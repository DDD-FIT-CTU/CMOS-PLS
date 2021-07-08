#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 11/2019
#
# Get distinguisher value for SBOX variant. Based on difference of means method.
#

import csv
# generate random integer values
from random import seed
from random import randint
# seed random number generator
seed(None)

# plotting
import matplotlib.pyplot as plt

SBOX = (
            0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
            0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
            0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
            0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
            0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
            0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
            0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
            0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
            0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
            0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
            0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
            0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
            0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
            0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
            0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
            0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16
     )

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Process SBOX Pearson correlations')
parser.add_argument('-f', '--file', help='SBOX power lookup table', type=argparse.FileType('r'), required=True)
parser.add_argument('-s', '--step', help='# simulated power traces in one step', type=int, default=100)
parser.add_argument('-e', '--end',  help='# simulated power traces', type=int, default=80000)
parser.add_argument('-b', '--sbox', help='# SBOXes used to represet the circuit complexity', type=int, default=16) # 16 represents AES-128
parser.add_argument('-p', '--poi',  help='Select POI: 0 == laser; 1 == static; 2 == dynamic', type=int, default=0)
parser.add_argument('--use_output', help='Use SBOX output as distinguisher instead of SBOX input', action='store_true', default=False)
parser.add_argument('-i', '--bit',  help='# SBOX input bit, which is used to split data serie', type=int, default=0) # should be 0 .. 7
parser.add_argument('-l', '--limit',help='show convergence (limit) value', action='store_true', default=False)
parser.add_argument('-v', '--vectors',help='show number of vectors used to get signifficant distinguisher', action='store_true', default=False)
parser.add_argument('-g', '--graph',help='show graphs', action='store_true', default=False)
parser.add_argument('-d', '--debug',help='show debug info', action='store_true', default=False)
args = parser.parse_args()

# Configuration variables
DEBUG = args.debug
GRAPHS = args.graph
USE_OUTPUT = args.use_output
STEP = args.step # number of simulated traces between two computations of difference of means
STOP = args.end # number of simulated power traces to stop
SHOW_LIMIT = args.limit
SHOW_VECTORS = args.vectors
SBOXES = args.sbox
BIT = args.bit # bit used as the distinguisher ... 0 - 7
VDD = 1.8 # VDD is 1.8V

# set row containing current/power
if args.poi == 0:
    SELECTED_ROW = 10
elif args.poi == 1:
    SELECTED_ROW = 7
else:
    SELECTED_ROW = 8

# simulated power traces
TRACE_VALUE = []
TRACE_DATA  = []

# array of steps
STEPS = []
# arrays of computed averages
AVG0 = []
AVG1 = []
AVG  = []
SUM0 = 0
SUM1 = 0
SUM_RND = 0
STP0 = 0
STP1 = 0
STP_RND = 0
DIFF = []
SHARE = []
RND = []

# simulated power lookup table
lookupTable = []
for i in range(256):
    lookupTable.append(0.0)

with args.file as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=';')
    lineCnt = 0
    for row in csv_reader:
        if lineCnt == 0:
            if DEBUG == True:
                print("Colums: {" + str(row) + "}")
        else:
            # insert simulated current to the index given by SBOX input value
            lookupTable[int(row[3])] = int(float(row[SELECTED_ROW]) * 1000000) # compute in uA
        lineCnt += 1

if DEBUG == True:
    for i in range(256):
        print(lookupTable[i])

# create random intermediate values with given step
currStep = 0
while (currStep < STOP) or (SHOW_VECTORS == True):
    # generate random traces for 128-bit AES
    TRACE_VALUE.append(0)
    TRACE_DATA.append(0)
    for i in range(SBOXES):
        index = randint(0, 255)
        TRACE_VALUE[currStep] = TRACE_VALUE[currStep] + lookupTable[index]
        TRACE_DATA[currStep] = index # use the last SBOX as the sbox under evaluation
    # increment currents step value
    currStep = currStep + 1
    
    # analyze values every STEP ...
    if (currStep % STEP) == 0:
        AVG0.append(0)
        AVG1.append(0)
        AVG.append(0)
        RND.append(0)
        DIFF.append(0)
        SHARE.append(0)
        STEPS.append(currStep)
            
        for i in range(currStep - STEP, currStep):
            distinguisher = ((TRACE_DATA[i]>>BIT) % 2)
            if (USE_OUTPUT == True):
                distinguisher = ((SBOX[TRACE_DATA[i]]>>BIT) % 2)
            
            if distinguisher == 0:
                SUM0 += TRACE_VALUE[i]
                STP0 += 1
            else:
                SUM1 += TRACE_VALUE[i]
                STP1 += 1
            
            if randint(0, 1) == 0:
                SUM_RND += TRACE_VALUE[i]
                STP_RND += 1
        
        AVG0[-1] = SUM0/STP0
        AVG1[-1] = SUM1/STP1
        AVG[-1]  = (SUM0 + SUM1)/(STP0 + STP1)
        DIFF[-1] = abs(abs(AVG0[-1]) - abs(AVG1[-1]))
        RND[-1] = SUM_RND/STP_RND
        SHARE[-1] = DIFF[-1]/abs(abs(AVG[-1]) - abs(RND[-1]))
        
        if SHOW_VECTORS == True:
            if SHARE[-1] > 10:
                break
        
        if DEBUG == True:
            print("steps 0:" + str(STP0))
            print("steps 1:" + str(STP1))

# Plot values
# red dashes, blue squares and green triangles
if GRAPHS == True:
    plt.plot(STEPS, AVG, 'r--', STEPS, AVG0, 'bs', STEPS, AVG1, 'go', STEPS, RND, 'g--')
    plt.show()
    
    plt.plot(STEPS, DIFF, 'r--')
    plt.show()

# show limit value of the converging sequence
if SHOW_LIMIT == True:
    print(DIFF[-1])
    
if SHOW_VECTORS == True:
    print(currStep)
