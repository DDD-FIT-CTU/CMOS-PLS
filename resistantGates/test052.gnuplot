set terminal pdf size 12cm, 6cm 
#set output "output/stackOverlaps_leakage.pdf"
set output "output/test052.pdf"

set key outside

set ylabel "Node Current [nA]"
set xlabel "\nGate Type"
set xtics ("distantDoubled" 0, "\n\overlapHalf" 1, "fullBot" 2, "\n\nfullTop" 3) font ",6"
set xrange [0:3]
set format x ""

plot "results/test052_stackOverlapsLight.csv" using 2:3 title "I_{VDD}(00)" ls 6 pt 1  pointsize 0.7 with linespoints, \
     "results/test052_stackOverlapsLight.csv" using 2:4 title "I_{VDD}(01)" ls 7 pt 4  pointsize 0.7 with linespoints, \
     "results/test052_stackOverlapsLight.csv" using 2:5 title "I_{VDD}(10)" ls 8 pt 2  pointsize 0.7 with linespoints, \
     "results/test052_stackOverlapsLight.csv" using 2:6 title "I_{VDD}(11)" ls 9 pt 3  pointsize 0.7 with linespoints
     
#pause -1 "Hit any key to continue"
