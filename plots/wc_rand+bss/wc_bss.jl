using LinearAlgebra, IterativeSolvers
using DelimitedFiles
!(@isdefined BSSsubsampling) && include("../../BSSsubsampling.jl/BSSsubsampling.jl")
using .BSSsubsampling
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

include("heuristic_lattice_search.jl")
include("bisection.jl")



# initialization ##################################################################################

d = 5
γ = 0.5
maxfreqs = 7_000
bw_max = bisection( bw -> length(hyperbolic_cross(d, bw, γ = γ))-maxfreqs, 1, 1_000 )

bws = exp.(range(log(1), log(bw_max), length = 25))
bws = unique(Int.(round.(bws)))

ms = zeros(Int, length(bws))
Ms = zeros(Int, length(bws))
ns = zeros(Int, length(bws))
nus = zeros(Int, length(bws))
nps = zeros(Int, length(bws))
E_trun = zeros(Float64, length(bws))
E_full = zeros(Float64, length(bws))
E_s = zeros(Float64, length(bws))
E_rand = zeros(Float64, length(bws))
E_bss = zeros(Float64, length(bws))
T_full = zeros(Float64, length(bws))
T_s_setup = zeros(Float64, length(bws))
T_s_lsqr = zeros(Float64, length(bws))
T_rand_setup = zeros(Float64, length(bws))
T_rand_lsqr = zeros(Float64, length(bws))
T_bss_setup = zeros(Float64, length(bws))
T_bss_lsqr = zeros(Float64, length(bws))

for (idx, bw) in enumerate(bws)
    println(idx/length(bws))

    freqs = hyperbolic_cross(d, bw, γ = γ)
    m = length(freqs)
    ms[idx] = m
    fhat = bumb_fhat.(T_fourier, freqs)

    E_trun[idx] = bumb_L2norm^2 - norm(fhat)^2

    z, M = heuristic_lattice_search(hcat(freqs...)')
    X = Rank1Lattice(z, M)
    Ms[idx] = M
    y = [ bumb_eval(x) for x in X ]

    # random subsample
    n = Int(round(m*log(m)))
    ns[idx] = n
    idcs_s = rand(1:M, n)
    nus[idx] = length(unique(idcs_s))
    
    T_s_setup[idx] = @elapsed begin
        L = system_matrix(T_fourier, X, freqs)
        mask = sparse(1:n, idcs_s, 1, n, M)
    end
        
    T_s_lsqr[idx] = @elapsed ghat = lsqr(mask*L, y[idcs_s],
            atol = 1e-10, btol = 1e-10, maxiter = 10, verbose = true)
    E_s[idx] = norm(fhat-ghat)^2

    # full rank-1 lattice
    T_full[idx] = @elapsed ghat = 1/M*L'*y
    E_full[idx] = norm(fhat-ghat)^2

    # full randomness
    if sizeof(ComplexF64)*nus[idx]*m*1e-9 < 100 # less than 100 GB
        X = points_random(d, nus[idx])
        T_rand_setup[idx] = @elapsed L_rand = system_matrix(T_fourier, X, freqs)
        T_rand_lsqr[idx] = @elapsed ghat = lsqr(L_rand, bumb_eval.(X),
                atol = 1e-10, btol = 1e-10, maxiter = 10, verbose = true)
        E_rand[idx] = norm(fhat-ghat)^2
    end


    b = 2
    np = Int(round(b*m))
    X = Rank1Lattice(z, M)
    X_s = PointList(get_points(X)[idcs_s])
    L_matrix = Matrix(system_matrix(T_fourier, X_s, freqs))
    # watch out: use lfft here!
    T_bss_setup[idx] = @elapsed idcs, s = BSSsubsampling.bss_plain(L_matrix, b, verbose = true)
    np = length(idcs)

    nps[idx] = np
    mask = sparse(1:np, idcs_s[idcs], 1, np, M)
    
    T_bss_lsqr[idx] = @elapsed ghat = lsqr(mask*L, y[idcs_s[idcs]],
        atol = 1e-10, btol = 1e-10, maxiter = 10, verbose = true)

    E_bss[idx] = norm(fhat-ghat)^2

    header = ["m"; "M"; "n"; "nu"; "E_trun"; "E_full"; "E_s"; "E_rand"; "T_full"; "T_s_setup"; "T_s_lsqr"; "T_rand_setup"; "T_rand_lsqr"]
    header = permutedims(header)
    data = [header; [ms Ms ns nus E_trun E_full E_s E_rand T_full T_s_setup T_s_lsqr T_rand_setup T_rand_lsqr]]
    
    writedlm("dat/wc_bss.csv", data)
end

