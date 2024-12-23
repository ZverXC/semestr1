using HorizonSideRobots

function pole(r)
    d::Int = 0
    l::Int = 0
    left_ugol(r)
    perimetr(r)
end

function left_ugol(r)
    while !isborder(r, West) || !isborder(r, Sud)
        for side in (Sud, West)
            while !isborder(r, side)
                move!(r, side)
            end
        end
    end
end

function perimetr(r)
    for side in (Ost, Nord, West, Sud)
        while !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        end
    end
end