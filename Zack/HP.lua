HPView = {}
HPView.Images={};
HPView.Images["Hp_bg"]="assets/xuetiao-di.png";
HPView.Images["Hp"]="assets/xuetiao-tiao.png";
function HPView:Init()
    HPView.enabled = false;
    HPView.MineTotal = 100;
    HPView.EnemyTotal = 100;
    HPView.Mine = HPView.MineTotal;
    HPView.Enemy = HPView.EnemyTotal;
    -- HPView.Mine =0;
    -- HPView.Enemy = 100;

end
function HPView:load()
    for k, v in pairs(HPView.Images) do
        HPView.Images[k] = love.graphics.newImage(v);
    end
end
function HPView:draw()
    local my_x=190;
    local my_y=210;
    local enemy_x = 0;
    local enemy_y = 8;
    local hp_total_len = 127;
    love.graphics.draw(HPView.Images["Hp_bg"], enemy_x,enemy_y);
    love.graphics.draw(HPView.Images["Hp_bg"], my_x,my_y);

    local hpLen = math.floor(hp_total_len *  HPView.Enemy / HPView.EnemyTotal);
    love.graphics.setScissor(enemy_x + hp_total_len - hpLen, enemy_y, hpLen, 23)
    love.graphics.draw(HPView.Images["Hp"], enemy_x,enemy_y);
    hpLen = math.floor(hp_total_len *  HPView.Mine / HPView.MineTotal);
    love.graphics.setScissor(my_x + hp_total_len - hpLen, my_y, hpLen, 23)
    love.graphics.draw(HPView.Images["Hp"], my_x,my_y);
    local width, height = love.window.getDesktopDimensions(1)
    love.graphics.setScissor(0,0,width,height);
end
function HPView:ChangeMyHP(value)
    HPView.Mine = HPView.Mine + value;
    HPView.Mine = math.max(HPView.Mine,0);
    HPView.Mine = math.min(HPView.Mine,HPView.MineTotal);

end

function HPView:ChangeEnemyHP(value)
    HPView.Enemy = HPView.Enemy + value;
    HPView.Enemy = math.max(HPView.Enemy,0);
    HPView.Enemy = math.min(HPView.Enemy,HPView.EnemyTotal);
end
HPView:Init();
return HPView;