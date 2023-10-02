module LSR

using LinearAlgebra, LegendrePolynomials, Plots, Random, LinearMaps, FFTW, DelimitedFiles

include("src/bases.jl")
include("src/frequencies.jl")
include("src/points.jl")
include("src/system_matrix.jl")
include("src/example_functions.jl")

end
