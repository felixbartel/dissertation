using DelimitedFiles

function csvminmaxavg(M...)
    M_min = [ min(getindex.(M, idx)...) for idx in eachindex(M[1]) ]
    M_min = reshape(M_min, size(M[1]))

    M_max = [ max(getindex.(M, idx)...) for idx in eachindex(M[1]) ]
    M_max = reshape(M_max, size(M[1]))

    function avg(list...)
        if !all(el -> el == typeof(list[1]), typeof.(list))
            error("not all elements are the same type")
        end
        if isa(list[1], Number)
            return sum(list)/length(list)
        elseif isa(list[1], SubString{String}) && all(el -> el == list[1], list)
            return list[1]
        else
            return NaN
        end
    end

    M_avg = [ avg(getindex.(M, idx)...) for idx in eachindex(M[1]) ]
    M_avg = reshape(M_avg, size(M[1]))

    return M_min, M_max, M_avg
end

flist = [ f for f in readdir() if contains(f, "experiment_run") ]

M = [ readdlm(f) for f in flist ]

M_min, M_max, M_avg = csvminmaxavg(M...)

M_min[1, :] .*= "_min"
M_max[1, :] .*= "_max"
M_avg[1, :] .*= "_avg"


writedlm("experiment_minmaxavg.csv", [M_min M_max M_avg])
