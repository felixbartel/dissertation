##################################################################################################
# Legendre polynomials ############################################################################
##################################################################################################

"""
    val = I_legendre(k, x)

# Input
 - `k::Int`: degree
 - `x::Float64`: point

# Output
 - `val::Float64`: value of the k-th Legendre polynomail
"""
function I_legendre(k::Int, x::Float64)::Float64
    return Pl(2*x-1, k)*sqrt(2*k+1)
end
