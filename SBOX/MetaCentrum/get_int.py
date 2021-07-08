#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 11/2019
#
# Get integral of given trace area. Trapesoid approximation is used. Step is given by the original ngSPICE step.
#


def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

import csv

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Get integral value.')
parser.add_argument('-f', '--file', help='power trace file', type=argparse.FileType('r'), required=True)
parser.add_argument('-s', '--start', help='start time', type=float, default=0.000000020)
parser.add_argument('-e', '--end',  help='end time', type=float, default=0.000000030)
parser.add_argument('-d', '--debug',help='show debug info', action='store_true', default=False)
args = parser.parse_args()

# Configuration variables
DEBUG = args.debug
START = args.start
END = args.end

# initial bounds for integral computation
y0 = 0
x0 = 0
x1 = 0
y1 = 0

# summary integral value
integral = 0
timeS = 0

with args.file as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=' ')
    for row in csv_reader:
        
        row = [value for value in row if value != '']
        
        # skip non-numerical rows - should be just header
        if is_number(row[0]) == False:
            continue
            
        y0 = y1
        x0 = x1
        x1 = float(row[0])
        y1 = float(row[1])
        
        if float(x1) < START:
            timeS = x1
        if float(x1) > START:
            integral += 0.5*(x1 - x0)*(y1 + y0)
        if float(x1) > END:
            timeE = x1
            break

# show integral value
print(str(integral/(timeE-timeS)))
