###################################################################################################
# FrequencyCube ###################################################################################
###################################################################################################



struct FrequencyCube <: Frequencies
    d::Int
    minfreq::Int
    maxfreq::Int
end



# length ##########################################################################################

"""
    n = length(freqs)

# Input
 - `freqs::FrequencyCube`

# Output
 - `n::Int`: number of frequencies
"""
Base.:length(freqs::FrequencyCube) = (freqs.maxfreq-freqs.minfreq+1)^dimension(freqs)



# dimension #######################################################################################

"""
    d = dimension(freqs)

# Input
 - `freqs::FrequencyCube`

# Output
 - `d::Int`: dimension of the frequencies
"""
dimension(freqs::FrequencyCube) = freqs.d



# get_frequencies #################################################################################

"""
    A = get_frequencies(freqs)

# Input
 - `freqs::FrequencyCube`

# Output
 - `A::Vector{Vector{Int}}`: list of frequencies
"""
function get_frequencies(freqs::FrequencyCube)
    return Iterators.product(ntuple(_ -> freqs.minfreq:freqs.maxfreq, dimension(freqs))...) .|> collect |> vec
    # flatten to convert tuples to vectors
end



# show ############################################################################################

Base.show(io::IO, freqs::FrequencyCube) = print(io, length(freqs), "x", dimension(freqs), " FrequencyCube")



# iterate #########################################################################################

Base.:iterate(freqs::FrequencyCube) = (freqs.minfreq*ones(Int, dimension(freqs)), 2)

function Base.:iterate(freqs::FrequencyCube, state::Int)
    freqs.maxfreq == freqs.minfreq && return nothing # only one frequency

    idx = digits(state-1, base = freqs.maxfreq-freqs.minfreq+1, pad = dimension(freqs)) .+ 1
    if length(idx) > dimension(freqs)
        return nothing
    else
        return (freqs.minfreq .+ idx .- 1, state+1)
    end
end



# nonnegative #####################################################################################

"""
    freqs = nonnegative(freqs)

# Input
 - `freqs::FrequencyCube`: frequency index set

# Output
 - `freqs::FrequencyCube`: frequencies in the nonnegative orthant
"""
function nonnegative(freqs::FrequencyCube)::FrequencyCube
    return FrequencyCube(max(0, freqs.minfreq), max(0, freqs.maxfreq), dimension(freqs))
end



###################################################################################################
# constructors ####################################################################################
###################################################################################################



# frequency_cube ##################################################################################

"""
    freqs = frequency_cube(d, minfreq, maxfreq)
  
# Input
 - `d::Int`: dimension
 - `minfreq::Int`: minimal frequency
 - `maxfreq::Int`: maximal frequency

# Output
 - `freqs::FrequencyCube`: frequency index set

"""
function frequency_cube(d::Int, minfreq::Int, maxfreq::Int)::FrequencyCube
    FrequencyCube(d, minfreq, maxfreq)
end
