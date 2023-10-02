###################################################################################################
# ChebyshevPoints #################################################################################
###################################################################################################

struct ChebyshevPoints <: Points
    n::Int
    d::Int
end



# length ##########################################################################################

"""
    n = length(X)

# Input
 - `X::ChebyshevPoints`

# Output
 - `n::Int`: number of points
"""
Base.:length(X::ChebyshevPoints) = X.n^dimension(X)



# dimension #######################################################################################

"""
    d = dimension(X)

# Input
 - `X::ChebyshevPoints`

# Output
 - `d::Int`: dimension of the points
"""
dimension(X::ChebyshevPoints) = X.d



# get_points ######################################################################################

"""
    A = get_points(X)

# Input
 - `X::ChebyshevPoints`

# Output
 - `A::Vector{Vector{Float64}}`: list of points
"""
function get_points(X::ChebyshevPoints)
    return Iterators.product(ntuple(_ -> (cos.(π*(0:X.n-1)/(X.n-1)) .+ 1)/2, dimension(X))...) .|> collect |> vec
    # flatten to convert tuples to vectors
end



# show ############################################################################################

Base.show(io::IO, X::ChebyshevPoints) = print(io, length(X), "x", dimension(X), " ChebyshevPoints")




# iterate #########################################################################################

Base.:iterate(X::ChebyshevPoints) = (zeros(Float64, dimension(X)), 2)

function Base.:iterate(X::ChebyshevPoints, state::Int)
    idx = digits(state-1, base = X.n, pad = dimension(X)) .+ 1
    if length(idx) > dimension(X)
        return nothing
    else
        return ((cos.(π*idx/(X.n-1)) .+ 1)/2, state+1)
    end
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################

# Chebyshev points ###############################################################################

"""
    X = points_chebyshev(d, n)

# Input
 - `d::Int`: dimension
 - `n::Int`: number of points in one dimension

# Output
 - `X::ChebyshevPoints`: R^d tensor point grid in d dimensions
"""
function points_chebyshev(d::Int, n::Int)::ChebyshevPoints
    ChebyshevPoints(n, d)
end
