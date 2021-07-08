#!/usr/bin/python3
#
# Converts the (ng)SPICE Voltage output to PWL input file
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
#   wrdata test.out v(TEST1) v(TEST2)
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
parser.add_argument('-s', '--skip', help='Skip nodes to get \"longer\" linearized PWL segments; skip N - 1 nodes: to skip every 2 out of 3, set skip to 3', type=int, default=1)
parser.add_argument('-w', '--wipe', help='Wipe voltage changes below; default is 1mV', type=float, default=0.001)
parser.add_argument('-m', '--monotonic', help='Generate simple monotonic inputs only', type=bool, default=False)
parser.add_argument('-o', '--output', help='SPICE PWL file', type=argparse.FileType('w'), required=True)

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
            if (HEAD[col].startswith('v(\"') != True) and (HEAD[col].startswith('V(\"') != True):
                DATA[col] = None # anonotate non-volatage columns
            HEAD[col] = HEAD[col][3:-2]
        
        
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
    with args.output as output:
        devID=0
        for col in range(1,len(HEAD)):
            if (DATA[col] == None):
                continue
            # generate PWL head
            devID = devID + 1
            output.write("V" + VSOURCE_PREFIX + "_" + str(devID) + " " + str(HEAD[col]) + " 0 0 PWL(\n")
            output.write("+" + str(DATA[0][0]) + "s " + str(DATA[col][0]) + "V\n")
            if args.monotonic == True:
                for row in range(1, len(DATA[col])):
                    # 
                    if abs(float(DATA[col][row]) - float(DATA[col][-1])) < args.wipe:
                        output.write("+" + str(DATA[0][row]) + "s " + str(DATA[col][0]) + "V\n")
                        output.write("+"+ str(float(DATA[0][row])+0.000000001) + "s " + str(DATA[col][-1]) + "V\n")
                        break
            else:
                slopeCounter = 0 # how many points were in this slope
                lastProducedValue = float(DATA[col][0])
                for row in range(1, len(DATA[col])):
                    if abs(lastProducedValue - float(DATA[col][row])) < args.wipe:
                        continue
                    lastProducedValue = float(DATA[col][row])
                    # make the PWL smaller ...
                    if (DATA[col][row] == DATA[col][row-1]):
                        slopeCounter = 0
                        continue
                    elif row > 1 and (DATA[col][row] != DATA[col][row-1]) and (DATA[col][row-2] == DATA[col][row-1]):
                        # last value in the equal part of the row must be written
                        output.write("+"+ str(DATA[0][row-1]) + "s " + str(DATA[col][row-1]) + "V\n")
                        slopeCounter = 0
                    else:
                        # try to skip something in the "slope" part
                        if slopeCounter == 0:
                            output.write("+"+ str(DATA[0][row]) + "s " + str(DATA[col][row]) + "V\n")
                        slopeCounter = slopeCounter + 1
                        if args.skip == slopeCounter:
                            slopeCounter = 0
            output.write("+)\n")
        
# Entry point
if __name__ == '__main__':
    main()
