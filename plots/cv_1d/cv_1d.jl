using LinearAlgebra, DelimitedFiles, IterativeSolvers, Random
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

rng = MersenneTwister(7)



# initialization ##################################################################################

d = 1
n = 3_000
X = points_random(rng, d, n)
σ2 = 0.05
y = b_spline_eval.(2, X) + σ2^2*randn(rng, length(X))

basis = T_fourier
m_max = 2000
R_max = findfirst( R -> length(hyperbolic_cross(d, R, basis = basis)) > m_max, exp.(0:0.1:99))*0.1 |> exp
Rs = exp.(range(0, log(R_max), length = 100)) # radii of the hyperbolic crosses
L2error = Vector{Float64}(undef, length(Rs))
CV = Vector{Float64}(undef, length(Rs))
FCV = Vector{Float64}(undef, length(Rs))
ms = Vector{Float64}(undef, length(Rs))



# computations ####################################################################################

for (idx, R) in enumerate(Rs)
    @show idx/length(Rs)

    freqs = hyperbolic_cross(d, R, basis = basis)

    L = system_matrix(basis, X, freqs) |> Matrix
    ghat = lsqr(L, y)
    phat = b_spline_fhat.(2, basis, freqs)

    h = diag(L*inv(L'*L)*L')
    CV[idx] = norm((L*ghat-y)./(1 .- h))^2/length(X)

    FCV[idx] = norm((L*ghat-y)/(1-length(freqs)/length(X)))^2/length(X)

    L2error[idx] = norm(ghat-phat)^2+b_spline_L2norm(basis)^2-norm(phat)^2 |> sqrt
    ms[idx] = length(freqs)
end



# write csv #######################################################################################

σ2_emp = sum((y-b_spline_eval.(2, X)).^2)/length(X)
writedlm("dat/T_fourier_sigma.csv", σ2_emp)

header = ["m" "L2error" "CV" "FCV"]
data = [header; [ ms L2error CV FCV]]

writedlm("dat/T_fourier.csv", data)
