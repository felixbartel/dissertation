set terminal cairolatex size 10.7cm, 8cm
set output 'img/wc_rand.tex'

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set xtics 100 offset 0, 0.3
set ytics 1000 offset 0.7, 0

set tmargin 2
set bmargin 2

set lmargin 7
set rmargin 2

set grid lt 1 lc 'gray'

set style line 1 lw 2.5 ps 0.25 pt 7 lc 'black'

set multiplot layout 2,2

set xlabel '\scriptsize \# of frequencies' offset 0, 1

set title 'truncation and aliasing $L_2$-error' offset 0, -0.7

set xrange [10:1.1e6]

plot 'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_trun_avg' with lines ls 1 dt (8,4) lc 'black',\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_full_avg' with linespoints ls 1 lc rgb "#000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_full_min':'E_full_max' with filledcurves lc rgb "#99000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_s_avg' with linespoints ls 1 lc rgb "#a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_s_min':'E_s_max' with filledcurves lc rgb "#99a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'E_rand_avg' with linespoints ls 1 lc rgb "#0080ff",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':(column('E_rand_min')**2/column('E_rand_min')):'E_rand_max' with filledcurves lc rgb "#990080ff",\
# division by zero to not plot where we do not have E_rand

set ytics 100

set title '\# of points'

plot 'dat/wc_rand_minmaxavg.csv' using 'm_avg':'M_avg' with linespoints ls 1 lc rgb "#000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'M_min':'M_max' with filledcurves lc rgb "#99000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'nu_avg' with linespoints ls 1 lc rgb "#a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'nu_min':'nu_max' with filledcurves lc rgb "#99a10b70"

set xlabel '\scriptsize \# of points'

set title '$L_2$-error'

set xrange [10:1.1e9]

plot 'dat/wc_rand_minmaxavg.csv' using 'M_avg':(column('E_trun_avg')+column('E_full_avg')) with linespoints ls 1 lc rgb "#000000",\
    'dat/wc_rand_minmaxavg.csv' using 'M_avg':(column('E_trun_min')+column('E_full_min')):(column('E_trun_max')+column('E_full_max')) with filledcurves lc rgb "#99000000",\
    'dat/wc_rand_minmaxavg.csv' using 'nu_avg':(column('E_trun_avg')+column('E_s_avg')) with linespoints ls 1 lc rgb "#a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'nu_avg':(column('E_trun_min')+column('E_s_min')):(column('E_trun_max')+column('E_s_max')) with filledcurves lc rgb "#99a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'nu_avg':((column('E_trun_avg')+column('E_rand_avg'))*column('E_rand_min')/column('E_rand_min')) with linespoints ls 1 lc rgb "#0080ff",\
    'dat/wc_rand_minmaxavg.csv' using 'nu_avg':((column('E_trun_min')+column('E_rand_min'))*column('E_rand_min')/column('E_rand_min')):(column('E_trun_max')+column('E_rand_max')) with filledcurves lc rgb "#990080ff",\
# division by zero to not plot where we do not have E_rand

set title 'time in seconds'

set xlabel '\scriptsize \# of frequencies'

set xrange [10:1.1e6]

plot 'dat/wc_rand_minmaxavg.csv' using 'm_avg':'T_full_avg' with linespoints ls 1 lc rgb "#000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'T_full_min':'T_full_max' with filledcurves lc rgb "#99000000",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'T_s_lsqr_avg' with linespoints ls 1 lc rgb "#a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'T_s_lsqr_min':'T_s_lsqr_max' with filledcurves lc rgb "#99a10b70",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':'T_rand_lsqr_avg' with linespoints ls 1 lc rgb "#0080ff",\
    'dat/wc_rand_minmaxavg.csv' using 'm_avg':((column('T_rand_lsqr_min'))*column('E_rand_min')/column('E_rand_min')):(column('T_rand_lsqr_max')) with filledcurves lc rgb "#990080ff",\
