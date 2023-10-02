set terminal cairolatex size 10.7cm, 3cm

set size square

unset key
set xrange [0:1]
set yrange [-0.2:1.2]
#unset xtics
#unset ytics
set xtics 1
set ytics 1

set lmargin 1
set rmargin 0
set tmargin 0
set bmargin 1

#set key at screen 1,screen 0.35
#set key spacing 1.5


set output "img/sl_polynomial.tex"

set multiplot layout 1,3

plot x**2 lc rgb "#777777",\
    "dat/polynomial0_approximation.dat" with lines lw 1 lc rgb "black",\
    "dat/measurements.dat" with points pt 7 ps 0.4 lc rgb "black"

set lmargin 3

plot x**2 lc rgb "#777777",\
    "dat/polynomial2_approximation.dat" with lines lw 1 lc rgb "black",\
    "dat/measurements.dat" with points pt 7 ps 0.4 lc rgb "black"

plot x**2 lc rgb "#777777",\
    "dat/polynomial14_approximation.dat" with lines lw 1 lc rgb "black",\
    "dat/measurements.dat" with points pt 7 ps 0.4 lc rgb "black"

