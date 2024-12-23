#Rubcov
using HorizonSideRobots

struct Coordinates
    x::Int
    y::Int
end

function move(coord::Coordinates, side::HorizonSide)
    (side == Nord) && return Coordinates(coord.x, coord.y + 1)
    (side == Sud)  && return Coordinates(coord.x, coord.y - 1)
    (side == Ost)  && return Coordinates(coord.x + 1, coord.y)
    (side == West) && return Coordinates(coord.x - 1, coord.y)
end

mutable struct ChessMarkRobot
    robot::Robot
    coord::Coordinates
end
    
function HorizonSideRobots.move!(robot::ChessMarkRobot, side)
    robot.coord = move(robot.coord, side)
    (iseven(robot.coord.x+robot.coord.y)) && putmarker!(robot)
    move!(robot.robot, side)
end

HorizonSideRobots.isborder(robot::ChessMarkRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.putmarker!(robot::ChessMarkRobot) = putmarker!(robot.robot)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function markchessall(robot::Robot)
    n_west, n_sud = movetoangle!(robot, (West,Sud))
    robot = ChessMarkRobot(robot, Coordinates(0, iseven(n_west+n_sud)))
    snake!((s->(isborder(robot, Nord)&&(isborder(robot,s)))), robot, (Ost, Nord))
    (iseven(robot.coord.x+1+robot.coord.y)) && putmarker!(robot)
    movetoangle!(robot, (West, Sud))
    movetostart!(robot, n_west, n_sud)
end

function snake!(stop_condition::Function, robot, sides::NTuple{2,HorizonSide})
    s=sides[1]
    while !stop_condition(s)
        movetoend!(()->(stop_condition(s) || isborder(robot, s)), robot, s)
        if stop_condition(s)
            break
        end
        s = inverse(s)
        move!(robot, sides[2])
    end
end

movetoend!(stop_condition::Function, robot, side) = while !stop_condition() move!(robot, side) end
movetoangle!(robot, sides) = (nummovetoend!(robot, sides[1]), nummovetoend!(robot, sides[2]))

function nummovetoend!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot,side)
        n += 1
    end
    return n
end

function movetostart!(robot, n_west, n_sud)
    movecertainsteps!(robot, Ost, n_west)
    movecertainsteps!(robot, Nord, n_sud)
end

function movecertainsteps!(robot, side, n)
    while n != 0
        move!(robot, side)
        n -= 1
    end
end