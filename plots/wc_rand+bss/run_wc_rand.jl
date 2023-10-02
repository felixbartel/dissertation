niter = 10

for iter in 1:niter
    include("wc_rand.jl")
    mv("data/wc_rand.csv", "data/wc_rand_run"*string(iter)*".csv")
end
