# TEST 014 - gnuplot
#
# TSMC 180nm Subthreshold Leakage Model - Temperature dependency
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
# Thermal voltage in at room temperature
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

# Ids0 = beta* (((k * TEMP) / q)**2) * exp(1.8)

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
set output "output/test014_Vgs_Vsb_Temp.pdf"

#set title "Subthreshold Leakage in TSMC 180nm NMOS"

set ticslevel 0.01
set tics

 
set xrange [0:0.1]
set yrange [250:400]

set xlabel "V_{gs} [V]"
set ylabel "T [K]"
set zlabel "I_{ds} [nA/um^2]" rotate by 90

# set log z
#set pm3d
set palette
#unset surface
set samples 70,45
set isosamples 70,45
set hidden3d
set angle degree

# --- Data Sets --- 

IDS0(x,y) = ((beta* (((k * y) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb0 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data00
    splot IDS0(x,y)
unset table

IDS1(x,y) = ((beta* (((k * y) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb1 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data01
    splot IDS1(x,y)
unset table

IDS2(x,y) = ((beta* (((k * y) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb2 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data02
    splot IDS2(x,y)
unset table

IDS3(x,y) = ((beta* (((k * y) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb3 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data03
    splot IDS3(x,y)
unset table

IDS4(x,y) = ((beta* (((k * y) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb4 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data04
    splot IDS4(x,y)
unset table

IDS5(x,y) = ((beta* (((k * x) / q)**2) * exp(1.8)) * (exp( ( x - VT + (ETA * Vsupp) - K1 * Vsb5 ) / ( n * ((k * y) / q)) * (1 - exp(-1*Vsupp/(k*y/q))) )) ) * 2.5 * 10**9 # nA/um2
set table $Data05
    splot IDS5(x,y)
unset table

# --- Graph ---

# Color palete
Zmin = 0
Zmax = 0.35
Frac(z) = (z-Zmin)/(Zmax-Zmin)

# MyPalette
Red(z) = 65536 * ( Frac(z) > 0.75 ? 255 : int(255*abs(2*Frac(z)-0.5)))
Green(z) = 256 * (Frac(z) > 0.50 ? 128 : int(255*sin(180*Frac(z))))
Blue(z) = (Frac(z) > 0.25 ? 64 : int(255*cos(150*Frac(z))))
MyPalette(z) =  Red(z) + Green(z) + Blue(z) 

set view 44,316
splot $Data00 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb0), \
      $Data01 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb1), \
      $Data02 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb2), \
      $Data03 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb3), \
      $Data04 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb4), \
      $Data05 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb5)
      
pause -1 "Hit any key to continue"
