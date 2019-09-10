bgView = {}
bgView.enabled = false;
bgView.Images={};
bgView.Images["bg"] = "assets/img/bg.png"
function bgView:load()
    for k, v in pairs(bgView.Images) do
        bgView.Images[k] = love.graphics.newImage(v);
    end
end
function bgView:draw()
    love.graphics.draw(bgView.Images["bg"],0,0)
end
return bgView;