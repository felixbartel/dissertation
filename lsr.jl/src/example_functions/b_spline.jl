###################################################################################################
# b_spline_2, bspline_4, and b_spline_6 ###########################################################
###################################################################################################



function b_spline_2_eval(x::Float64)::Float64
    C = sqrt(3/4)
    if ( x >= 0.0 ) && ( x < 0.5 )
        return C*4*x
    elseif ( x >= 0.5 ) && ( x <= 1.0 )
        return C*4*(1-x)
    else
        error("B-spline 2: out of range")
    end
end



function b_spline_4_eval(x::Float64)::Float64
    C = sqrt( 315/604 )
    
    if ( x >= 0.0 ) && ( x < 0.25 )
        return C*128/3*x^3
    elseif ( x >= 0.25 ) && ( x < 0.5 )
        return C*(8/3-32*x+128*x^2-128*x^3)
    elseif ( x >= 0.5 ) && ( x < 0.75 )
        return C*(-88/3-256*x^2+160*x+128*x^3)
    elseif ( x >= 0.75 ) && ( x <= 1.0 )
        return C*(128/3-128*x+128*x^2-(128/3)*x^3)
    else
        error( "B-spline 4: out of range" )
    end
end



function b_spline_6_eval(x::Float64)::Float64
    C = sqrt( 277200/655177 )
    
    if ( x >= 0.0 ) && ( x < 1.0/6.0 )
        return C*1944/5*x^5
    elseif ( x >= 1.0/6.0 ) && ( x < 2.0/6.0 )
        return C*(3/10-9*x+108*x^2-648*x^3+1944*x^4-1944*x^5)
    elseif ( x >= 2.0/6.0 ) && ( x < 0.5 )
        return C*(-237/10+351*x-2052*x^2+5832*x^3-7776*x^4+3888*x^5)
    elseif ( x >= 0.5 ) && ( x < 4.0/6.0 )
        return C*(2193/10+7668*x^2-2079*x+11664*x^4-13608*x^3-3888*x^5)
    elseif ( x >= 4.0/6.0 ) && ( x < 5.0/6.0 )
        return C*(-5487/10+3681*x-9612*x^2+12312*x^3-7776*x^4+1944*x^5)
    elseif ( x >= 5.0/6.0 ) && ( x <= 1.0 )
        return C*(1944/5-1944*x+3888*x^2-3888*x^3+1944*x^4-1944/5*x^5)
    else
        error( "B-spline 6: out of range" )
    end
end



function b_spline_eval(r::Int, x::Vector{Float64})::Float64
    if r == 2
        return prod(xj -> b_spline_2_eval(xj), x)
    elseif r == 4
        return prod(xj -> b_spline_4_eval(xj), x)
    elseif r == 6
        return prod(xj -> b_spline_6_eval(xj), x)
    else
        error("we did not implement that b spline.")
    end
end



function b_spline_L2norm(basis::Function)::Float64
    if basis == T_fourier
        return 1.0
    else
        error("Sorry, we did not bother to do this for this basis.")
    end
end



function b_spline_fhat(r::Int, basis::Function, k::Int)::Float64
    if basis == T_fourier
        if r == 2
            C = sqrt(3/4)
        elseif r == 4
            C = sqrt( 315/604 )
        elseif r == 6
            C = sqrt( 277200/655177 )
        else
            error("we did not implement that b spline.")
        end
        sinc(x::Float64)::Float64 = ( x == 0.0 ) ? 1 : sin(x)/x
        return C * (sinc(π*k/r))^r * cos(π*k)
    else
        error("Sorry, we did not bother to do this for this basis.")
    end
end



function b_spline_fhat(r::Int, basis::Function, k::Vector{Int})::Float64
    return prod(kj -> b_spline_fhat(r, basis, kj), k)
end
