abstract type Points end

export length, dimension, get_points, show, iterate, scatter, scatter!

include("points/pointlist.jl")
export PointList, points_random, sparse_grid

include("points/rank1lattice.jl")
export Rank1Lattice, fibonacci_lattice

include("points/equispacedpoints.jl")
export equispacedPoints, points_equispaced

include("points/chebyshevpoints.jl")
export ChebyshevPoints, points_chebyshev



###################################################################################################
# functions #######################################################################################
###################################################################################################



# scatter #########################################################################################

"""
    scatter!(X)

# Input
 - `X::Points`: Points

# Output
 - plots the points
"""
function Plots.:scatter!(X::Points)
    if dimension(X) == 1
        Xp = get_points(X)
        scatter!(getindex.(Xp, 1), zeros(length(X)))
    elseif dimension(X) == 2
        Xp = get_points(X)
        scatter!(getindex.(Xp, 1), getindex.(Xp, 2))
    else
        error("scatter: plotting Points is only supported for one- and two-dimensional Points")
    end
end



"""
    scatter(X)

# Input
 - `X::Points`: Points

# Output
 - plots the points
"""
function Plots.:scatter(X::Points)
    if dimension(X) == 1
        p = plot(xlim = (0, 1), ylim = (-1/2, 1/2), aspect_ratio = :equal, legend = false)
        scatter!(X)
    elseif dimension(X) == 2
        p = plot(xlim = (0, 1), ylim = (0, 1), aspect_ratio = :equal, legend = false)
        scatter!(X)
    else
        error("scatter: plotting Points is only supported for one- and two-dimensional Points")
    end
    return p
end



"""
    scatter!(X, y)

# Input
 - `X::Points`: Points
 - `y::Vector{Float64}`: values

# Output
 - plots the points and values
"""
function Plots.:scatter!(X::Points, y::Vector{Float64})
    dimension(X) != 1 && error("scatter: plotting Points is only supported for one-dimensional Points")
    Xp = get_points(X)
    scatter!(getindex.(Xp, 1), y)
end



"""
    scatter(X, y)

# Input
 - `X::Points`: Points
 - `y::Vector{Float64}`: values

# Output
 - plots the points and values
"""
function Plots.:scatter(X::Points, y::Vector{Float64})
    dimension(X) != 1 && error("scatter: plotting Points is only supported for one-dimensional Points")
    p = plot(xlim = (0, 1), legend = false)
    scatter!(X, y)
    return p
end
