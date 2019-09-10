-- menu==escape
-- y=i
-- a=j
-- x=u
-- b=k
-- select=space
-- start=return
local BGView = require('bg')
local qteView = require('qte')
local Res = require('Res');

-- local testcomponents = require("test")
local startgameComponents = require('startgame')
local shiftView = require('shift')
local chooseGesturesView = require('chooseGestures')
local caiQuanView = require('caiQuan')
local HPView = require('HP')
local resultView = require('result')
local Battle = require('Battle')
local storymode = require('storyscreen')

Components = {}
--Components['bg'] = BGView
table.insert(Components, '1', BGView)
Components['startgame'] = startgameComponents
Components['Res'] = Res
Components['storyscreen'] = storymode
Components['shift'] = shiftView
Components['chooseGestures'] = chooseGesturesView
Components['qte'] = qteView
Components['caiQuan'] = caiQuanView
Components['result'] = resultView
Components['HP'] = HPView
Components['Battle'] = Battle
function love.load()
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    assert(love.filesystem.load('AudioManager.lua'))()
    PressStart = TweenUIimg:new('assets/img/CREDITS.png', 0, 0, 0, 1, 1)

    -- print(love.window.width)
    for k, Component in pairs(Components) do
        Component:load()
    end
    -- Components['Battle']:Start()
    for i in pairs(Components) do
        print(i)
    end
end

function love.draw()
    -- for i = 1, table.getn(Components) do
    --     local Component = Components[i]
    --     print(Component)
    --     if Component.enabled and (Component.draw ~= nil) then
    --         Component:draw()
    --     end
    -- end
    --     for i in pairs(Components) do
    --         -- print(i)
    --     end

    -- end

    -- end
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.draw ~= nil) then
            Component:draw()
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit(0)
        return
    end
    if key == 'rctrl' then --set to whatever key you want to use
        debug.debug()
    end
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.keypressed ~= nil) then
            Component:keypressed(key)
        end
    end
end

function love.update(dt)
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.update ~= nil) then
            Component:update(dt)
        end
    end
end
