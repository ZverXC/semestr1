#Rubcov
using HorizonSideRobots

function partitions!(robot)
    w = do_upora(robot, West)

    n = do_upora(robot, Nord)

    k = 0
    num_part = 0
    side = Ost
    while (!isborder(robot, Sud) || !isborder(robot, Ost)) && (!isborder(robot, Sud) || !isborder(robot, West))
        num_part += numborders!(robot, side)
        if !isborder(robot, Sud)
            move!(robot, Sud)
            k +=1
        end
        side = inverse(side)
    end

    do_upora(robot, West)
    for i in 1:(k-n)
        move!(robot, Nord)
    end
    for i in 1:w
        move!(robot, Ost)
    end
    
    println(num_part)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

function numborders!(robot, side)
    state = 0
    num_borders = 0
    while !isborder(robot, side)
        move!(robot, side)
        if state == 0
            (isborder(robot, Sud) == true) && (state = 1; num_borders += 1)
        elseif state == 1
            (isborder(robot, Sud) == false) && (state = 2)
        elseif state == 2
            (isborder(robot, Sud) == false) && (state = 0)
        end
    end
    return num_borders
end

function do_upora(robot, side)
    num_steps = 0
    while !isborder(robot, side)
        num_steps += 1
        move!(robot, side)
    end
    return num_steps
end