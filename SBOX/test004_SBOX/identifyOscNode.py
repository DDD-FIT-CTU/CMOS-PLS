#!/usr/bin/python3
#
# Identify oscilating nodes in ngSPICE output file
#
# Copyright 2020 Jan Belohoubek <jan.belohoubek@fit.cvut.cz>
#
#
#
# In ngSPICE, the following variables must be defined before file is written:
#   set wr_vecnames
#   set wr_singlescale
#
# Use the following command to store voltages for nodes TEST1 and TEST2:
#   wrdata outputs.out allv
#
#  It is expected, that the first row of the file contains vector names & the first column contains time
#

import sys
import os
import re

# Locals
import argparse

VSOURCE_PREFIX="out2pwl"

# Arguments
parser = argparse.ArgumentParser(description='Get integral value.')
parser.add_argument('-f', '--file', help='SPICE voltage dump file', type=argparse.FileType('r'), required=True)
parser.add_argument('-l', '--limit', help='Oscillation limit', type=float, default=0.001)
parser.add_argument('-p', '--prefix', help='Required node prefix', type=str, default="")
parser.add_argument('-s', '--samples', help='Number of samples backwards', type=int, default=10)

args = parser.parse_args()

# Print HELP()
def printHelp():
    print("Welcome to out2PWL script")
    print()
   
# MAIN
def main():
    global args
    
    with args.file as netlist:
        line = netlist.readline()
        lineCnt = 1
        line = line.strip()
        
        HEAD = line.split()
        DATA = []
        if HEAD[0] != "time":
            print("Unexpected file format!")
            exit(1)
        DATA = []
        DATA.append([])
        
        for col in range(1,len(HEAD)):
            DATA.append([])
            if (HEAD[col].startswith(args.prefix) != True):
                DATA[col] = None # anonotate non-prefixed columns
            HEAD[col] = HEAD[col][:]
        
        
        # get next line
        line = netlist.readline()
        lineCnt += 1
        while line:
            line = line.strip().split()
            for col in range(0,len(HEAD)):
                if (DATA[col] == None):
                    continue
                else:
                    DATA[col].append(line[col])
            # get next line
            line = netlist.readline()
            lineCnt += 1
        
    # Generate PWLs
    for col in range(1,len(HEAD)):
        if (DATA[col] == None):
            continue
        avg = 0
        cnt = 0
        for i in reversed(range(0,len(DATA[col]))):
            avg = ((avg * cnt) + float(DATA[col][i]))/(cnt + 1)
            cnt = cnt + 1
            if (abs(avg - float(DATA[col][i]))) > args.limit:
                print("Oscillating node (" + str(col) + "/" + str(i) + "): " + HEAD[col])
            if cnt > args.samples:
                break
            
        
# Entry point
if __name__ == '__main__':
    main()
