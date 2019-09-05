-- menu==escape
-- y=i
-- a=j
-- x=u
-- b=k
-- select=space
-- start=return
local qteView = require("qte")
Components = {}
Components["qte"] = qteView

function love.load()
    for k, Component in pairs(Components) do
        Component:load();
    end
end

function love.draw()
    for k, Component in pairs(Components) do
        if Component.enabled then
            Component:draw();
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit(0);
        return;
     end
     if key == "space" then
        qteView.enabled = not qteView.enabled;
     end
    for k, Component in pairs(Components) do
        if Component.enabled then
            Component:keypressed(key);
        end
    end
end

function love.update(dt)
    for k, Component in pairs(Components) do
        if Component.enabled then
            Component:update(dt);
        end
    end
end