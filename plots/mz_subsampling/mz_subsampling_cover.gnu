set terminal cairolatex size 3cm, 3cm
set output "img/mz_rank1_cover.tex"

set margins 0,0,0,0
set xrange [0:1]
set yrange [0:1]
set clip
unset key
unset tics
set size ratio -1

# full rank-1 lattice
set lmargin 0
set rmargin 0

plot for [i=0:21] 21*x-i lc rgb "#888888",\
  "dat/r1l.dat" with points pt 7 lc "black" ps 0.4

set output "img/mz_subsamplec_rank1_cover.tex"

# susubsampled rank-1 lattice
plot for [i=0:21] 21*x-i lc rgb "#888888",\
  "dat/r1l_sub.dat" with points pt 7 lc rgb "#888888" ps 0.4,\
  "dat/r1l_subsub.dat" with points pt 7 lc -1 ps 0.4
