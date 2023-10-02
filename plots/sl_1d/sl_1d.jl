using LinearAlgebra, IterativeSolvers, DelimitedFiles, Random, LinearMaps
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

rng = MersenneTwister(7)


# initialization ##################################################################################

d = 1 # dimension
fun_eval = dilatedB2_eval
fun_fhat = dilatedB2_fhat
fun_L2norm = dilatedB2_L2norm
fun_range = dilatedB2_range

n = 10_000 # number of samples
X = points_random(rng, d, n) # points

σ2 = 0.001*fun_range # variance of the noise
ε = σ2*randn(rng, n) # noise
y = fun_eval.(X)+ε # noisy samples

#basis = I_legendre
#basis = I_h1
#basis = I_h2
#W = ones(n)

basis = I_chebyshev
W = [ prod( xj -> 1/sqrt(1-(2*xj-1)^2), x) for x in X ]

m_max = 1000 # maximal number of basis functions
Ms = exp.(range(log.(1), log(m_max), length = 100)) .|> floor .|> Int



# computations ####################################################################################

L2error = Vector{Float64}(undef, length(Ms))
L2error_exact = Vector{Float64}(undef, length(Ms))
L2error_noise = Vector{Float64}(undef, length(Ms))
σmax = Vector{Float64}(undef, length(Ms))
σmin = Vector{Float64}(undef, length(Ms))

for (idx, m) in enumerate(Ms)
    @show idx/length(Ms)

    freqs = frequency_cube(1, 0, m-1)
    L = system_matrix(basis, X, freqs)
    Lw = LinearMap{ComplexF64}(fhat -> sqrt.(W).*(L*fhat), f -> L'*(sqrt.(W).*f), n, m)

    ghat = lsqr(Lw, sqrt.(W).*y, maxiter = 20)

    L2error[idx] = fun_L2norm(basis)^(2d)-norm(fun_fhat.(basis, freqs))^2+norm(ghat-fun_fhat.(basis, freqs))^2

    ghat = lsqr(Lw, sqrt.(W).*fun_eval.(X), maxiter = 20)
    L2error_exact[idx] = fun_L2norm(basis)^(2d)-norm(fun_fhat.(basis, freqs))^2+norm(ghat-fun_fhat.(basis, freqs))^2

    ghat = lsqr(Lw, sqrt.(W).*ε, maxiter = 20)
    L2error_noise[idx] = norm(ghat)^2


    Σ = svdvals(diagm(sqrt.(W))*Matrix(L))

    σmin[idx] = Σ[end]^2/n
    σmax[idx] = Σ[1]^2/n
end



# write csv ##################################################

str = String(Symbol(basis))

data = [Ms L2error]
writedlm("dat/"*str*"_L2error.csv", data)
data = [Ms L2error_exact]
writedlm("dat/"*str*"_L2error_exact.csv", data)
data = [Ms L2error_noise]
writedlm("dat/"*str*"_L2error_noise.csv", data)

data = [Ms σmin]
writedlm("dat/"*str*"_σmin.csv", data)
data = [Ms σmax]
writedlm("dat/"*str*"_σmax.csv", data)
