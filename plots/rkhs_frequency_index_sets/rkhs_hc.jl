using DelimitedFiles
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

R = 6

freqs = hyperbolic_cross(3, 15; γ = 0.5)

freqs_vec = get_frequencies(freqs)
M = 2*maximum(abs.(hcat(freqs_vec...)))
p = sortperm(M^2*getindex.(freqs_vec, 3)+M*getindex.(freqs_vec, 2)+getindex.(freqs_vec, 1))
freqs_vec = freqs_vec[p, :]

writedlm("dat/hc.dat", hcat(freqs_vec...)')



#using DelimitedFiles
#include("MyFourierTools.jl")
#
#R = 15
#γ = 0.5
#
#freqs = hyperbolic_cross(3, R, γ = γ)
#@show length(freqs)
#
#M = 2*maximum(abs.(hcat(freqs...)))
#p = sortperm(M^2*getindex.(freqs, 3)+M*getindex.(freqs, 2)+getindex.(freqs, 1))
#freqs = freqs[p, :]
#
#writedlm("hc.dat", hcat(freqs...)')
