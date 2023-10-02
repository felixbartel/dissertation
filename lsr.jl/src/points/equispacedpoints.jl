###################################################################################################
# EquispacedPoints ##################################################################################
###################################################################################################

struct EquispacedPoints <: Points
    n::Int
    d::Int
end



# length ##########################################################################################

"""
    n = length(X)

# Input
 - `X::EquispacedPoints`

# Output
 - `n::Int`: number of points
"""
Base.:length(X::EquispacedPoints) = X.n^dimension(X)



# dimension #######################################################################################

"""
    d = dimension(X)

# Input
 - `X::EquispacedPoints`

# Output
 - `d::Int`: dimension of the points
"""
dimension(X::EquispacedPoints) = X.d



# get_points ######################################################################################

"""
    A = get_points(X)

# Input
 - `X::EquispacedPoints`

# Output
 - `A::Vector{Vector{Float64}}`: list of points
"""
function get_points(X::EquispacedPoints)
    return Iterators.product(ntuple(_ -> (0:X.n-1)/X.n, dimension(X))...) .|> collect |> vec
    # flatten to convert tuples to vectors
end



# show ############################################################################################

Base.show(io::IO, X::EquispacedPoints) = print(io, length(X), "x", dimension(X), " EquispacedPoints")




# iterate #########################################################################################

Base.:iterate(X::EquispacedPoints) = (zeros(Float64, dimension(X)), 2)

function Base.:iterate(X::EquispacedPoints, state::Int)
    idx = digits(state-1, base = X.n, pad = dimension(X))
    if length(idx) > dimension(X)
        return nothing
    else
        return (idx/X.n, state+1)
    end
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################

# equispaced points ###############################################################################

"""
    X = points_equispaced(d, n)

# Input
 - `d::Int`: dimension
 - `n::Int`: number of points in one dimension

# Output
 - `X::EquispacedPoints`: R^d tensor point grid in d dimensions
"""
function points_equispaced(d::Int, n::Int)::EquispacedPoints
    EquispacedPoints(n, d)
end
