using LinearAlgebra, IterativeSolvers, DelimitedFiles, Random
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR
rng = MersenneTwister(43)

fun = x -> prod(xj -> xj^2, x)
σ2 = 0.1

n = 15
m = 3

X = points_random(rng, 1, n)
y = [ fun(x) for x in get_points(X) ] + σ2*randn(rng, n)

freqs = frequency_cube(1, 0, m-1)
L = system_matrix(I_legendre, X, freqs)

ghat = lsqr(L, y)

X_plot = points_equispaced(1, 1000)
L_plot = system_matrix(I_legendre, X_plot, freqs)
g = L_plot*ghat

g2 = g
X_plot2_vec = get_points(X_plot)

for idx in 1:length(X)
    global X_plot2_vec, g2
#    #idx_plot = argmin(abs.(getindex.(X_plot, 1) .- X[idx][1]))
    idx_plot = argmin(abs.(getindex.(X_plot2_vec, 1) .- get_points(X)[idx][1]))
    g2 = [g2[1:idx_plot]; y[idx]; g2[idx_plot:end]]
    X_plot2_vec = [X_plot2_vec[1:idx_plot]; X_plot2_vec[idx_plot]; X_plot2_vec[idx_plot:end]]

end

writedlm("dat/measurements.dat", [getindex.(get_points(X), 1) y])
writedlm("dat/approximation.dat", [getindex.(X_plot2_vec, 1) real.(g2)])
