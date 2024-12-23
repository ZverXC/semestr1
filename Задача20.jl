#Rubcov
using HorizonSideRobots

function movemark!(robot, side)
    if !isborder(robot, side)  
        move!(robot, side) 
    else 
        putmarker!(robot)
        return
    end
    movemark!(robot, side)
    move!(robot, inverse(side))
end

function movetoend!(robot, side)
    !isborder(robot, side) && (move!(robot, side); return) 
    movetoend!(robot, side)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))