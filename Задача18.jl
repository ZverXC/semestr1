#Rubcov
using HorizonSideRobots

function spiral!(stop_condition::Function, robot) 
    nmax_steps = 1
    s = Nord 
    while !find_direct!(stop_condition::Function, robot, s, nmax_steps) 
        (s in (Nord, Sud)) && (nmax_steps += 1) 
        s = left(s) 
    end 
end 

function find_direct!(stop_condition::Function, robot, side, nmax_steps) 
    n = 0 
    while !stop_condition() && (n < nmax_steps)
        if !isborder(robot, side)
            move!(robot, side)
            n += 1 
        else
            shuttle!(robot, Nord) do side !isborder(robot, side) end 
            n += 1 
        end
    end 
    return stop_condition()
end

function shuttle!(stop_condition::Function, robot, side) 
    s = Ost
    n = 0 
    while !stop_condition(side) 
        move!(robot, s, n) 
        s = inverse(s) 
        n += 1 
    end 
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
HorizonSideRobots.move!(robot, side, num_steps) = for _ in 1:num_steps move!(robot, side) end
left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))