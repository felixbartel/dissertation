export system_matrix



"""
    L = basis_matrix(basis, X, freqs)

# Input
 - `basis::Function`: basis function
 - `freqs::Frequencies`: frequency index set
 - `X::Points`: point set

# Output
 - `L::LinearMaps{ComplexF64}`: system matrix with entries ``f_k(x^i)``
"""
function system_matrix(basis::Function, X::Points, freqs::Frequencies)::LinearMap{ComplexF64}
    if ( basis == T_fourier ) && isa(X, Rank1Lattice)
        ks::Vector{Int} = mod.([ dot(k, X.z) for k in freqs ], X.M).+1
        return LinearMap{ComplexF64}(
            fhat -> begin
            fhat_ = zeros(ComplexF64, maximum(ks))
            for (idx, k) in enumerate(ks)
                @inbounds fhat_[k] += fhat[idx]
            end
            length(fhat_)*ifft(fhat_)
        end, f -> fft(f)[ks],
        X.M,
        length(freqs))
    else
        return LinearMap{ComplexF64}([ prod(basis.(k, x)) for x in X, k in freqs ])
    end
end
