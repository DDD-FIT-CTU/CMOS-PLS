set terminal pdf size 12cm, 6cm 
set output ARG2

#set title "Voltage Levels"
set ylabel "Node Voltage [V]"
set xlabel "Laser Power [mW]"
set key outside

plot ARG1 using 1:3 title "V_Y (0)"  ls 6 pt 4 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG1 using 1:5 title "V_Y (1)"  ls 7 pt 6 pointsize 0.6 pointinterval 50 with linespoints 
   
set ylabel "Node Current [μA]"
set xlabel "Laser Power [mW]"
set key right center

plot ARG1 using 1:2 title  "I_0" ls 6 pt 4  pointsize 0.5 pointinterval 50 with linespoints,\
     ARG1 using 1:4 title  "I_1" ls 7 pt 6  pointsize 0.6 pointinterval 50 with linespoints
     
#pause -1 "Hit any key to continue"
