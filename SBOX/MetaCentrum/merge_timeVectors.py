#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 09/2020
#
# Merge vectors of ngSPICE outputs.
#

import csv

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Merge vectors of ngSPICE outputs.')
parser.add_argument('-f', '--files',  nargs='+', help='power trace file(s)', type=argparse.FileType('r'), required=True)
parser.add_argument('-o', '--output', help='merged power trace output file', type=argparse.FileType('w'), required=True)
parser.add_argument('-r', '--require',  help='require at least # of nanoseconds in the SPICE output', type=int, default=34)
args = parser.parse_args()

# initial values

MERGE_FILES = []
for file in args.files:
    MERGE_FILES.append(csv.reader(file, delimiter=' '))

currStamp = 0

TIMES = [None] * len(MERGE_FILES)
BASE_VALUES = [0] * len(MERGE_FILES)
VALUES = [None] * len(MERGE_FILES)
for i in range(0, len(MERGE_FILES)):
    row = next(MERGE_FILES[i])
    row = [value for value in row if value != '']
    TIMES[i] = float(row[0])
    VALUES[i] = float(row[1])

loop = 0 # number of failed reads
while loop < len(TIMES):
    # Start of algoritm
    
    # do not use MIN as some vectors can stuck - then loop variable can be used to get index of value to get
    #currStamp = min(TIMES)
    currStamp = sorted(TIMES)[loop]
    
    
    for i in range(0, len(TIMES)):
        if currStamp >= TIMES[i]:
            BASE_VALUES[i] = VALUES[i]
    
    args.output.write(" " + "{:.8e}".format(currStamp) + " " + "{:.8e}".format(sum(BASE_VALUES)) + "\n")
    
    loop = 0
    for i in range(0, len(TIMES)):
        if currStamp >= TIMES[i]:
            try:
                row = next(MERGE_FILES[i])
                row = [value for value in row if value != '']
                TIMES[i] = float(row[0])
                VALUES[i] = float(row[1])
            except:
                loop = loop + 1

for i in range(0, len(MERGE_FILES)):
    if TIMES[i] < (float(args.require)/1000000000.0):
        print("Error")
        exit(1)
    
for file in args.files:
    file.close()

exit(0)
