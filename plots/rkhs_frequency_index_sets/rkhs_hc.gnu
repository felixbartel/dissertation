set terminal cairolatex size 4cm, 4cm
set output "img/rkhs_hc.tex"

unset border
unset tics
unset key
set size ratio -1
set rmargin 0
set lmargin 0
set tmargin 0
set bmargin 0

stats "dat/hc.dat" using 1 prefix "X"
stats "dat/hc.dat" using 2 prefix "Y"
stats "dat/hc.dat" using 3 prefix "Z"
set xrange [X_min-Z_max/2+7.5:X_max+Z_max/2-6]
set yrange [Y_min-Z_max/2+7.5:Y_max+Z_max/2-6]

set table '/dev/null'
add_cube(x,y,z) = sprintf(\
 'call "set_cube.gnu" "%f" "%f" "%f";', x, y, z)

CMD = ''
plot 'dat/hc.dat' u 1:(CMD = CMD.add_cube($1,$2,$3))
eval(CMD)
unset table

plot NaN
