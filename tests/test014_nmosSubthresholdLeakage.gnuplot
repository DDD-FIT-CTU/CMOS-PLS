# TEST 014 - gnuplot
#
# TSMC 180nm Subthreshold Leakage Model
#
# This test allows to simulate NMOS transistor subthreshold leakage
#
# Author: Jan Belohoubek, 03/2020
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

# The subthreshold slope, S reaches the common value 100mV/dec; the value below is extracted from simmulation
S    = 0.0945
# Off Leakage; the value below is extracted from simmulation
Ioff = 0.00000000001625 # ~ 16.25p
# Threshold Voltage
VT   = 0.354505
# DIBL coefficient in subthreshold region;
ETA  = 0.0231564
# body effect coefficient
K1   = 0.5733393
# Thermal voltage in at room temperature
Tv   = 0.026
# Offset voltage in the subthresh-old region at large W and L
Voff = -0.0652968
#Mobility at Temp = Tnom
U0   = 128.7704538 
#Supply Voltage
Vsupp = 1.8

# Body-source voltage
Vsb0 = -0.05
Vsb1 = -0.04
Vsb2 = -0.03
Vsb3 = -0.02
Vsb4 = -0.01
Vsb5 = -0.00


# --- Graph settings ---

# print to PDF -- coment to enable live 3D view
set terminal pdf size 24cm, 12cm font "Sans,20"
set output "output/test014_Vgs_Vds_Vsb.pdf"

#set title "Subthreshold Leakage in TSMC 180nm NMOS"

set ticslevel 0.01
 
set xrange [0:VT]
set yrange [0:Vsupp]

set xlabel "V_{gs} [V]"
set ylabel "V_{ds} [V]"
set zlabel "I_{ds} [nA]" rotate by 90

# set log z
#set pm3d
set palette
#unset surface
set samples 70,45
set isosamples 70,45
set hidden3d
set angle degree

# --- Data Sets --- 

IDS0(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb0 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data00
    splot IDS0(x,y)
unset table

IDS1(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb1 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data01
    splot IDS1(x,y)
unset table

IDS2(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb2 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data02
    splot IDS2(x,y)
unset table

IDS3(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb3 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data03
    splot IDS3(x,y)
unset table

IDS4(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb4 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data04
    splot IDS4(x,y)
unset table

IDS5(x,y) = (Ioff * 10**( ( x + ETA * (y - Vsupp) - K1 * Vsb5 ) / S  ) * (1 - exp(-1*y/Tv))) * 10**9
set table $Data05
    splot IDS5(x,y)
unset table

# --- Graph ---

# Color palete
Zmin = 0
Zmax = 100
Frac(z) = (z-Zmin)/(Zmax-Zmin)

# MyPalette
Red(z) = 65536 * ( Frac(z) > 0.85 ? 255 : int(255*abs(2*Frac(z)-0.5)))
Green(z) = 256 * int(255*sin(180*Frac(z)))
Blue(z) = int(255*cos(150*Frac(z)))
MyPalette(z) =  Red(z) + Green(z) + Blue(z) 

set view 45,216
splot $Data00 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb0), \
      $Data01 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb1), \
      $Data02 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb2), \
      $Data03 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb3), \
      $Data04 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb4), \
      $Data05 u 1:2:3:(MyPalette($3)) w l lc rgb var title sprintf("V_{sb} = %0.2f", Vsb5)

pause -1 "Hit any key to continue"
