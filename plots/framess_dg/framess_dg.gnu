set terminal cairolatex size 10.7cm, 8cm
set output "img/framess_dg.tex"

unset key
unset tics

set lmargin 1
set rmargin 1
set tmargin 1
set bmargin 3

set size square

set style line 1 ps 0.1 lc "black" pt 7

set multiplot layout 2,2

set xrange [-7:7]
set yrange [-7:7]
set label '{frequencies $I$}' at graph 0.5,1.1 center
set label '{\scriptsize $m = 256$}' at graph 0.5,-0.1 center
plot "dat/freqs.dat" ls 1 pt 4 ps 0.5
unset label

set xrange [-0.01:0.99]
set yrange [-0.01:0.99]
set label '{initial points}' at graph 0.5,1.1 center
set label '{\scriptsize $M=4225$ ($b\approx 16.5$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=1$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=1$}' at graph 0.5,-0.3 center
plot "dat/points_initial.dat" ls 1
unset label


set label '{BSS subsampling}' at graph 0.5,1.1 center
set label '{\scriptsize $n=384$ ($b\approx 1.1$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=0.02278$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=1.81720$}' at graph 0.5,-0.3 center
plot "dat/points_bss.dat" ls 1
unset label


set label '{random subsampling}' at graph 0.5,1.1 center
set label '{\scriptsize $n=384$ ($b\approx 1.1$)}' at graph 0.5,-0.1 center
set label '{\scriptsize $A=0.00475$}' at graph 0.5,-0.2 center
set label '{\scriptsize $B=4.58234$}' at graph 0.5,-0.3 center
plot "dat/points_random.dat" ls 1
unset label
