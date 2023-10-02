using Plots, IterativeSolvers, Random

rng = MersenneTwister(3)

# initialization ##################################################################################

#fun = x -> sin(2*π*x)^15
fun1 = x -> (x<1/2)*((4*x-1)^10-1) + (x>1/2)*(-(4*x-3)^10+1)
fun = x -> fun1(mod(2*x, 1))

n = 30
m = 7

X = [ rand(rng) for _ in 1:n ]
freqs = -m:m
y = fun.(X) + 0.2*randn(rng, n)


L = [ exp(2im*π*k*x) for x in X, k in freqs ]

ghat = lsqr(L, fun.(X))



# plotting ########################################################################################

n_plot = 1000
X_plot = [ i/n_plot for i in 0:n_plot ]
L_plot = [ exp(2im*π*k*x) for x in X_plot, k in freqs ]

p = plot(legend = false)
plot!(X_plot, fun.(X_plot), color = :black)
scatter!(X, y, color = :black)
plot!(X_plot, real.(L_plot*ghat))
display(p)



# writedlm ########################################################################################
using DelimitedFiles

writedlm("dat/sl_data.dat", [X y])
writedlm("dat/fun.dat", [X_plot fun.(X_plot)])
writedlm("dat/sl_recon.dat", [X_plot real.(L_plot*ghat)])
