set terminal cairolatex size 12cm, 5cm

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set grid lt 1 lc 'gray'

set xlabel '\scriptsize \# of frequencies' offset 0,0.5

set style line 1 lw 1.5 ps 0.2 pt 7 lc 'black'

set xrange [10:10000]

set lmargin 2
set rmargin 2
set tmargin 2
set bmargin 3



##################################################################################################
set output "img/sl_3d.tex"
set multiplot layout 1,2

set title '$\sigma^2=0$'
set yrange [1e-7:1]
set ytics 1e-9,1000 offset 0.5
plot "dat/sl_3d_0.csv" using "m":(column("E_alias")+column("E_trun")) with linespoints ls 1

set title '$\sigma^2=0.01$'
set yrange [5e-4:1]
set ytics 1e-9,10 offset 0.5
plot "dat/sl_3d_1.csv" using "m":(column("E_alias")+column("E_trun")) with linespoints ls 1


unset multiplot
###################################################################################################
set output "img/sl_3d_cv.tex"
set multiplot layout 1,2

set title '$\sigma^2=0$'
sigma = "`cat dat/sl_3d_0_sigma.csv`"
set yrange [1e-7:1]
set ytics 1e-9,1000 offset 0.5
plot "dat/sl_3d_0.csv" using "m":(column("E_alias")+column("E_trun")) with linespoints ls 1 ,\
    "dat/sl_3d_0.csv" using "m":(column("FCV")-sigma)with linespoints ls 1 lc "orange",\
    "dat/sl_3d_0.csv" using "m":(abs(column("E_alias")+column("E_trun")-column("FCV")+sigma)) with linespoints ls 1 lc "gray"

set title '$\sigma^2=0.01$'
sigma = "`cat dat/sl_3d_1_sigma.csv`"
set yrange [1e-5:1]
set ytics 1e-9,100 offset 0.5
plot "dat/sl_3d_1.csv" using "m":(column("E_alias")+column("E_trun")) with linespoints ls 1 ,\
    "dat/sl_3d_1.csv" using "m":(column("FCV")-sigma)with linespoints ls 1 lc "orange",\
    "dat/sl_3d_1.csv" using "m":(abs(column("E_alias")+column("E_trun")-column("FCV")+sigma)) with linespoints ls 1 lc "gray"
