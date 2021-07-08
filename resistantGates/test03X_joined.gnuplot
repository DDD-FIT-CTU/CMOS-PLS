set terminal pdf size 12cm, 6cm 
set output ARG3

#set title "Voltage Levels"
set ylabel "Node Voltage [V]"
set xlabel "Laser Power [mW]"
set key outside
set xrange [0:600];

set ylabel "Node Current [μA]"
set xlabel "Laser Power [mW]"
plot ARG1 using 1:2 title  "I1_{VDD}(00)" ls 6 pt 4 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG1 using 1:5 title  "I1_{VDD}(01)" ls 7 pt 8 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG1 using 1:8 title  "I1_{VDD}(10)" ls 8 pt 6 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG1 using 1:11 title "I1_{VDD}(11)" ls 9 pt 12 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG2 using 1:2 title  "I2_{VDD}(00)" ls 6 pt 5 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG2 using 1:5 title  "I2_{VDD}(01)" ls 7 pt 9 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG2 using 1:8 title  "I2_{VDD}(10)" ls 8 pt 7 pointsize 0.5 pointinterval 50 with linespoints, \
     ARG2 using 1:11 title "I2_{VDD}(11)" ls 9 pt 13 pointsize 0.5 pointinterval 50 with linespoints, \
     
#pause -1 "Hit any key to continue"
