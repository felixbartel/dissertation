set terminal cairolatex size 6cm, 4.5cm
set output "img/framess_25d.tex"

unset key

set lmargin 6
set rmargin 2
set tmargin 2
set bmargin 3

set style line 1 ps 0.25 lc "black" pt 7

set xlabel "$b-1$"
set xrange [0.01:1]

set format '$10^{%L}$'
set logscale
set ytics 100

set label "lower frame bound" at graph 0.5,1.15 center

plot "dat/grid.dat" using ($1-1):"A" with linespoints ls 1 pt 7,\
    "dat/rand.dat" using ($1-1):"A" with linespoints ls 1 pt 5,\
x**1.5 with lines dt 2 linecolor "black"

