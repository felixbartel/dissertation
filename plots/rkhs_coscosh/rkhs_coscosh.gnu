# coscosh ##################################################
reset
set terminal cairolatex size 6cm, 3.75cm
set output "img/rkhs_coscosh.tex"

unset key
unset border
unset tics

set bmargin 1
set tmargin 2.5
set rmargin 2
set lmargin 0.5

set arrow from 0,0 to 3*pi+0.3,0 head size screen 0.02,25 lw 2
set label '$x$' at 3*pi+0.5,0
set arrow from 0,-1.3 to 0,1.3 head size screen 0.02,25 lw 2
set label '$y$' at -0.1,1.55

set arrow from pi/2,0.1 to pi/2,-0.1 nohead lw 2
set label '$\pi/2$' at pi/2-0.3,-0.3
set arrow from 3*pi/2,0.1 to 3*pi/2,-0.1 nohead lw 2
set label '$3\pi/2$' at 3*pi/2-0.4,-0.3
set arrow from 5*pi/2,0.1 to 5*pi/2,-0.1 nohead lw 2
set label '$5\pi/2$' at 5*pi/2-0.4,-0.3

set xrange [0:3*pi]
set yrange [-1:1]

plot cos(x) linecolor black lw 2, 1/cosh(x) linecolor black lw 2


