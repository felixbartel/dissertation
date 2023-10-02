###################################################################################################
# dilatedB2 ##############################################################################
###################################################################################################


function dilatedB2_eval(x::Float64)::Float64
    return x < 1/2 ? ( -x^2+3/4 ) : ( x^2/2-3/2*x+9/8)
end



function dilatedB2_eval(x::Vector{Float64})::Float64
    return prod(xj -> dilatedB2_eval(xj), x)
end



function dilatedB2_L2norm(basis::Function)::Float64
    if basis == I_h1 || basis == I_h2 || basis == I_legendre
        return sqrt(35/128)
    elseif basis == I_chebyshev
        return sqrt(-1/8+367*π/2048)
    else
        error("Sorry, we did not bother to do this for this basis.")
    end
end



const dilatedB2_range = 5/8



function dilatedB2_fhat(basis::Function, k::Int)::Float64
    if basis == I_h1
        if k == 0
            return 23/48
        else
            return sqrt(2)*(24*sin((k*π)/2) - 4*k*π*cos(k*π))/(8*k^3*π^3)
        end
    elseif basis == I_h2
        if k == 0
            return 23/48
        elseif k == 1
            return -23/(64*sqrt(3))
        else
            if k == 2
                 t = 4.73004074486270402602404810083388481990
            elseif k == 3
                 t = 7.85320462409583755647706668725404979032
            elseif k == 4
                 t = 10.9956078380016709066690325191058924175
            elseif k == 5
                 t = 14.1371654912574641771059178550933307529
            elseif k == 6
                 t = 17.2787596573994814380910739757686440135
            elseif k == 7
                 t = 20.4203522456260610909364111893130796499
            elseif k == 8
                 t = 23.5619449020404550753920168006414978189
            elseif k == 9
                 t = 26.7035375555081862484194076457585722522
            else
                 t  = BigFloat(π*(2k-1)/2)
            end
            if k > 200
                t = BigFloat(t)
            end
            return (-4*cos(t) + 3*(cos(t)-1)*cosh(t/2) + 4*cosh(t) - 3*sinh(t/2)*(sin(t) + 2*cos(t/2)*sinh(t/2)) - 3*sin(t/2)*sinh(t) + 2*sin(t)*sinh(t))/(t^3*(sin(t) - sinh(t)))
        end
        elseif basis == I_chebyshev
            if k == 0
                return 15*√(π/2)/32
            elseif k == 1
                return (1-π)/(√(16*π))
            elseif k == 2
                return -√π/64
            else
                return 3/(4*√π)*sin(k*π/2)/(4*k-k^3)
            end
        elseif basis == I_legendre
            k > 1000 && return error("we did not calculate the legendre coefficients for k > 1000.")
            return readdlm(string(@__DIR__) * "/dilatedB2_fhat_legendre.dat")[k+1]
        else
            error("Sorry, we did not bother to do this for this basis.")
    end
end



function dilatedB2_fhat(basis::Function, k::Vector{Int})::Float64
    return prod(kj -> dilatedB2_fhat(basis, kj), k)
end
