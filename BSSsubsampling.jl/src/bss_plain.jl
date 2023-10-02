"""
    idcs, s = bss_plain(Y, b)
    idcs, s = bss_plain(Y, b; A = 1, B = 1, Δ = 1e-14, verbose = false)
  
# Input
 - `Y::Matrix{<:Number}`: frame
 - `b::Number`: target oversampling factor
 - `Δ::Number`: stability parameter

# Output
 - `idcs::Vector{Int}`: BSS-subsampled frame elements
 - `s::Vector{Float64}`: corresponding weights

"""
function bss_plain(Y::Matrix{<:Number}, b::Number; Δ::Number = 1e-14, verbose = false)::Tuple{Vector{Int}, Vector{Float64}}
    M, m = size(Y) # initial frame size

    b <= 1+2/m && @warn "BSS: b has to be bigger than 1+2/m for the theory to work."

    # extend with K elements
    K = ( b < 4 ) ? ceil((b-1)*m/3) : m
    # oversampling factor for bss
    b2 = b*m/(m+K)

    # construct extension
    Y = hcat(1/sqrt(M)*[exp(2im*π*k*j/M) for j in 1:M, k in 1:K], Y)
    #
    # orthogonalize
    Y = Matrix(qr(Y).Q)

    # apply BSS
    idcs, s = bss(Y, b2; Δ = Δ, verbose = verbose)

    return idcs, s
end
