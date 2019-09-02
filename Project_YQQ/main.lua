function love.load(arg)
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    -- RenderUIimg = require('bias')
    zhonggao = TweenUIimg:new('asset/img/youxizhonggao.png', 0, 0, 0, 1, 1)
end

function love.update(dt)
    zhonggao:fade(dt, 0.5)
    splashscreentime = DelayTimer(dt, splashscreentime)
    if splashscreentime <= 0 then
        zhonggao:translate(dt, 0, 40)
    end
end

function love.draw()
    zhonggao:draw()
    -- love.graphics.draw(RenderUIimg.img, 0, 0)
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.push('quit')
    end
end
