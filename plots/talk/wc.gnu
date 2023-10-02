set terminal cairolatex size 3cm, 3cm
set output "img/wc.tex"

unset key
set xrange [0:1]
set yrange [-1.2:1.2]
unset xtics
unset ytics

set border 31 lw 1.5

set margins 0,0,0,0

plot "dat/wc_data.dat" with points pt 7 ps 0.3 lc rgb "black",\
    "dat/fun.dat" with lines lw 1.5 lc rgb "black",\
    "dat/wc_recon.dat" with lines lw 1.5 lc rgb "#A10B70"

