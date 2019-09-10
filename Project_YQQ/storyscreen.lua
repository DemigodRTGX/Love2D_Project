local storymode = {}
storymode.enabled = false

function storymode:load(arg)
    storymodeimg = TweenUIimg:new('assets/img/story.png', 0, 0, 0, 1, 1)
    fadeoutstory = 1
    isfadein = false
end

function storymode:update(dt)
    if not storymode.enabled then
        return
    end

    storymodeimg:fade(dt, fadeoutstory)
    PressStart.y = 50
    isfadein = storymodeimg:fade(dt, fadeoutstory)
    PressStart:fadesin(dt, 1)
end

function storymode:draw()
    if not storymode.enabled then
        return
    end
    storymodeimg:drawfade()
    if isfadein then
        PressStart:drawfade()
    end
    -- print('story')
end

function storymode:keypressed(k)
    if k == 'j' and isfadein then
        print('battlestart')
        Components['Battle']:Start()
        storymode.enabled = false
      --  love.graphics.
    end
end

return storymode
