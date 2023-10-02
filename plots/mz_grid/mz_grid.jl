using DelimitedFiles

M = 13

X = [ [i1/M, i2/M] for i1 in 0:M-1, i2 in 0:M-1 ] |> vec

writedlm("dat/grid_t.dat", [ getindex.(X, 1) getindex.(X, 2) ])

X = [ [i1/(M-1), i2/(M-1)] for i1 in 0:M-1, i2 in 0:M-1 ] |> vec
X = [ cos.(π*x) for x in X ]

writedlm("dat/grid_c.dat", [ getindex.(X, 1) getindex.(X, 2) ])


