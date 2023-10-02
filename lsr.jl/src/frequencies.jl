abstract type Frequencies end

export length, dimension, get_frequencies, show, iterate, nonnegative, scatter, scatter!

include("frequencies/frequencylist.jl")
export FrequencyList, hyperbolic_cross, hyperbolic_cross_dyadic

include("frequencies/frequencycube.jl")
export FrequencyCube, frequency_cube



###################################################################################################
# functions #######################################################################################
###################################################################################################



# scatter #########################################################################################

"""
    scatter!(freqs)

# Input
 - `freqs::Frequencies`: frequencies

# Output
 - plots the frequencies
"""
function Plots.:scatter!(freqs::Frequencies)
    dimension(freqs) != 2 && error("plot: plotting Frequencies is only supported for two-dimensional frequencies")

    freqsp = get_frequencies(freqs)
    scatter!(getindex.(freqsp, 1), getindex.(freqsp, 2), markershape = :rect)
end



"""
    scatter(freqs)

# Input
 - `freqs::Frequencies`: frequencies

# Output
 - plots the frequencies
"""
function Plots.:scatter(freqs::Frequencies)
    p = plot(aspect_ratio = :equal, legend = false)
    scatter!(freqs)
    return p
end
