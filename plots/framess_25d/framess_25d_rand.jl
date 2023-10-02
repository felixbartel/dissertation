using LinearAlgebra, Random
!(@isdefined BSSsubsampling) && include("../../BSSsubsampling.jl/BSSsubsampling.jl")
using .BSSsubsampling
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

rng = MersenneTwister(7)



# initialization ##################################################

d = 25
max_freq = 1000
m = 500
freqs = FrequencyList([ rand(-max_freq:max_freq, d) for _ in 1:m ])

M = Int(ceil(6*m*log(m)))
X = points_random(rng, d, M)

L = system_matrix(T_fourier, X, freqs)/sqrt(M)



# computations ##################################################

bs = exp.(range(log(1+10/m-1), log(2-1), length = 10)) .+ 1
A = zeros(length(bs))
B = zeros(length(bs))

for (idx, b) in enumerate(bs)
    @show idx/length(bs)
    idcs_bss, W_bss = BSSsubsampling.bss_plain(L, b, verbose = true)
    n = length(idcs_bss)
    L_bss = sqrt(M/n)*L[idcs_bss, :]
    λ = eigvals(L_bss'*L_bss)
    A[idx] = minimum(λ)
    B[idx] = maximum(λ)
end



# write to file ##################################################

using DelimitedFiles

header = ["b"; "A"; "B"]
header = permutedims(header)

data = [header; [bs A B]]

writedlm("dat/rand.dat", data)
