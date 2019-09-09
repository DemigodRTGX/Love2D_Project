local shiftView = {}
shiftView.bg_gray = "assets/shift_gray.png"
shiftView.bg_bloom = "assets/shift.png"
shiftView.images={"assets/S.png","assets/H.png","assets/I.png","assets/F.png","assets/T.png"}

function shiftView:Init()
    shiftView.enabled = false;
    shiftView.count =0;
end
function shiftView:shiftChange(offset)
    shiftView.count = shiftView.count + offset;
    if shiftView.count < 0 then
        shiftView.count =0
    end
    if shiftView.count > 5 then
        shiftView.count=5;
    end
end
function shiftView:load()
    shiftView.bg_gray = love.graphics.newImage( shiftView.bg_gray);
    shiftView.bg_bloom = love.graphics.newImage( shiftView.bg_bloom);
    for k, v in pairs(shiftView.images) do
        shiftView.images[k] = love.graphics.newImage(v);
    end
end
shiftView.x=0;
shiftView.y = 200;
function shiftView:draw()
    if shiftView.count < 5 then
        love.graphics.draw(shiftView.bg_gray, shiftView.x ,shiftView.y);
    else
        love.graphics.draw(shiftView.bg_bloom, shiftView.x ,shiftView.y);
    end

    for i=1,shiftView.count do
        if shiftView.images[i] == nil then
            return
        end
        love.graphics.draw(shiftView.images[i], shiftView.x ,shiftView.y);
    end

end
function shiftView:update(dt)
    
    if shiftView.count < 5 then
        return;
    end
    Components["HP"]:ChangeEnemyHP(-1)

end
shiftView:Init();
return shiftView;