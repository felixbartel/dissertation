set terminal cairolatex size 6cm, 3.75cm
set output "img/rkhs_h2basis.tex"

unset key
set xrange [0:1]
set yrange [-2.1:2.1]
set xtics 1
set ytics 2

set lmargin 2
set rmargin 0
set tmargin 0
set bmargin 1

set style line 1 lw 2 lc 'black'

plot "dat/h2basis.dat" using 1:2 with lines ls 1,\
    "dat/h2basis.dat" using 1:3 with lines ls 1,\
    "dat/h2basis.dat" using 1:4 with lines ls 1,\
    "dat/h2basis.dat" using 1:5 with lines ls 1,\
    "dat/h2basis.dat" using 1:6 with lines ls 1,\
    "dat/h2basis.dat" using 1:7 with lines ls 1,\

