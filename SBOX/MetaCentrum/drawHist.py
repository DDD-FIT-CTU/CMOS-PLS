#!/usr/bin/python3
#
# Original code by Oliver W.:
#   https://stackoverflow.com/questions/26936094/python-load-data-and-do-multi-gaussian-fit
#
# Author: Jan Belohoubek
# Date: 09/2020
#
# Plot fitted data
#

import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize

INDEX_INPUT = 3
INDEX_STATIC = 7
INDEX_DYNAMIC = 8
INDEX_LASER = 10

data = np.genfromtxt('dualRailAS_0mW.csv', delimiter=';')
def gaussian(x, height, center, width, offset):
    return height*np.exp(-(x - center)**2/(2*width**2)) + offset

def three_gaussians(x, h1, c1, w1, h2, c2, w2, h3, c3, w3, offset):
    return (gaussian(x, h1, c1, w1, offset=0) +
        gaussian(x, h2, c2, w2, offset=0) +
        gaussian(x, h3, c3, w3, offset=0) + offset)

def two_gaussians(x, h1, c1, w1, h2, c2, w2, offset):
    return three_gaussians(x, h1, c1, w1, h2, c2, w2, 0,0,1, offset)

errfunc3 = lambda p, x, y: (three_gaussians(x, *p) - y)**2
errfunc2 = lambda p, x, y: (two_gaussians(x, *p) - y)**2

# compute hist
COL_STATIC = []
COL_DYNAMIC = []
COL_LASER = []
COL_INPUT = []

BIN_SIZE = 0.000001 # 1uA
STEP = 0.001 # 1mA
ROUND = 3

for i in range(1, len(data[:, INDEX_STATIC])):
    COL_STATIC.append(round(float(int(data[i, INDEX_STATIC]/BIN_SIZE))*STEP,ROUND))
    COL_DYNAMIC.append(round(float(int(data[i, INDEX_DYNAMIC]/BIN_SIZE))*STEP,ROUND))
    COL_LASER.append(round(float(int(data[i, INDEX_LASER]/BIN_SIZE))*STEP,ROUND))
    COL_INPUT.append(data[i, INDEX_INPUT])
    
static_hist, bin_edges = np.histogram(COL_STATIC, bins = sorted(set(COL_STATIC)))
dynamic_hist, bin_edges = np.histogram(COL_DYNAMIC, bins = sorted(set(COL_DYNAMIC)))
laser_hist, bin_edges = np.histogram(COL_LASER, bins = sorted(set(COL_LASER)))


static_X=np.array(sorted(set(COL_STATIC))[0:-1])
dynamic_X=np.array(sorted(set(COL_DYNAMIC))[0:-1])
laser_X=np.array(sorted(set(COL_LASER))[0:-1])

static_histRel = np.array([])
dynamic_histRel = np.array([])
laser_histRel = np.array([])

for i in range(0, len(static_hist)):
    static_histRel = np.append(static_histRel, float(static_hist[i])/1.0)

for i in range(0, len(dynamic_hist)):
    dynamic_histRel = np.append(dynamic_histRel, float(dynamic_hist[i])/1.0)
    
for i in range(0, len(laser_hist)):
    laser_histRel = np.append(laser_histRel, float(laser_hist[i])/1.0)

#  h, c, w, offset
static_guess = [0.05, -0.08, 0.01, 0.16, -0.058, 0.01, 0] 
dynamic_guess = [0.05, -0.08, 0.01, 0.16, -0.058, 0.01, 0] 
laser_guess = [0.05, -0.08, 0.01, 0.16, -0.058, 0.01, 0] 

static_optim2, success = optimize.leastsq(errfunc2, static_guess[:], args=(static_X, static_histRel))

#plt.bar(static_X, static_histRel, color='blue', alpha=0.5, label='Static Simulation', width=STEP)
#plt.bar(dynamic_X, dynamic_histRel, color='blue', alpha=0.7, label='Dynamic Simulation', width=STEP)
#plt.bar(laser_X, laser_histRel, color='blue', alpha=0.7, label='Laser Simulation', width=STEP)

#plt.plot(static_X, two_gaussians(static_X, *static_optim2),
    #lw=3, c='g', ls='-', label='Static Fit (2 Gaussians)')
    
plt.plot(COL_LASER,   COL_INPUT, ls='', marker='o')
plt.plot(COL_DYNAMIC, COL_INPUT, ls='', marker='^')
plt.plot(COL_STATIC,  COL_INPUT, ls='', marker='.')
    
plt.legend(loc='best')
plt.show()

print(str(laser_histRel))
print(str(laser_X))
print(str(COL_LASER))
