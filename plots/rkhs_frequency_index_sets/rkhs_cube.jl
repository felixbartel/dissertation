using DelimitedFiles
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

R = 6

freqs = frequency_cube(3, -R, R)

freqs_vec = get_frequencies(freqs)
M = 2*maximum(abs.(hcat(freqs_vec...)))
p = sortperm(M^2*getindex.(freqs_vec, 3)+M*getindex.(freqs_vec, 2)+getindex.(freqs_vec, 1))
freqs_vec = freqs_vec[p, :]

writedlm("dat/cube.dat", hcat(freqs_vec...)')
