"""
    val = bump_eval(x)

# Input
 - `x::Float64` or `x::Vector{Float64}`: point of evaluation

# Output
 - `val::Float64`: bump function evaluated in ``x``
"""
function bump_eval(x::Float64)::Float64
  15*5^(3/4)/4/sqrt(3)*max.(1/5 - (x-1/2)^2, 0)
end



function bump_eval(x::Vector{Float64})::Float64
  prod(bump_eval.(x))
end



"""
    val = bump_fhat(x)

# Input
 - `basis::Function`: basis
 - `k::Int` or `k::Vector{Int}`: frequency

# Output
 - `val::Float64`: k-th Fourier coefficient of the bump function
"""
function bump_fhat(basis::Function, k::Vector{Int})::Float64
    prod(bump_fhat.(basis, k));
end



function bump_fhat(basis::Function, k::Int)::Float64
    if basis == T_fourier
          k == 0 ? 5^(1/4) / sqrt(3) :  5*sqrt(3)*5^(1/4)/8*(-1).^k*(sqrt(5)*sin(2*k*pi/sqrt(5))-2*pi*k*cos(2*k*pi/sqrt(5)))/(pi^3*k^3)
    else
        error("Sorry, we did not bother to do this for this basis.")
    end
end

const bump_L2norm = 1
