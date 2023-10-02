using DelimitedFiles, LinearAlgebra, Random, Printf
!(@isdefined BSSsubsampling) && include("../../BSSsubsampling.jl/BSSsubsampling.jl")
using .BSSsubsampling
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

rng = MersenneTwister(7)



# initialization ##################################################################################

X = readdlm("wavelet_samples.csv", ',')
X = [ x for x in eachcol(X) ]
L = readdlm("wavelet_matrix.csv", ',')
M, m = size(L)
L = 1/sqrt(M)*L


b = 1.5 # target oversampling factor
n = Int(ceil(b*m)) # target number of nodes



# computations ####################################################################################

# random subsampling
idcs_rand = rand(rng, 1:M, n)

# BSS subsampling
idcs_bss, W_bss = bss_plain(L, b, verbose = true)



# eval ############################################################################################

λ = eigvals(L'*L)
@printf("initial: A = %.5f, B = %.5f\n", λ[1], λ[end])

L_rand = sqrt(M/n)*L[idcs_rand, :]
λ = eigvals(L_rand'*L_rand)
@printf("random: A = %.5f, B = %.5f\n", λ[1], λ[end])

L_bss = sqrt(M/n)*L[idcs_bss, :]
λ = eigvals(L_bss'*L_bss)
@printf("BSS: A = %.5f, B = %.5f\n", λ[1], λ[end])

writedlm("dat/points_initial.dat", X)
writedlm("dat/points_rand.dat", X[idcs_rand])
writedlm("dat/points_bss.dat", X[idcs_bss])
