#!/usr/bin/python3
#
# Author: Jan Belohoubek
# Date: 11/2019
#
# Get single value from the specified time.
#

import csv

# cmdline args
import argparse
parser = argparse.ArgumentParser(description='Get current value.')
parser.add_argument('-f', '--file', help='power trace file', type=argparse.FileType('r'), required=True)
parser.add_argument('-t', '--time', help='Given time', type=float, default=0.000000010)
parser.add_argument('-d', '--debug',help='Show debug info', action='store_true', default=False)
args = parser.parse_args()

# Configuration variables
DEBUG = args.debug
TIME = args.time

# initial values
y0 = 0
x0 = 0
x1 = 0
y1 = 0

with args.file as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=' ')
    for row in csv_reader:
        
        row = [value for value in row if value != '']
        
        y0 = y1
        x0 = x1
        x1 = float(row[0])
        y1 = float(row[1])
        
        if float(x1) > TIME:
            print(str((x0+x1)/2) + "; " + str((y0+y1)/2))
            break
