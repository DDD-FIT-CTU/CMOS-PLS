set terminal pdf size 12cm, 6cm 
set output "output/test050.pdf"

set key outside

set ylabel "Node Current [nA]"
set xlabel "\nGate Type"
#set xtics ("AND2X1" 0, "\nNAND2X1" 1, "NAND2X1+INV" 2, "\nNAND2X1+SYMMETRY" 3, "NAND2X1+SYMMETRY+INV" 4, "\nNAND2X1+SYMMETRY\n+INV+SERIALR" 5, "\nNAND ALL" 6) rotate by 10 right font ",6"
set xtics ("AND2X1" 0, "\n\nNAND2X1" 1, "NAND2X1+INV" 2, "\n\nNAND2X1+SYMMETRY" 3, "NAND2X1+SYMMETRY+INV" 4, "\n\nNAND2X1+SYMMETRY\n+INV+SERIALR" 5, "NAND ALL" 6, "\n\nINVX1" 7, "2INVX1" 8, "\n\nNAND+ALL+CTRL+CENTER" 9) font ",6"
set xrange [0:9]
set format x ""

plot "results/test050_leakage.csv" using 2:3 title "I_{VDD}(00)" ls 6 pt 1  pointsize 0.7 with linespoints, \
     "results/test050_leakage.csv" using 2:4 title "I_{VDD}(01)" ls 7 pt 4  pointsize 0.7 with linespoints, \
     "results/test050_leakage.csv" using 2:5 title "I_{VDD}(10)" ls 8 pt 2  pointsize 0.7 with linespoints, \
     "results/test050_leakage.csv" using 2:6 title "I_{VDD}(11)" ls 9 pt 3  pointsize 0.7 with linespoints
     
#pause -1 "Hit any key to continue"
