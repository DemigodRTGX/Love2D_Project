-- menu==escape
-- y=i
-- a=j
-- x=u
-- b=k
-- select=space
-- start=return
local qteView = require("qte")
local testcomponents = require("test")
local startgameComponents = require('startgame')

Components = {}
Components["qte"] = qteView
--Components["test"] = testcomponents
Components["startgame"] = startgameComponents

function love.load()
    for k, Component in pairs(Components) do
        Component:load();
    end
end

function love.draw()
    for k, Component in pairs(Components) do
        Component:draw();
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit(0);
        return;
     end
    --  if key == "space" then
    --     qteView.enabled = not qteView.enabled;
    --  end
    for k, Component in pairs(Components) do
        Component:keypressed(key);
    end
end

function love.update(dt)
    for k, Component in pairs(Components) do
        Component:update(dt);
    end
end