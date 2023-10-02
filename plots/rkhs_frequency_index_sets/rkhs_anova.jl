using DelimitedFiles
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

R = 6

freqs = frequency_cube(3, -R, R)

freqs_vec = get_frequencies(freqs)
M = 2*maximum(abs.(hcat(freqs_vec...)))
p = sortperm(M^2*getindex.(freqs_vec, 3)+M*getindex.(freqs_vec, 2)+getindex.(freqs_vec, 1))
freqs_vec = freqs_vec[p, :]

freqs1 = [ k for k in freqs_vec if sum(k .!= 0) == 1 ]
freqs2 = [ k for k in freqs_vec if sum(k .!= 0) == 2 ]
freqs3 = [ k for k in freqs_vec if sum(k .!= 0) == 3 ]

writedlm("dat/anova1.dat", hcat(freqs1...)')
writedlm("dat/anova2.dat", hcat(freqs2...)')
writedlm("dat/anova3.dat", hcat(freqs3...)')
