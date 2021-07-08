set terminal pdf size 12cm, 6cm 
set output ARG2

#set title "Voltage Levels"
set ylabel "Node Voltage [V]"
set xlabel "Laser Power [mW]"
set key outside

plot ARG1 using 1:3 title "V_{Y}(00)"  ls 1 pt 5  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:4 title "V_{O}(00)"  ls 2 pt 6  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:6 title "V_{Y}(01)"  ls 3 pt 7  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:7 title "V_{O}(01)"  ls 4 pt 8  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:9 title "V_{Y}(10)"  ls 5 pt 9  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:10 title "V_{O}(10)" ls 6 pt 10 pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:12 title "V_{Y}(11)" ls 7 pt 11 pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:13 title "V_{O}(11)" ls 8 pt 12 pointsize 0.5 pointinterval 50  with linespoints
     
set ylabel "Node Current [μA]"
set xlabel "Laser Power [mW]"
plot ARG1 using 1:2 title  "I_{VDD}(00)" ls 6 pt 1  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:5 title  "I_{VDD}(01)" ls 7 pt 4  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:8 title  "I_{VDD}(10)" ls 8 pt 2  pointsize 0.5 pointinterval 50  with linespoints, \
     ARG1 using 1:11 title "I_{VDD}(11)" ls 9 pt 3  pointsize 0.5 pointinterval 50  with linespoints, \
     
#pause -1 "Hit any key to continue"
