using Random, LinearAlgebra
!(@isdefined BSSsubsampling) && include("../../BSSsubsampling.jl/BSSsubsampling.jl")
using .BSSsubsampling
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

rng = MersenneTwister(7)



# initialization ##################################################

d = 25
max_freq = 1000
m = 500
freqs = FrequencyList([ rand(-max_freq:max_freq, d) for _ in 1:m ] )

function y(i) # on the fly Fourier row
    x = zeros(Float64, d)
    for j in 1:d
        x[j] = mod(i, 2*max_freq+1)/(2*max_freq+1)
        i = BigInt(floor(i/(2*max_freq+1)))
    end
    return [ exp(2im*π*dot(k, x)) for k in freqs ]
end
M = BigInt(2*max_freq+1)^d



# computations ##################################################

bs = exp.(range(log(1+10/m-1), log(2-1), length = 10)) .+ 1
A = zeros(length(bs))
B = zeros(length(bs))

for (idx, b) in enumerate(bs)
    @show idx/length(bs)
    idcs_bss, W_bss = bss(y, b, A = 1, B = 1, M = M, verbose = true)
    n = length(idcs_bss)
    L_bss = sqrt(1/n)*transpose(hcat([ y(i) for i in idcs_bss ]...))
    L_bss = ComplexF64.(L_bss)
    λ = eigvals(L_bss'*L_bss)
    A[idx] = minimum(λ)
    B[idx] = maximum(λ)
end



# write to file ##################################################

using DelimitedFiles

header = ["b"; "A"; "B"]
header = permutedims(header)

data = [header; [bs A B]]

writedlm("dat/grid.dat", data)
