local gameoverscreen = {}
gameoverscreen.enabled = false

local isStart = false
function gameoverscreen:load(arg)
    isStart = false
end

function gameoverscreen:start()
    if isStart == false then
        PressStart:replace(contiunebutton)
        PressStart.y = 0
        isStart = true
        print('Gameover')
    end
end

function gameoverscreen:update(dt)
    -- statements
end

function gameoverscreen:draw()
end

function gameoverscreen:fail()
    print('fail')
end

function gameoverscreen:win()
    print('win')
end

function gameoverscreen:reset()
    isStart = false
end
