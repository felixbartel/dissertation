set terminal cairolatex size 4cm, 4cm

unset key
set xrange [0:1]
set yrange [-0.2:1.2]
set xtics 1
set ytics 1

set lmargin 1
set rmargin 0
set tmargin 0
set bmargin 1

set output "img/talk_lsqr_quadratic1.tex"

plot "dat/measurements.dat" with points pt 7 ps 0.4 lc rgb "black"

set output "img/talk_lsqr_quadratic2.tex"

plot "dat/measurements.dat" with points pt 7 ps 0.4 lc rgb "black",\
  "dat/approximation.dat" with lines lw 1 lc rgb "black"
