#!/bin/bash
#
# Just a dummy helper script :-)
#

#cd magic
#bash exportNetlists.sh

#cd ..
bash test04X.sh test043_and_final
bash test04X.sh test045_and_final_affectedInputs
gnuplot -c test04X.gnuplot results/test043_and_final.csv output/test043.pdf
gnuplot -c test04X.gnuplot results/test045_and_final_affectedInputs.csv output/test045.pdf

bash test04X.sh test044_or_final
bash test04X.sh test046_or_final_affectedInputs
gnuplot -c test04X.gnuplot results/test044_or_final.csv output/test044.pdf
gnuplot -c test04X.gnuplot results/test046_or_final_affectedInputs.csv output/test046.pdf

okular output/test044.pdf output/test046.pdf output/test043.pdf output/test045.pdf 
