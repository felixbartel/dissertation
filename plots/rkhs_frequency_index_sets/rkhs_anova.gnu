set terminal cairolatex size 10.7cm, 4cm
set output "img/rkhs_anova.tex"

unset border
unset tics
unset key
set size ratio -1
set rmargin 0
set lmargin 0
set tmargin 0
set bmargin 0

stats "dat/anova3.dat" using 1 prefix "X"
stats "dat/anova3.dat" using 2 prefix "Y"
stats "dat/anova3.dat" using 3 prefix "Z"
set xrange [X_min-Z_max/2:X_max+Z_max/2+2]
set yrange [Y_min-Z_max/2:Y_max+Z_max/2+2]

add_cube(x,y,z) = sprintf(\
 'call "set_cube.gnu" "%f" "%f" "%f";', x, y, z)



set multiplot layout 1,3

set table '/dev/null'
CMD = ''
plot 'dat/anova1.dat' u 1:(CMD = CMD.add_cube($1,$2,$3))
eval(CMD)
unset table

plot NaN
unset object

set table '/dev/null'
CMD = ''
plot 'dat/anova2.dat' u 1:(CMD = CMD.add_cube($1,$2,$3))
eval(CMD)
unset table

plot NaN
unset object

set table '/dev/null'
CMD = ''
plot 'dat/anova3.dat' u 1:(CMD = CMD.add_cube($1,$2,$3))
eval(CMD)
unset table

plot NaN
