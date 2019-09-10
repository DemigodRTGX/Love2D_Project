local storymode = {}
storymode.enabled = false
storymode.storynumber = 0

function storymode:load(arg)
    storymodeimg1 = TweenUIimg:new('assets/img/story1.png', 0, 0, 0, 1, 1)
    storymodeimg2 = love.graphics.newImage('assets/img/story2.png')

    storymodeimg3 = love.graphics.newImage('assets/img/story3.png')

    fadeoutstory = 0.5
    isfadein = false

    storynumber = 1
end

function storymode:update(dt)
    if not storymode.enabled then
        return
    end
    storymodeimg1:fade(dt, fadeoutstory)
    PressStart.y = 50
    isfadein = storymodeimg1:fade(dt, fadeoutstory)
    if isfadein then
        PressStart:fadesin(dt, 1)
    end
    --   print(fadeoutstory)
end

function storymode:draw()
    if not storymode.enabled then
        return
    end
    storymodeimg1:drawfade()

    if isfadein then
        PressStart:drawfade()
    end
    -- print('story')
end

function storymode:keypressed(k)
    if k == 'j' and isfadein then
        if storynumber == 1 then
            storymodeimg1:replace(storymodeimg2)
            storymodeimg1:resetfade()
            storynumber = 2
            isfadein = false
        elseif storynumber == 2 then
            storymodeimg1:replace(storymodeimg3)
            storymodeimg1:resetfade()
            storynumber = 3
            isfadein = false
        elseif storynumber == 3 then
            print('battlestart')
            Components['Battle']:Start()
            storymode.enabled = false
        end
    --  love.graphics.
    end
end

return storymode
