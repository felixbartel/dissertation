set terminal cairolatex size 4cm, 4cm
set output "img/rkhs_cube.tex"

unset border
unset tics
unset key
set size ratio -1
set rmargin 0
set lmargin 0
set tmargin 0
set bmargin 0

stats "dat/cube.dat" using 1 prefix "X"
stats "dat/cube.dat" using 2 prefix "Y"
stats "dat/cube.dat" using 3 prefix "Z"
set xrange [X_min-Z_max/2:X_max+Z_max/2]
set yrange [Y_min-Z_max/2:Y_max+Z_max/2]

set table '/dev/null'
add_cube(x,y,z) = sprintf(\
 'call "set_cube.gnu" "%f" "%f" "%f";', x, y, z)

CMD = ''
plot 'dat/cube.dat' u 1:(CMD = CMD.add_cube($1,$2,$3))
eval(CMD)
unset table

plot NaN
