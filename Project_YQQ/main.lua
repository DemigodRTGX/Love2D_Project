-- menu==escape
-- y=i
-- a=j
-- x=u
-- b=k
-- select=space
-- start=return
local qteView = require('qte')
local testcomponents = require('test')
local startgameComponents = require('startgame')
local storymode = require('storyscreen')

Components = {}
Components['qte'] = qteView
--Components["test"] = testcomponents
Components['startgame'] = startgameComponents
Components['storyscreen'] = storymode

function love.load()
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    assert(love.filesystem.load('AudioManager.lua'))()
    PressStart = TweenUIimg:new('assets/img/CREDITS.png', 0, 0, 0, 1, 1)

    for k, Component in pairs(Components) do
        Component:load()
    end
end

function love.draw()
    for k, Component in pairs(Components) do
        Component:draw()
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit(0)
        return
    end
    --  if key == "space" then
    --     qteView.enabled = not qteView.enabled;
    --  end
    for k, Component in pairs(Components) do
        Component:keypressed(key)
    end
end

function love.update(dt)
    for k, Component in pairs(Components) do
        Component:update(dt)
    end
end
