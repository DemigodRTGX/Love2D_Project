enemyIntroduction = {}
enemyIntroduction.enabled = false
enemyIntroduction.enemyimgList = {}

local isenemyloaded = false
local fadespeed = 1
local isStart = false

function enemyIntroduction:load(arg)
    PressStart:replace(contiunebutton)
    table.insert(enemyIntroduction.enemyimgList, love.graphics.newImage('assets/img/enemyIntroduction1.png'))
    table.insert(enemyIntroduction.enemyimgList, love.graphics.newImage('assets/img/enemyIntroduction2.png'))
    table.insert(enemyIntroduction.enemyimgList, love.graphics.newImage('assets/img/enemyIntroduction3.png'))
    table.insert(enemyIntroduction.enemyimgList, love.graphics.newImage('assets/img/enemyIntroduction4.png'))

    enemyimg = TweenUIimg:new('assets/img/enemyIntroduction1.png', 0, 0, 0, 1, 1)
    isStart = false
end

function enemyIntroduction:start()
    if isStart == false then
        PressStart:replace(contiunebutton)
        PressStart.y = 0
        isStart = true
        print('start enemyIntroduction')
    end
end

function enemyIntroduction:show(ID)
    if isenemyloaded == false then
        enemyimg:replace(enemyIntroduction.enemyimgList[ID])
    end
end
function enemyIntroduction:update(dt)
    if not enemyIntroduction.enabled then
        return
    end
    enemyIntroduction:start()

    enemyimg:fade(dt, fadespeed)
    PressStart.y = 0
    isfadein = enemyimg:fade(dt, fadespeed)
    if isfadein and fadespeed == 1 then
        PressStart:fadesin(dt, 1)
    elseif isfadein and fadespeed == -1 then
        enemyIntroduction.enabled = false
    end
end

function enemyIntroduction:draw()
    if not enemyIntroduction.enabled then
        return
    end
    enemyimg:drawfade()
    if isfadein then
        PressStart:drawfade()
    end
end

function enemyIntroduction:keypressed(k)
    if not enemyIntroduction.enabled then
        return
    end
    if k == 'j' and isfadein then
        -- enemyIntroduction.enabled = false
        fadespeed = -1
        isStart = false
    end
end

return enemyIntroduction
