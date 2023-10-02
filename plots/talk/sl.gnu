set terminal cairolatex size 3cm, 3cm
set output "img/sl.tex"

unset key
set xrange [0:1]
set yrange [-1.5:1.5]
unset xtics
unset ytics

set border 31 lw 1.5

set margins 0,0,0,0

plot "dat/sl_data.dat" with points pt 7 ps 0.3 lc rgb "black",\
    "dat/fun.dat" with lines lw 1.5 lc rgb "black",\
    "dat/sl_recon.dat" with lines lw 1.5 lc rgb "#A10B70"

