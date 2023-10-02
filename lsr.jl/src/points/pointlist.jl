###################################################################################################
# PointList #######################################################################################
###################################################################################################

"""
    X = PointList(A)

# Input
 - `A::Vector{Vector{Float64}}`: list of points

# Output
 - `X::PointList`
"""
struct PointList <: Points
    X::Vector{Vector{Float64}}
end



# length ##########################################################################################

"""
    n = length(X)

# Input
 - `X::PointList`

# Output
 - `n::Int`: number of points
"""
Base.:length(X::PointList) = length(get_points(X))



# dimension #######################################################################################

"""
    d = dimension(X)

# Input
 - `X::PointList`

# Output
 - `d::Int`: dimension of the points
"""
dimension(X::PointList) = length(get_points(X)[1])



# get_points ######################################################################################

"""
    A = get_points(X)

# Input
 - `X::PointList`

# Output
 - `A::Vector{Vector{Float64}}`: list of points
"""
get_points(X::PointList) = X.X



# show ############################################################################################

Base.show(io::IO, X::PointList) = print(io, length(X), "x", dimension(X), " PointList")



# iterate #########################################################################################

Base.:iterate(X::PointList) = (X.X[1], 2)

function Base.:iterate(X::PointList, state::Int)
    return ( state <= length(X) ) ? (X.X[state], state+1) : nothing
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################



# points_random ###################################################################################

"""
    X = points_random(d, n)
    X = points_random(d, n; type = type)
    X = points_random(rng, d, n)
    X = points_random(rng, d, n; type = type)

# Input
 - `rng`: random number generator
 - `d::Int`: dimension
 - `n::Int`: number of points
 - `type::Symbol`: :uniform (default) or :chebyshev distribution

# Output
 - `X::PointList`: n random points in d dimensions
"""
function points_random(d::Int, n::Int; type::Symbol = :uniform)::PointList
    if type == :uniform
        return PointList([ rand(d) for _ in 1:n ])
    elseif type == :chebyshev
        return PointList([ (cos.(π*rand(d)) .+ 1)/2 for _ in 1:n ])
    else
        error("points_random: This type of random Points is not implemented.")
    end
end



function points_random(rng, d::Int, n::Int; type::Symbol = :uniform)::PointList
    if type == :uniform
        return PointList([ rand(rng, d) for _ in 1:n ])
    elseif type == :chebyshev
        return PointList([ (cos.(π*rand(rng, d)) .+ 1)/2 for _ in 1:n ])
    else
        error("points_random: This type of random Points is not implemented.")
    end
end



# sparse_grid #####################################################################################

"""
    X = sparse_grid(d, R)

# Input
 - `d::Int`: dimension
 - `R::Int`: radius of the hyperbolic cross for which he points are exact

# Output
 - `X::PointList`: sparse grid in d dimensions
"""
function sparse_grid(d, R)::PointList
    X = []
    for j in Iterators.product(Tuple([0:R for _ in 1:d-1])..., 0) .|> collect |> vec
        sum(j) > R && continue
        j[end] = R-sum(j)
        append!(X, Iterators.product(Tuple([ (0:2^jl-1)./2^jl for jl in j])...) .|> collect |> vec)
    end
    unique!(X)
    return PointList(X)
end



