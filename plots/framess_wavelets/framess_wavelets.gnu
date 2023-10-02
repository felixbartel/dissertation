set terminal cairolatex size 10.7cm, 8cm
set output "img/framess_wavelets.tex"

unset key
unset tics

set lmargin 1
set rmargin 1
set tmargin 1
set bmargin 3

set size square

set style line 1 ps 0.2 lc "black" pt 7

set multiplot layout 2,2

set xrange [0:16]
set yrange [0:16]
set label '$I$' at graph 0.5,1.1 center
set label '{\scriptsize $m = 192$}' at graph 0.5,-0.1 center
set object rect from 0,0 to 16,2 fc "gray" lw 0
set object rect from 0,0 to 2,16 fc "gray" lw 0
set object rect from 0,0 to 8,4 fc "gray" lw 0
set object rect from 0,0 to 4,8 fc "gray" lw 0

set object rect from 0,0 to 16,1 front fillstyle empty lw 2
set object rect from 0,0 to 16,2 front fillstyle empty lw 2
set object rect from 0,0 to 16,4 front fillstyle empty lw 2
set object rect from 0,0 to 16,8 front fillstyle empty lw 2
set object rect from 0,0 to 16,16 front fillstyle empty lw 2

set object rect from 0,0 to 1,16 front fillstyle empty lw 2
set object rect from 0,0 to 2,16 front fillstyle empty lw 2
set object rect from 0,0 to 4,16 front fillstyle empty lw 2
set object rect from 0,0 to 8,16 front fillstyle empty lw 2
set object rect from 0,0 to 16,16 front fillstyle empty lw 2

plot NaN
unset label
unset object

set xrange [-0.505:0.505]
set yrange [-0.505:0.505]
set label 'initial points' at graph 0.5,1.1 center
set label '{\scriptsize $M=2400$ ($b\approx 12.5$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=0.01708$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=1.01502$}' at graph 0.5,-0.3 center
plot "dat/points_initial.dat" ls 1
unset label

set label 'BSS subsampling' at graph 0.5,1.1 center
set label '{\scriptsize $n=288$ ($b\approx 1.5$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=0.00321$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=1.05583$}' at graph 0.5,-0.3 center
plot "dat/points_bss.dat" ls 1
unset label

set label 'random subsampling' at graph 0.5,1.1 center
set label '{\scriptsize $n=288$ ($b\approx 1.5$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=0.00030$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=1.13434$}' at graph 0.5,-0.3 center
plot "dat/points_rand.dat" ls 1
