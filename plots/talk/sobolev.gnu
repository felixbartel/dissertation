set terminal cairolatex size 4cm, 4cm
set output "img/sobolev.tex"

unset key
unset border
unset tics

set bmargin 0
set tmargin 0
set rmargin 0
set lmargin 0

set xrange [-1:5.5]
set yrange [-1:5.5]

set size ratio -1

set arrow from 0,0 to 4.5,0 head size screen 0.02,25 lw 2
set label '$\partial/\partial x_1$' at 3.9,-0.5
set arrow from 0,0 to 0,4.5 head size screen 0.02,25 lw 2
set label '$\partial/\partial x_2$' at -0.7,5

set arrow from 0,1 to 1,1 nohead lw 2 lc rgb "#A10B70"
set arrow from 1,1 to 1,0 nohead lw 2 lc rgb "#A10B70"

set arrow from 0,2 to 2,2 nohead lw 2 lc rgb "#A10B70"
set arrow from 2,2 to 2,0 nohead lw 2 lc rgb "#A10B70"

set arrow from 0,3 to 3,3 nohead lw 2 lc rgb "#A10B70"
set arrow from 3,3 to 3,0 nohead lw 2 lc rgb "#A10B70"

set arrow from 0,4 to 4,4 nohead lw 2 lc rgb "#A10B70"
set arrow from 4,4 to 4,0 nohead lw 2 lc rgb "#A10B70"

set arrow from 0,1 to 1,0 nohead lw 2 lc rgb "#F37735"
set arrow from 0,2 to 2,0 nohead lw 2 lc rgb "#F37735"
set arrow from 0,3 to 3,0 nohead lw 2 lc rgb "#F37735"
set arrow from 0,4 to 4,0 nohead lw 2 lc rgb "#F37735"

plot "<echo '0 0\n0 1\n0 2\n0 3\n0 4\n\
    1 0\n1 1\n1 2\n1 3\n1 4\n\
    2 0\n2 1\n2 2\n2 3\n2 4\n\
    3 0\n3 1\n3 2\n3 3\n3 4\n\
    4 0\n4 1\n4 2\n4 3\n4 4'"\
    with points pt 7 pointsize 0.5 lc 'black'
