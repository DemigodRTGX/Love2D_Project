-- menu==escape
-- y=i
-- a=j
-- x=u
-- b=k
-- select=space
-- start=return
local qteView = require("qte")
local shiftView = require("shift")
local chooseGesturesView = require("chooseGestures");
local caiQuanView = require("caiQuan");
local HPView = require("HP");
local resultView = require("result")
local Battle = require("Battle");
Components = {}
Components["qte"] = qteView
Components["shift"] = shiftView
Components["chooseGestures"] = chooseGesturesView;
Components["caiQuan"] = caiQuanView;
Components["result"] = resultView;
Components["HP"] = HPView;
Components["Battle"] = Battle;
function love.load()
    print(love.window.width)
    for k, Component in pairs(Components) do
        Component:load();
    end
end

function love.draw()
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.draw ~=nil) then
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
     if key == "rctrl" then --set to whatever key you want to use
        debug.debug()
     end
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.keypressed ~=nil) then
            Component:keypressed(key);
        end
    end
end

function love.update(dt)
    for k, Component in pairs(Components) do
        if Component.enabled and (Component.update ~=nil) then
            Component:update(dt);
        end
    end
end