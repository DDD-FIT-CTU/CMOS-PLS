set terminal pdf size 12cm, 6cm 
set output ARG3

#set title "Voltage Levels"
   
set ylabel "Node Current [μA]"
set xlabel "Laser Power [mW]"
#set key right center

plot ARG1 using 1:2 title  "NMOS" ls 6 pt 4  pointsize 0.5 pointinterval 50 with linespoints,\
     ARG2 using 1:2 title  "PMOS" ls 7 pt 6  pointsize 0.6 pointinterval 50 with linespoints
     
#pause -1 "Hit any key to continue"
