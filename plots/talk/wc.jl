using Plots, IterativeSolvers

# initialization ##################################################################################

#fun = x -> sin(2*π*x)^15
fun1 = x -> (x<1/2)*((4*x-1)^10-1) + (x>1/2)*(-(4*x-3)^10+1)
fun = x -> fun1(mod(2*x, 1))

n = 24
m = 7

X = [ i/n for i in 0:n-1 ]
freqs = -m:m


L = [ exp(2im*π*k*x) for x in X, k in freqs ]

ghat = lsqr(L, fun.(X))



# plotting ########################################################################################

n_plot = 1000
X_plot = [ i/n_plot for i in 0:n_plot ]
L_plot = [ exp(2im*π*k*x) for x in X_plot, k in freqs ]

#p = plot(legend = false)
#plot!(X_plot, fun.(X_plot), color = :black)
#scatter!(X, fun.(X), color = :black)
#plot!(X_plot, real.(L_plot*ghat))



# writedlm ########################################################################################
using DelimitedFiles

writedlm("dat/wc_data.dat", [X fun.(X)])
writedlm("dat/fun.dat", [X_plot fun.(X_plot)])
writedlm("dat/wc_recon.dat", [X_plot real.(L_plot*ghat)])
