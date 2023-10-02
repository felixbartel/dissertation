# experiment_1d ##################################################
#set terminal cairolatex standalone pdf size 10.5cm, 5cm
#set output "framess_bss.tex"
set terminal cairolatex size 10.7cm, 5cm
set output "img/framess_bss.tex"

unset key
unset border
unset tics

set xrange [0:100]
set yrange [0:8]

set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0

set arrow from 0,1 to 99,1 lw 2 size 2, 15 filled
set arrow from 5,0.8 to 5,1.2 lw 2 nohead
set arrow from 40,1 to 60,1 lw 5 nohead
set label '$0$' at 4.3, 0.2
set label '$\mathds R$' at 96, 1.5

set arrow from 0,4 to 99,4 lw 2 size 2, 15 filled
set arrow from 5,3.8 to 5,4.2 lw 2 nohead
set arrow from 25,4 to 55,4 lw 5 nohead
set label '$0$' at 4.3, 3.2
set label '$\mathds R$' at 96, 4.5

set arrow from 0,7 to 99,7 lw 2 size 2, 15 filled
set arrow from 15,7 to 40,7 lw 5 nohead
set arrow from 5,6.8 to 5,7.2 lw 2 nohead
set label '$0$' at 4.3, 6.2
set label '$\mathds R$' at 96, 7.5

# dashed borders
set arrow from 10,7 to 20,1 lw 1 dt (5, 5) nohead
set arrow from 50,7 to 90,1 lw 1 dt (5, 5) nohead

set arrow from 10,6.8 to 10,7.2 lw 2 nohead
set arrow from 15,3.8 to 15,4.2 lw 2 nohead
set arrow from 20,0.8 to 20,1.2 lw 2 nohead

set label '$\bm l^{(k-1)}$' at 8, 6.2
set label '$\bm l^{(k)}$' at 13, 3.2
set label '$\bm l^{(k+1)}$' at 18, 0.2

set arrow from 50,6.8 to 50,7.2 lw 2 nohead
set arrow from 70,3.8 to 70,4.2 lw 2 nohead
set arrow from 90,0.8 to 90,1.2 lw 2 nohead

set label '$\bm u^{(k-1)}$' at 48, 6.2
set label '$\bm u^{(k)}$' at 68, 3.2
set label '$\bm u^{(k+1)}$' at 88, 0.2

# solid borders
set arrow from 15,7 to 25,4 lw 1 nohead
set arrow from 25,4 to 40,1 lw 1 nohead

set arrow from 15,6.8 to 15,7.2 lw 2 nohead
set arrow from 25,3.8 to 25,4.2 lw 2 nohead
set arrow from 40,0.8 to 40,1.2 lw 2 nohead

set label '$l^{(k-1)}$' at 13, 7.6
set label '$l^{(k)}$' at 23, 4.6
set label '$l^{(k+1)}$' at 38, 1.6

set arrow from 40,7 to 55,4 lw 1 nohead
set arrow from 55,4 to 60,1 lw 1 nohead

set arrow from 40,6.8 to 40,7.2 lw 2 nohead
set arrow from 55,3.8 to 55,4.2 lw 2 nohead
set arrow from 60,0.8 to 60,1.2 lw 2 nohead

set label '$u^{(k-1)}$' at 38, 7.6
set label '$u^{(k)}$' at 53, 4.6
set label '$u^{(k+1)}$' at 58, 1.6

plot "< echo '45 1\n46 1\n49 1\n56 1\n 58 1\n\
30 4\n33 4\n44 4\n47 4\n 49 4\n\
18 7\n20 7\n23 7\n30 7\n 33 7\n\
'" with points pt 7 ps 0.5 lc "black"


