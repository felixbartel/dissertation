set terminal cairolatex size 3cm, 3cm

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

set output "img/rank1.tex"
plot for [i=0:21] 21*x-i lc rgb "#aaaaaa",\
  "dat/r1l.dat" with points pt 7 lc "black" ps 0.4

set output "img/rank1_sub.tex"
plot for [i=0:21] 21*x-i lc rgb "#aaaaaa",\
  "dat/r1l.dat" with points pt 7 lc rgb "#aaaaaa" ps 0.4,\
  "dat/r1l_sub.dat" with points pt 7 lc "black" ps 0.4

set output "img/rank1_subsub.tex"
plot for [i=0:21] 21*x-i lc rgb "#aaaaaa",\
  "dat/r1l_sub.dat" with points pt 7 lc rgb "#aaaaaa" ps 0.4,\
  "dat/r1l_subsub.dat" with points pt 7 lc "black" ps 0.4

set output "img/rand.tex"
plot "dat/rand.dat" with points pt 7 lc "black" ps 0.4

set output "img/rand_sub.tex"
plot "dat/rand.dat" with points pt 7 lc rgb "#aaaaaa" ps 0.4,\
    "dat/rand_sub.dat" with points pt 7 lc "black" ps 0.4,\
