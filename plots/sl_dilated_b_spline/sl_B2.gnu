set terminal cairolatex size 6cm, 3.75cm

unset key
set xrange [0:1]
set yrange [0:1]
set xtics 0.5
set ytics 1

set lmargin 1
set rmargin 0
set tmargin 0
set bmargin 1

set output "img/sl_B2.tex"

plot ( x < 0.5 ) ? -x**2+0.75 : 0.5*x**2-1.5*x+1.125 with lines lw 2 lc "black",\
    "<echo '0.5 0.5'" pt 7 ps 0.5 lc "black" notitle
