using LinearAlgebra, DelimitedFiles, IterativeSolvers
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR



# initialization ##################################################################################

d = 5
n = 1_000_000
X = points_random(d, n)
σ2s = [ 0.00, 0.03, 0.05 ]
ys = [ dilatedB2_eval.(X) + (σ2*5/8)^2*randn(length(X)) for σ2 in σ2s ]

basis = I_h2
m_max = 50_000
R_max = findfirst( R -> length(hyperbolic_cross(d, R, basis = basis)) > m_max, exp.(0:0.1:99))*0.1 |> exp
Rs = exp.(range(0, log(R_max), length = 50)) # radii of the hyperbolic crosses
L2error_t = [ Vector{Float64}(undef, length(Rs)) for σ2 in σ2s ]
L2error_a = [ Vector{Float64}(undef, length(Rs)) for σ2 in σ2s ]
CV = [ Vector{Float64}(undef, length(Rs)) for σ2 in σ2s ]
FCV = [ Vector{Float64}(undef, length(Rs)) for σ2 in σ2s ]
ms = [ Vector{Float64}(undef, length(Rs)) for σ2 in σ2s ]

for (idx, σ2) in enumerate(σ2s)
    σ2_emp = sum((ys[idx]-dilatedB2_eval.(X)).^2)/length(X)
    writedlm("dat/I_h2_"*string(Int(round(σ2*100)))*"_sigma.csv", σ2_emp)
end



# computations ####################################################################################

for (idx, R) in enumerate(Rs)
    @show idx/length(Rs)
    freqs = hyperbolic_cross(d, R, basis = basis)
    L = system_matrix(basis, X, freqs)
    h = sum(abs.(Matrix(L)).^2, dims = 2)/length(X)

    phat = dilatedB2_fhat.(basis, freqs)

    for (idx2, σ2) in enumerate(σ2s)
        ms[idx2][idx] = length(freqs)

        ghat = lsqr(L, ys[idx2], maxiter = 20, atol = 1e-16, btol = 1e-16)

        L2error_t[idx2][idx] = dilatedB2_L2norm(basis)^(2*d)-norm(phat)^2
        L2error_a[idx2][idx] = norm(ghat-phat)^2

#        h = diag(L*inv(L'*L)*L')
#        CV[idx2][idx] = norm((eval(g, X)-ys[idx2])./(1 .- h))^2/length(X)

        FCV[idx2][idx] = norm((L*ghat-ys[idx2]) ./ (1 .- h))^2/length(X)

        header = ["m" "L2error_t" "L2error_a" "CV" "FCV"]
        data = [header; [ ms[idx2] L2error_t[idx2] L2error_a[idx2] CV[idx2] FCV[idx2]]]
        writedlm("dat/I_h2_"*string(Int(round(σ2*100)))*".csv", data)
    end
end
