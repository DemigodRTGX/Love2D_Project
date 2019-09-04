function love.load(arg)
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    -- RenderUIimg = require('bias')
    zhonggao = TweenUIimg:new('asset/img/youxizhonggao.png', 0, 0, 0, 1, 1)
    StartBG = TweenUIimg:new('asset/img/StartBG.png', 0, -240, 0, 1, 1)
end

function love.update(dt)
    splashscreentime = DelayTimer(dt, splashscreentime)
    if splashscreentime <= 0 then
        StartBG:MoveTo(dt, 0, 0, 0, 200)
    else
        zhonggao:fade(dt, splashscreentime)
    end
end

function love.draw()
    if splashscreentime <= 0 then
        StartBG:draw()
    else
        zhonggao:drawfade()
    end
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.push('quit')
    end
end

test = {
    x = 0
}

--test--
function test:new(x)
    t = {}
    setmetatable(t, {__index = self})
    t.x = x
    return t
end

t1 = test:new(2)
--t1.x = 2
t2 = test:new(3)
--t2.x = 3

function test:print()
    print(self.x)
end
