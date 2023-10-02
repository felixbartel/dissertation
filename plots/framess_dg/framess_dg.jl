using LinearAlgebra, Printf, Random
!(@isdefined BSSsubsampling) && include("../../BSSsubsampling.jl/BSSsubsampling.jl")
using .BSSsubsampling
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR
rng = MersenneTwister(7)



###################################################################################################
# full system matrix ##############################################################################
###################################################################################################

d = 2

freqs = frequency_cube(d, -6, 6)
m = length(freqs)

max_freq = maximum(abs.(vcat(get_frequencies(freqs)...)))
X = points_equispaced(d, 2*max_freq+1)
X = PointList([ get_points(X); [ mod.(x+[0.01, 0.01], 1) for x in X ] ])

M = length(X)

L = 1/sqrt(M)*system_matrix(T_fourier, X, freqs)

λ = eigvals(L'*L)
@printf("initial: n = %d, A = %.5f, B = %.5f\n", length(X), λ[1], λ[end])



###################################################################################################
# random subsampling ##############################################################################
###################################################################################################

b = 1.1 # target oversampling factor
n = Int(ceil(b*m)) # target number of nodes

idcs_rand = rand(rng, 1:M, n)

L_rand = sqrt(M/n)*L[idcs_rand, :]
λ = eigvals(L_rand'*L_rand)
@printf("random: n = %d, A = %.5f, B = %.5f\n", length(idcs_rand), λ[1], λ[end])



###################################################################################################
# BSS subsampling #################################################################################
###################################################################################################

println()
idcs_bss, W_bss = bss(L, b, A = 1, B = 1, verbose = true)
println()
L_bss = sqrt(M/n)*L[idcs_bss, :]
λ = eigvals(L_bss'*L_bss)
@printf("BSS: n = %d, A = %.5f, B = %.5f\n", length(idcs_bss), λ[1], λ[end])



###################################################################################################
# writing data ####################################################################################
###################################################################################################

using DelimitedFiles

writedlm("dat/freqs.dat", hcat(get_frequencies(freqs)...)')
writedlm("dat/points_initial.dat", hcat(get_points(X)...)')
writedlm("dat/points_random.dat", hcat(get_points(X)[idcs_rand]...)')
writedlm("dat/points_bss.dat", hcat(get_points(X)[idcs_bss]...)')
