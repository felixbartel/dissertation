set terminal cairolatex size 10.7cm, 3.7cm
set output "img/cv_1d.tex"

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set grid lt 1 lc 'gray'

set xlabel '$m$' offset 0,0.5

set style line 1 lw 1.5 ps 0.2 pt 7 lc 'black'

set multiplot layout 1,3

set xrange [3:2000]
set yrange [1e-10:0.1]
set ytics 1e-9,1000 offset 0.5

set lmargin 4.6
set rmargin 0.6
set tmargin 0
set bmargin 2

sigma = "`cat dat/T_fourier_sigma.csv`"

plot "dat/T_fourier.csv" using "m":(column("L2error")**2)with linespoints ls 1 ,\
    "dat/T_fourier.csv" using "m":(column("CV")-sigma)with linespoints ls 1 lc "magenta" ,\
    "dat/T_fourier.csv" using "m":(column("FCV")-sigma)with linespoints ls 1 lc "orange"

plot "dat/T_fourier.csv" using "m":(abs(column("L2error")**2-column("CV")+sigma)) with linespoints ls 1

plot "dat/T_fourier.csv" using "m":(abs(column("CV")-column("FCV"))) with linespoints ls 1
