using DelimitedFiles, Random

z = [1, 21]
M = 55

Ms = 35
Mss = 20

X = [ mod.(i*z/M, 1) for i in 1:M ]

idcs = randperm(M)[1:Ms]
Xs = X[idcs]
idcs = randperm(Ms)[1:Mss]
Xss = Xs[idcs]

writedlm("dat/r1l.dat", [getindex.(X, 1) getindex.(X, 2)])
writedlm("dat/r1l_sub.dat", [getindex.(Xs, 1) getindex.(Xs, 2)])
writedlm("dat/r1l_subsub.dat", [getindex.(Xss, 1) getindex.(Xss, 2)])
