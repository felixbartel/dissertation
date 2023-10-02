set terminal cairolatex size 10.7cm, 4.3cm
set output "img/cv_5d.tex"

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set grid lt 1 lc 'gray'

set xlabel '$m$' offset 0,0.5

set style line 1 lw 1.5 ps 0.2 pt 7 lc 'black'

set multiplot layout 1,3

set xrange [30:14500]
set yrange [1e-12:1e-5]
set ytics 1e-12,1000 offset 0.5

set lmargin 4.6
set rmargin 0.6
set tmargin 2
set bmargin 2

set title '$\sigma^2 = 0.00$'
sigma = "`cat dat/I_h2_0_sigma.csv`"
plot "dat/I_h2_0.csv" using "m":(column("L2error_a")+column("L2error_t"))with linespoints ls 1 ,\
    "dat/I_h2_0.csv" using "m":(column("FCV")-sigma) with linespoints ls 1 lc "orange" ,\
    "dat/I_h2_0.csv" using "m":(abs(column("L2error_a")+column("L2error_t")-column("FCV")+sigma)) with linespoints ls 1 lc rgb "#888888" pt 5

set title '$\sigma^2 = 0.03$'
sigma = "`cat dat/I_h2_3_sigma.csv`"
plot "dat/I_h2_3.csv" using "m":(column("L2error_a")+column("L2error_t"))with linespoints ls 1 ,\
    "dat/I_h2_3.csv" using "m":(column("FCV")-sigma)with linespoints ls 1 lc "orange" ,\
    "dat/I_h2_3.csv" using "m":(abs(column("L2error_a")+column("L2error_t")-column("FCV")+sigma)) with linespoints ls 1 lc rgb "#888888" pt 5

set title '$\sigma^2 = 0.05$'
sigma = "`cat dat/I_h2_5_sigma.csv`"
plot "dat/I_h2_5.csv" using "m":(column("L2error_a")+column("L2error_t"))with linespoints ls 1 ,\
    "dat/I_h2_5.csv" using "m":(column("FCV")-sigma)with linespoints ls 1 lc "orange" ,\
    "dat/I_h2_5.csv" using "m":(abs(column("L2error_a")+column("L2error_t")-column("FCV")+sigma)) with linespoints ls 1 lc rgb "#888888" pt 5
