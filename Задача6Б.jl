using HorizonSideRobots

function pole(r)
    d::Int = 0
    l::Int = 0
    x, y::Int = 0, 0 
    d, l = ugol(r)
    x, y = r_pole(r)
    ugol(r)
    perimetr(r,d,l,x,y)
end

function ugol(r)
    d::Int = 0
    l::Int = 0
    for side in (Sud, West)
        while !isborder(r, side)
            move!(r, side)
            if side == Sud
                d += 1
            else
                l += 1
            end
        end
    end
    return d, l
end

function perimetr(r,d,l,x,y)
    d1::Int = y - d
    l1::Int = x - l
    for side in (Ost, Nord, West, Sud)
        cnt::Int = 0
        while !isborder(r, side)
            move!(r, side)
            cnt += 1
            if (side == Ost && cnt == l) || (side == Nord && cnt == d) || (side == West && cnt == l1) || (side == Sud && cnt == d1)
                putmarker!(r)
            end
        end
    end
end

function r_pole(r)
    x::Int = 0
    y::Int = 0
    while !isborder(r, Ost)
        move!(r, Ost)
        x += 1
    end
    while !isborder(r, Nord)
        move!(r, Nord)
        y += 1
    end
    return x, y
end