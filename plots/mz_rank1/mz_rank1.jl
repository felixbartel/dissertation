using DelimitedFiles

z = [1, 21]
M = 55

X = [ mod.(i*z/M, 1) for i in 1:M ]

writedlm("dat/r1l.dat", [getindex.(X, 1) getindex.(X, 2)])




n = 9
z = [n, n+1]
X = [ cos.(z*π*i/prod(z)) for i in 0:prod(z) ]
unique!(x -> round.(x .+ 5, digits = 8), X) # .+ 5 since -0 != 0
writedlm("dat/padua.dat", X)
