function bisection(f, left, right)
    f_left = f(left)
    f_right = f(right)
    middle = Int(round((left+right)/2))
    f_middle = f(middle)
    
    while abs(f_middle) > 1e-10 && right-left > 1
        if f_middle < 0
             left = middle
             f_left = f_middle
        else
             right = middle
             f_right = f_middle
        end
        middle = Int(round((left+right)/2))
        f_middle = f(middle)
    end
    return right
end
