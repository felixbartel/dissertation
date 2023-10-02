###################################################################################################
# FrequencyList ###################################################################################
###################################################################################################

"""
    freqs = FrequencyList(A)

# Input
 - `A::Vector{Vector{Int}}`: list of frequencies

# Output
 - `freqs::FrequencyList`
"""
struct FrequencyList <: Frequencies
    freqs::Vector{Vector{Int}}
end



# length ##########################################################################################

"""
    n = length(freqs)

# Input
 - `freqs::FrequencyList`

# Output
 - `n::Int`: number of frequencies
"""
Base.:length(freqs::FrequencyList) = length(get_frequencies(freqs))



# dimension #######################################################################################

"""
    d = dimension(freqs)

# Input
 - `freqs::FrequencyList`

# Output
 - `d::Int`: dimension of the frequencies
"""
dimension(freqs::FrequencyList) = length(get_frequencies(freqs)[1])



# get_frequencies #################################################################################

"""
    A = get_frequencies(freqs)

# Input
 - `freqs::frequencyList`

# Output
 - `A::Vector{Vector{Float64}}`: list of frequencies
"""
get_frequencies(freqs::FrequencyList) = freqs.freqs



# show ############################################################################################

Base.show(io::IO, freqs::FrequencyList) = print(io, length(freqs), "x", dimension(freqs), " FrequencyList")



# iterate #########################################################################################

Base.:iterate(freqs::FrequencyList) = (freqs.freqs[1], 2)

function Base.:iterate(freqs::FrequencyList, state::Int)
    return ( state <= length(freqs) ) ? (freqs.freqs[state], state+1) : nothing
end



# nonnegative #####################################################################################

"""
    freqs = nonnegative(freqs)

# Input
 - `freqs::FrequencyList`: frequency index set

# Output
 - `freqs::FrequencyList`: frequencies in the nonnegative orthant
"""
function nonnegative(freqs::FrequencyList)::FrequencyList
    return FrequencyList(filter(k -> all(k .>= 0), freqs.freqs))
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################



# hyperbolic_cross_dyadic #########################################################################

"""
    freqs = hyperbolic_cross_dyadic(d, R)
  
# Input
 - `d::Int`: dimension
 - `R::Int`: radius

# Output
 - `freqs::FrequencyList`: frequency index set of a dyadic hyperbolic cross

"""
function hyperbolic_cross_dyadic(d::Int, R::Int)::FrequencyList
    freqs = []
    Gjl = jl -> jl == 0 ? 0 : -2^(jl-1)+1:2^(jl-1)
    for j in Iterators.product(Tuple([0:R for _ in 1:d-1])..., 0) .|> collect |> vec
        sum(j) > R && continue
        j[end] = R-sum(j)
        append!(freqs, Iterators.product(Tuple(map(Gjl, j))...) .|> collect |> vec)
    end
    unique!(freqs)
    return FrequencyList(freqs)
end



# hyperbolic_cross ################################################################################

"""
    freqs = hyperbolic_cross(d, R)
    freqs = hyperbolic_cross(d, R; α = 0.5)
  
# Input
 - `d::Int`: dimension
 - `R::Float64`: radius
 - `α::Number = 1`: weight
 - `basis::Function`: basis function

# Output
 - `freqs::FrequencyList`: sorted frequency index set such that ``\\prod_{j=1}^{d} max{1, |kj|/γ} \\le R/γ``

"""
function hyperbolic_cross(d::Int, R::Real; γ::Number = 1.0, basis::Function=T_fourier)::FrequencyList
    if basis == T_fourier
        w = k -> mapreduce(kj -> max(1, abs(kj)/γ), *, k)
        w_cutoff_low = k -> -(R/w(k) |> floor |> Int)
        w_cutoff_high = k -> (R/w(k) |> floor |> Int)
    elseif basis == I_legendre
        w = k -> mapreduce(kj -> max(1, abs(kj)/γ), *, k)
        w_cutoff_low = k -> 0
        w_cutoff_high = k -> (R/w(k) |> floor |> Int)
    elseif basis == I_h1
        w = k -> prod(kj -> 1 + (π*kj)^2, k)
        w_cutoff_low = k -> 0
        w_cutoff_high = k -> sqrt(max(0, ((1/(w(k)/R)-1))))/π |> floor |> Int
    elseif basis == I_h2
        w = k -> prod(kj -> abs(kj) <= 1 ? 1 : (1 + ((2*abs(kj)-1)*π/2)^4), k)
        w_cutoff_low = k -> 0
        w_cutoff_high = k -> begin
            1/(w(k)/R) <= 1 && return 1
            tmp = (1/(w(k)/R)-1)^(1/4)/π
            return max(1, tmp+1/2) |> floor |> Int
        end
  else
      error("We did not implement the hyperbolic cross for this basis.")
  end

  # construct frequency index set
  freqs = [ [k] for k in w_cutoff_low(0):w_cutoff_high(0) ]
  for j in 2:d
    tmp_low = map(w_cutoff_low, freqs)
    tmp_high = map(w_cutoff_high, freqs)
    idcs = vcat([1], cumsum(tmp_high-tmp_low.+1).+1)
    freqsnew = [ Vector{Int}(undef, j) for idx in 1:idcs[end]-1 ]
    for i in 1:length(idcs)-1
      freqsnew[idcs[i]:idcs[i+1]-1] = [ [freqs[i]; j] for j in tmp_low[i]:tmp_high[i] ]
    end
    freqs = freqsnew
  end

  # sort the frequencies
  p = sortperm(map(w, freqs))
  return FrequencyList(freqs[p])
end
