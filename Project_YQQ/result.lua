resultView = {}
resultView.Images = {}
resultView.Images["win"] = "assets/img/win.png";
resultView.Images["fail"] = "assets/img/fail.png";

function resultView:Init()
    resultView.enabled = false;
    resultView.watching = false;
    resultView.result = -1;
    resultView.show = false;
    resultView.showTime = 3;
end
function resultView:load()
    for k, v in pairs(resultView.Images) do
        resultView.Images[k] = love.graphics.newImage(v);
    end
end

function resultView:update(dt)
    if not resultView.watching then
        return;
    end
    if resultView.show then
        resultView.showTime = resultView.showTime - dt;
        if resultView.showTime < 0 then
            resultView.show = false;
            resultView:StopWatching();
            Components["Battle"]:onEnd();
        end
    end
    local my = Components["HP"].Mine;
    local enemy = Components["HP"].Enemy;
    if my == 0 then
        resultView.result = 0;
        resultView.show = true;
        Components["qte"].enabled = false;
        Components["HP"].enabled = false;
        Components["shift"].enabled = false;
    end
    if enemy == 0 then
        resultView.result = 1;
        resultView.show = true;
        Components["qte"].enabled = false;
        Components["HP"].enabled = false;
        Components["shift"].enabled = false;
    end
    
end

function resultView:draw()
    if resultView.result == 0 then
        love.graphics.draw(resultView.Images["fail"], 0,0);
    elseif resultView.result == 1 then
        love.graphics.draw(resultView.Images["win"], 0,0);
    end
end

function resultView:BeginWatching()
    resultView.enabled = true;
    resultView.watching = true;
end
function resultView:StopWatching()
    resultView:Init();
end

resultView:Init();
return resultView;