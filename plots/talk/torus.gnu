set terminal cairolatex size 5cm, 5cm
set output "img/torus.tex"

set view equal xyz

unset key
unset border
unset tics

set dummy u, v

circles=50
rings=25

set view 60, 0, 1, 1

set samples 1000

set parametric
set isosamples circles, rings
set hidden3d 
set urange [ -pi : pi ]
set vrange [ -pi : pi ]

splot cos(u)+.5*cos(u)*cos(v),sin(u)+.5*sin(u)*cos(v),.5*sin(v) with lines lc "black"
