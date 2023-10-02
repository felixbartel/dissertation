set terminal cairolatex size 10.7cm, 7cm
set output "img/sl_1d.tex"

set size square

unset key

set logscale
set format '\scriptsize $10^{%L}$'

set grid lt 1 lc 'gray'

set xlabel '$m$' offset 0,0.5

set style line 1 lw 2 ps 0.1 pt 7 lc "black"

set multiplot layout 2,4

set xrange [2:1000]
set yrange [1e-3:10]
set ytics 1e-2,100 offset 0.5

set lmargin 4.5
set rmargin 0.5
set tmargin 1.5
set bmargin 0.5

set title 'Chebyshev'
plot "dat/I_chebyshev_σmax.csv" with linespoints ls 1,\
    "dat/I_chebyshev_σmin.csv" with linespoints ls 1

set title 'Legendre'
plot "dat/I_legendre_σmax.csv" with linespoints ls 1,\
    "dat/I_legendre_σmin.csv" with linespoints ls 1

set title '$\mathrm H^1$ basis'
plot "dat/I_h1_σmax.csv" with linespoints ls 1,\
    "dat/I_h1_σmin.csv" with linespoints ls 1

set title '$\mathrm H^2$ basis'
plot "dat/I_h2_σmax.csv" with linespoints ls 1,\
    "dat/I_h2_σmin.csv" with linespoints ls 1

unset title

set xrange [2:1000]
set yrange [1e-13:0.01]
set ytics 1e-14,10000 offset 0.5

set tmargin 0.5
set bmargin 1.5

plot "dat/I_chebyshev_L2error.csv" with linespoints ls 1,\
    "dat/I_chebyshev_L2error_exact.csv" with lines ls 1 dt 2,\
    "dat/I_chebyshev_L2error_noise.csv" with lines ls 1 dt 2

plot "dat/I_legendre_L2error.csv" with linespoints ls 1,\
    "dat/I_legendre_L2error_exact.csv" with lines ls 1 dt 2,\
    "dat/I_legendre_L2error_noise.csv" with lines ls 1 dt 2

plot "dat/I_h1_L2error.csv" with linespoints ls 1,\
    "dat/I_h1_L2error_exact.csv" with lines ls 1 dt 2,\
    "dat/I_h1_L2error_noise.csv" with lines ls 1 dt 2

plot "dat/I_h2_L2error.csv" with linespoints ls 1,\
    "dat/I_h2_L2error_exact.csv" with lines ls 1 dt 2,\
    "dat/I_h2_L2error_noise.csv" with lines ls 1 dt 2
