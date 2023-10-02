set terminal cairolatex size 12cm, 5cm
set output 'img/wc_bss_talk.tex'

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set xrange [10:]
set xtics 10 offset 0, 0.3
set ytics 100 offset 0.7, 0

set tmargin 2
set bmargin 3

set lmargin 2
set rmargin 2

set grid lt 1 lc 'gray'

set style line 1 lw 2.5 ps 0.25 pt 7 lc 'black'

set multiplot layout 1,2

set xlabel '\scriptsize \# of points' offset 0,1

set title '$L_2$-error'

set ytics 10

plot 'dat/wc_bss.csv' using 'M':(column('E_trun')+column('E_full')) with linespoints ls 1,\
    'dat/wc_bss.csv' using 'nu':((column('E_trun')+column('E_rand'))*column('E_rand')/column('E_rand')) with linespoints ls 1 lc rgb '#0080ff',\
    'dat/wc_bss.csv' using 'nu':(column('E_trun')+column('E_s')) with linespoints ls 1 lc rgb '#A10B70',\
    'dat/wc_bss.csv' using 'np':(column('E_trun')+column('E_bss')) with linespoints ls 1 lc rgb '#f37735'
# division by zero to not plot where we do not have E_rand

set title 'time in seconds'

set xlabel '\scriptsize \# of frequencies'
set ytics 1000

plot'dat/wc_bss.csv' using 'm':'T_full' with linespoints ls 1,\
    'dat/wc_bss.csv' using 'm':'T_rand_lsqr' with linespoints ls 1 lc rgb '#0080ff',\
    'dat/wc_bss.csv' using 'm':'T_s_lsqr' with linespoints ls 1 lc rgb '#A10B70',\
    'dat/wc_bss.csv' using 'm':'T_bss_lsqr' with linespoints ls 1 lc rgb '#f37735',\
    'dat/wc_bss.csv' using 'm':'T_bss_setup' with linespoints ls 1 dt (8,4) lc rgb '#f37735',\
