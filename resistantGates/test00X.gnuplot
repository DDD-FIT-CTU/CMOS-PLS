set terminal pdf size 12cm, 6cm 
set output ARG2

#set title "Voltage Levels"
set ylabel "Node Voltage [V]"
set xlabel "Laser Power [mW]"
set key outside

plot ARG1 using 1:3 title "V_{in}(0)" ls 1 pt 5 pointsize 0.7 with linespoints, \
     ARG1 using 1:4 title "V_{O}(0)" ls 2 pt 6 pointsize 0.7 with linespoints, \
     ARG1 using 1:6 title "V_{in}(1)" ls 3 pt 7 pointsize 0.7 with linespoints, \
     ARG1 using 1:7 title "V_{O}(1)" ls 4 pt 8 pointsize 0.8 with linespoints
     
set ylabel "Node Current [μA]"
set xlabel "Laser Power [mW]"
plot ARG1 using 1:2 title "I_{VDD}(0)" ls 6 pt 1 pointsize 0.7 with linespoints, \
     ARG1 using 1:5 title "I_{VDD}(1)" ls 7 pt 4 pointsize 0.7 with linespoints
     
#pause -1 "Hit any key to continue"
