using LinearAlgebra, IterativeSolvers
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

include("bisection.jl")



# initialization ##################################################################################

d = 3
γ = 0.5
n = 10_000
X = points_random(d, n)
#σ2 = 0.00
σ2 = 0.01
#σ2 = 0.03
#σ2 = 0.05
y = bumb_eval.(X) .+ sqrt(σ2)*randn(n)
σ2_emp = sum((y-bumb_eval.(X)).^2)/length(X)

maxfreqs = 10_000
bw_max = bisection( bw -> length(hyperbolic_cross(d, bw, γ = γ))-maxfreqs, 1, 1_000 )

bws = exp.(range(log(1), log(bw_max), length = 25))
bws = unique(Int.(round.(bws)))

ms = zeros(Int, length(bws))
E_trun = zeros(Float64, length(bws))
E_alias = zeros(Float64, length(bws))
FCV = zeros(Float64, length(bws))

for (idx, bw) in enumerate(bws)
    println(idx/length(bws))

    freqs = hyperbolic_cross(d, bw, γ = γ)
    m = length(freqs)
    ms[idx] = m
    fhat = bumb_fhat.(T_fourier, freqs)

    E_trun[idx] = bumb_L2norm^2 - norm(fhat)^2

    # full randomness
    L = system_matrix(T_fourier, X, freqs)
    ghat = lsqr(L, y, atol = 1e-10, btol = 1e-10, maxiter = 20, verbose = true)
    E_alias[idx] = norm(fhat-ghat)^2

    FCV[idx] = norm((L*ghat-y)/(1-length(freqs)/length(X)))^2/length(X)

end



# write csv #######################################################################################
using DelimitedFiles
header = ["m"; "E_trun"; "E_alias"; "FCV"]
header = permutedims(header)
data = [header; [ms E_trun E_alias FCV]]

writedlm("dat/sl_3d_1.csv", data)

writedlm("dat/sl_3d_1_sigma.csv", σ2_emp)



# plotting ########################################################################################
using Plots

p = plot(legend = false, axis = :log, ylim = (0.1*minimum(E_trun+E_alias), maximum(E_trun+E_alias)))
plot!(ms, E_trun+E_alias, color = :black)
plot!(ms, FCV .- σ2_emp, color = :orange)
plot!(ms, abs.(E_trun+E_alias - FCV .+ σ2_emp), color = :gray)
plot!(ms, 7e-6*ms, color = :gray)
plot!(ms, 3*ms.^(-3/2), color = :gray)
