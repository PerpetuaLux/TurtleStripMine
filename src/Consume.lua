---
--- A program meant to completely consume a large area of land, customizable with variables
---

--- First the variables
consumeLength = 64 --- The length of the consume
consumeWidth = 64 --- The width of the consume
consumeHeight = 6 --- The height, in sets of 3
direction = 1 --- Which direction relative to where the turtle is facing do you want it to progress,
direction2 = 1 --- Which direction, but up and down instead
--- d = left = 0, right = 1
--- d2 = down = 0, up = 1


--- Then I define the functions, starting with deposit, these are mostly the same as with Tunnel
function deposit ()
    --- It makes sure slot 1 is selected, which should hold the remote chest, and then places it below itself
    --- It also makes sure the space below it is clear
    turtle.digDown()
    turtle.select(1)
    turtle.placeDown()
    --- It then sets the variable for the repeat block to go through the inventory
    a = 16
    repeat
        --- It selects the next slot, and puts the items into the chest below
        turtle.select(a)
        turtle.dropDown()
        a = a -1
    until a == 2
    --- Finally it makes sure the first slot is selected, and picks the chest back up
    turtle.select(1)
    turtle.digDown()
end

--- Then I define the refuel function
function refuel()
    --- It  makes sure the space below it is clear
    turtle.digDown()
    --- Select the refuel chest and place it
    turtle.select(2)
    turtle.placeDown()
    --- Take the fuel out and refuel
    turtle.suckDown()
    turtle.refuel()
    --- Dig the refuel chest back up and then select the first slot
    turtle.digDown()
    turtle.select(1)
end

--- Then I define the dig function
function dig (length)
    --- A repeat block that will go for the length of the parameter variable
    repeat
        --- First it digs in front of itself, then moves into the hole it dug and digs above and below
        turtle.dig()
        --- This is to stop gravel from breaking things
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        --- Then it checks if it's inventory is full or not
        if turtle.getItemCount(16) > 0 then
            --- If it is full then it deposits it's items
            deposit()
        end
        --- Finally it makes sure the first slot is selected, and  decrements the length count by 1
        turtle.select(1)
        length = length - 1
    until length == 0
end

--- Then the turn function
function turn()
    if direction == 0 then
        turtle.turnLeft()
        dig(1)
        turtle.turnLeft()
        direction = 1
    elseif direction == 1 then
        turtle.turnRight()
        dig(1)
        turtle.turnRight()
        direction = 0
    end
end

function upDown()
    if direction2 == 0 then
        turtle.digDown()
        turtle.down()
        turtle.digDown()
        turtle.down()
        turtle.digDown()
        turtle.down()
        turtle.digDown()
        turtle.turnLeft()
        turtle.turnLeft()
    elseif direction2 == 1 then
        turtle.digUp()
        turtle.up()
        turtle.digUp()
        turtle.up()
        turtle.digUp()
        turtle.up()
        turtle.digUp()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

--- And finally the consume function

function consume()
    height = consumeHeight
    repeat
        --- First it digs the level
        width = consumeWidth
        repeat
            --- Digs the strip, turns and moves 3 blocks, then digs back
            dig(consumeLength)
            width = width - 1
            --- If there is another strip to dig, it loops back
            if width ~= 0 then
                turn()
                dig(consumeLength)
                --- decrements the strips by 1
                width = width - 1
            end
            --- If there are more strips to dig, it moves to where the next one will start
            if width ~= 0 then
                turn()
            end
        until width == 0
        --- Then go up / down
        if height ~= 0 then
        upDown()
        height = height - 1
        end
        --- Refuel if needed
        if turtle.getFuelLevel() < 5000 then
            refuel()
        end
    until height == 0
end

--- Now the actual code

if turtle.getFuelLevel() < 5000 then
    refuel()
end

consume()

---
---
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 24/05/2021 15:11
---