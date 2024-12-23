#Rubcov
using HorizonSideRobots


function toend!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        toend!(robot, side)
    end
end