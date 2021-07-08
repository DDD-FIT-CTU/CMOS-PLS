# TEST 014 - gnuplot
#
# TSMC 180nm Subthreshold Leakage Model -  a realWorld example: 100k gates (gate is inverter :-))
#
# This test allows to simulate NMOS transistor subthreshold leakage
#
# Author: Jan Belohoubek, 01/2021
# jan.belohoubek@fit.cvut.cz
#
# https://users.fit.cvut.cz/~belohja4/
#
#
#
# Parameters were extracted from BSIM3v3.3 and from TSMC model file
#
# For details about model implementation, please refer:
#   WESTE, Neil HE; HARRIS, David. CMOS VLSI design: a circuits and systems perspective. Pearson Education India, 2015.
#   BSIM3v3.3 MOSFET Model: http://ngspice.sourceforge.net/external-documents/models/bsim330_manual.pdf
#

# --- Model parameters ---

# Particular model parameters were extracted from simulation "test014", where:
#   NMOS channel length is 0.2u 
#   NMOS channel width is 2.0u
#

W=2
L=0.2

# The subthreshold slope, S reaches the common value 100mV/dec; the value below is extracted from simmulation
S    = 0.0945
# Off Leakage; the value below is extracted from simmulation
Ids0 = 90e-9 # ~ 90n
# Threshold Voltage
VT   = 0.354505
# DIBL coefficient in subthreshold region;
ETA  = 0.0231564
# body effect coefficient
K1   = 0.5733393
# Thermal voltage
Tv   = 0.026
# Boltzman's constant
k = 1.38e-23
# electron charge
q = 1.602e-19
# subthreshold swing -- an estimated value
n = 1.3
# Offset voltage in the subthresh-old region at large W and L
Voff = -0.0652968
#Mobility at Temp = Tnom
U0   = 128.7704538 
#Supply Voltage
Vsupp = 1.8
# Oxide thickness
Tox = 4.1e-9
#
beta = U0 * Tox * W/L

# Body-source voltage
Vsb0 = -0.05
Vsb1 = -0.04
Vsb2 = -0.03
Vsb3 = -0.02
Vsb4 = -0.01
Vsb5 = -0.0


# --- Graph settings ---

# print to PDF -- coment to enable live 3D view
set terminal pdf size 24cm, 12cm font "Sans,20"
set output "output/test014_100kGates_Temp.pdf"

#set title "Cummulative Subthreshold Leakage for 100k gates in TSMC180nm"

set ticslevel 0.01


set xlabel "T [K]"
set ylabel "I_{leakage} [uA]" rotate by 90

set palette
#unset surface
set samples 70,45
set isosamples 70,45
unset xtics
unset ytics
set border 3
set xtics axis
set ytics axis
set angle degree

# --- Data Sets --- 

# Vgs = 0; temp = 250 - 400 K

# Ids0 = beta* (((k * x) / q)**2) * exp(1.8)

plot [250:400] ((beta* (((k * x) / q)**2) * exp(1.8)) * (exp( ( 0 - VT + (ETA * Vsupp) - K1 * Vsb0 ) / ( n * ((k * x) / q)) * (1 - exp(-1*Vsupp/(k*x/q))) )) ) * 100000 * 10**6 title "100k gates leakage" w l lc rgb 0xAA00FF

      
pause -1 "Hit any key to continue"
