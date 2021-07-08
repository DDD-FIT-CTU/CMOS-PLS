# set terminal pdf size 12cm, 6cm 
# set output ARG2

#set title "Voltage Levels"
set ylabel "# items in Bins"
set xlabel "Simulated Current [mA]"
set key outside

# Each bar is half the (visual) width of its x-range.
set boxwidth 0.005 absolute
set style fill solid 1.0 noborder

rounded(x,y) = floor(x*y*1000)/y
  
set table 'hist.tmp'
plot ARG1 using (rounded($9,100.0)) smooth frequency with boxes
unset table

set table 'hist_fine.tmp'
plot ARG1 using (rounded($9,100000.0)) smooth frequency with boxes
unset table

set table 'hist2.tmp'
plot ARG1 using (rounded($8,100.0)) smooth frequency with boxes
unset table

set table 'hist2_fine.tmp'
plot ARG1 using (rounded($8,100000.0)) smooth frequency with boxes
unset table

Gauss(x,a,mu,sigma) = a/(sigma*sqrt(2*pi)) * exp( -(x-mu)**2 / (2*sigma**2) )

# compute statistics for column 9
stats ARG1 using 9

a = sqrt(STATS_stddev)*2.5*255
mu = STATS_mean*1000
sigma = STATS_stddev*1000


#fit Gauss(x,a,mu,sigma) 'hist_fine.tmp' u 1:2 via a,mu,sigma

# compute statistics for column 8
stats ARG1 using 8

a2 = sqrt(STATS_stddev)*2.5*255
mu2 = STATS_mean*1000
sigma2 = STATS_stddev*1000

#fit Gauss(x,a2,mu2,sigma2) 'hist2_fine.tmp' u 1:2 via a2,mu2,sigma2

set boxwidth 0.005
# set fill style of bins
set style fill solid 0.15 border 1

set style line 2 \
    linecolor rgb '#FF0000' \
    linetype 1 linewidth 2 \
    pointtype 7 pointsize 1.5
    
    
set style function filledcurves y1=0
    
#set xrange [-180:-60]

    
plot Gauss(x,a,mu,sigma) fs solid 0.1 lc rgb "red", \
     'hist.tmp' using 1:2 lc rgb '#FF0000' with boxes, \
     Gauss(x,a,mu,sigma) w lines ls 2 lw 2, \
     Gauss(x,a2,mu2,sigma2) fs solid 0.1 lc rgb "blue", \
     'hist2.tmp' using 1:2 lc rgb '#0000FF' with boxes, \
     Gauss(x,a2,mu2,sigma2) w lines ls 2 lw 2 linecolor rgb '#0000FF'
     
pause -1 "Hit any key to continue"


