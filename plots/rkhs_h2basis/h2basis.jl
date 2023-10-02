using DelimitedFiles
!(@isdefined LSR) && include("../../lsr.jl/lsr.jl")
using .LSR

n = 1000
m = 6

X = [ i/(n-1) for i in 0:(n-1) ]

data = [ I_h2.(k, X) for k in 0:m-1 ]
data = [ getindex.(X, 1) hcat(data...) ]
writedlm("dat/h2basis.dat", data)
