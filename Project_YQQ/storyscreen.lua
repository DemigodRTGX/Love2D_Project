local storymode = {}
storymode.enabled = false

function storymode:load(arg)
    Components['startgame'].enabled = false
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
end

function storymode:keypressed(k)
    if k == 'j' and isfadein then
        Components['qte'].enabled = true
        Components['storyscreen'].enabled = false
     end

end

return storymode
