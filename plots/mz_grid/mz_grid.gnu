set terminal cairolatex size 10.7cm, 4cm
set output "img/mz_grid.tex"

set size square

unset key
set xrange [-0.02:1.02]
set yrange [-0.02:1.02]
set xtics 1
set ytics 1

set lmargin 0.5
set rmargin 0.5
set tmargin 2.5
set bmargin 1.5

set style line 1 ps 0.3 pt 7 lc "black"

set multiplot layout 1,2

set title '$\mathds T^2$'
#set title '$T^2$'
plot "dat/grid_t.dat" with points ls 1


set xrange [-1.04:1.04]
set yrange [-1.04:1.04]
set title '$[-1, 1]^2$'
plot "dat/grid_c.dat" with points ls 1
