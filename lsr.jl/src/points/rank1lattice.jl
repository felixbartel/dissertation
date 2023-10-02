###################################################################################################
# rank1lattice ####################################################################################
###################################################################################################

struct Rank1Lattice <: Points
    z::Vector{Float64}
    M::Int
end



# length ##########################################################################################

"""
    n = length(X)

# Input
 - `X::Rank1Lattice`

# Output
 - `n::Int`: number of points
"""
Base.:length(X::Rank1Lattice) = X.M



# dimension #######################################################################################

"""
    d = dimension(X)

# Input
 - `X::Rank1Lattice`

# Output
 - `d::Int`: dimension of the points
"""
dimension(X::Rank1Lattice) = length(X.z)



# get_points ######################################################################################

"""
    A = get_points(X)

# Input
 - `X::Rank1Lattice`

# Output
 - `A::Vector{Vector{Float64}}`: list of points
"""
function get_points(X::Rank1Lattice)
    return [ mod.(i/X.M*X.z, 1) for i in 0:X.M-1 ]
end



# show ############################################################################################

Base.show(io::IO, X::Rank1Lattice) = print(io, length(X), "x", dimension(X), " Rank1Lattice")



# iterate #########################################################################################

Base.:iterate(X::Rank1Lattice) = (zeros(dimension(X)), 2)

function Base.:iterate(X::Rank1Lattice, state::Int)
    return ( state < X.M ) ? ( mod.(state/X.M*X.z, 1), state+1) : nothing
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################

# fibonacci_lattice ###############################################################################

"""
    X = fibonacci_lattice(R)

# Input
 - `R::Int`: radius of the l1-ball

# Output
 - `X::Rank1Lattice`: Fibonacci being exact on l1-ball with radius R
"""
function fibonacci_lattice(R::Int)::Rank1Lattice
  fibonacci = n -> ((1+sqrt(5))^n-(1-sqrt(5))^n)/(sqrt(5)*2^n) |> round |> Int
  n = 2
  while n < 100
    if 2*R+1 <= 2*fibonacci(floor(n/2))
      break
    elseif 2*R+1 <= fibonacci(floor(n/2+2))
      n = n+1
      break
    end
    n += 2
  end
  return Rank1Lattice([1, fibonacci(n-1)], fibonacci(n))
end
