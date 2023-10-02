set terminal cairolatex size 3cm, 3cm
set output "img/bump.tex"

unset key
set xrange [0:1]
set yrange [-.1:.3]
unset xtics
unset ytics

set samples 1000

set border 31 lw 1.5

set margins 0,0,0,0

max(x, y) = ( x > y ) ? x : y

plot 3**(1/2)*5**(7/4)/4*max(0, .2-(x-.5)**2) with lines lw 1.5 lc "black"



set output "img/bump2d.tex"

unset border
set view 50,30,1,1
set zrange [0:0.05]
set hidden3d
unset ztics
set isosamples 30

splot [0:1][0:1] 3**(1/2)*5**(7/4)/4*max(0, .2-(x-.5)**2)*3**(1/2)*5**(7/4)/4*max(0, .2-(y-.5)**2) lc "black"
