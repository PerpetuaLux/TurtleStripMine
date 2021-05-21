---
---
--- A variant of torch that is made to put torches through a strip mine
--- Should be used after it's strip-mined
---

--- First declare variables
strips = 0 --- number of strips
stripLength = 32 --- Length of strips
direction = 0 --- Which direction relative to where the turtle is facing do you want it to progress,
--- left = 0, right = 1

--- Now for the functions

function turn()
    if direction == 0 then
        turtle.turnLeft()
        move(3)
        turtle.turnLeft()
        direction = 1
    elseif direction == 1 then
        turtle.turnRight()
        move(3)
        turtle.turnRight()
        direction = 0
    end
end

function placeTorch()
    --- Places torch below it
    turtle.placeDown()
end

--- This checks if something is in front of it and then moves
function move(a)
    repeat
        --- If something is in front, it waits for 10 seconds and checks again
        if turtle.detect() then
            sleep(10)
            --- If something is still in front, it sends an error and exits the program
            if turtle.detect() then
                error("I got stuck :(")
                exit()
            end
            --- If there isn't anything in front it moves
        else
            turtle.forward()
        end
        a = a - 1
    until a == 0
end

--- fetch more torches
function restock()
    turtle.select(2)
    turtle.placeDown()
    turtle.select(1)
    turtle.suckDown()
    turtle.select(2)
    turtle.digDown()
    turtle.select(1)
end

function light()
    --- Place torches and move for the length of the strip, 1 torch every 6 blocks
    x = math.floor(stripLength / 6)
    repeat
        placeTorch()
        move(6)
        if turtle.getItemCount(1) < 5 then
            restock()
        end
        x = x - 1
    until x == 0
    --- Move the remaining distance
    placeTorch()
    x = stripLength - (math.floor(stripLength / 6) * 6)
    move(x)
end

function go()
    --- Move forward once to line up (Should be placed just before first strip entrance)
    turtle.up()
    strips = strips / 2
    repeat
        --- Light this side of the strip
        light()
        --- turn and move to the other side of the tunnel
        turn()
        --- Light this side of the strip
        light()
        strips = strips - 1
        --- If there are more strips to dig, it moves to where the next one will start
        if strips ~= 0 then
            turn()
        end
    until strips == 0

end

--- Now the actual code

---Refuels
turtle.select(3)
turtle.refuel()
turtle.select(1)

--- go
go()

---
---
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 21/05/2021 17:20
---