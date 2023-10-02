##################################################################################################
# Chebyshev polynomials ###########################################################################
##################################################################################################

"""
    val = I_chebyshev(k, x)

# Input
 - `k::Int`: degree
 - `x::Float64`: point

# Output
 - `val::Float64`: value of the k-th Chebyshev polynomail
"""
function I_chebyshev(k::Int, x::Float64)::Float64
    if k == 0
        return sqrt(2/π)
    else
        return cos(k*acos(2*x-1))*sqrt(4/π)
    end
end
