set terminal cairolatex size 8cm, 5cm
set output "img/cv_hiiproof.tex"

unset border
unset tics
unset key
set size ratio -1
set xrange [-1.4:0.9]
set yrange [-0.3:1.15]
set rmargin 0
set lmargin 0
set bmargin 0
set tmargin 0

set style line 1 lc black lw 2.3
set style line 2 lc black

set arrow from 0,0 to 0,1 nohead ls 1
set arrow from -0.433,-0.25 to 0.866,0.5 nohead ls 1
set arrow from 0,1 to 0.433,0.25 nohead ls 1
set arrow from 0,0.25 to 0.433,0.25 nohead ls 1

set arrow from 0,0.25 rto -0.2,0 nohead ls 2
set arrow from -0.15,0.25 to -0.15,1 heads size screen 0.03,15 ls 2
set label '$\|\bm y\|_{\bm W}-\frac{\langle\bm y, \bm L\bm{\hat g}\rangle_{\bm W}}{\|\bm y\|_{\bm W}}$' at -0.98,0.62

set arrow from 0,0 rto -1.1,0 nohead ls 2
set arrow from 0,1 rto -1.1,0 nohead ls 2
set arrow from -1.05,0 to -1.05,1 heads size screen 0.03,15 ls 2
set label '$\|\bm y\|_{\bm W}$' at -1.35,0.5

set arrow from 0,1 rto 0.1732,0.1 nohead ls 2
set arrow from 0.13,1.075 to 0.5629,0.325 heads size screen 0.03,15 ls 2
set label '$\|\bm L\bm{\hat g} - \bm y\|_{\bm W}$' at 0.37,0.77

set label '$\bm 0$' at -0.025,-0.08
set label '$\bm y$' at -0.03,1.1
set label '$\bm L\bm{\hat g}$' at 0.41,0.16

plot "<echo '0 0\n0 1\n0.433 0.25\n0 0.25'" w points pt 7 ps 0.5 linecolor black,\
