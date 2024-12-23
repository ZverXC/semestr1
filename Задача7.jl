using HorizonSideRobots

function pole(r)
    n::Int = 1
    f::Int = 0
    while true
        f = tudasuda(r, n)
        if f == 1
            break
        else
            n += 1
        end
    end
end

function tudasuda(r, n)
    slide(r, Ost, n)
    if !isborder(r, Nord)
        return 1
    end
    slide(r, West, n*2)
    if !isborder(r, Nord)
        return 1
    end
    slide(r, Ost, n)
    return 0
end

function slide(r, side, n)
    for i in 1:n
        move!(r, side)
    end
end