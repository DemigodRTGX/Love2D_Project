--这里处理整个战斗界面的逻辑
Battle={}
Battle.enabled = true;
Battle.ShowInfo = true;
Battle.BattleInfo={"assets/battle1.png","assets/battle2.png","assets/battle3.png"}
Battle.CurrentBattle = 1;
-- Battle.
function Battle:load()
    for k, v in pairs(Battle.BattleInfo) do
        Battle.BattleInfo[k] = love.graphics.newImage(v);
    end

end
-- function Battle:update(dt)
--     if not Battle.ShowInfo then
--         return;
--     end 

-- end
function Battle:draw()
    if not Battle.ShowInfo then
        return;
    end
    love.graphics.draw(Battle.BattleInfo[Battle.CurrentBattle], 0,0);
end

function Battle:keypressed(key)
    if not Battle.ShowInfo then
        return;
    end
    if key == "j" then
        print("----"..Battle.CurrentBattle)
        Battle.CurrentBattle = Battle.CurrentBattle + 1;
        Battle.CurrentBattle = math.min(Battle.CurrentBattle,3);
        Battle.ShowInfo = false;
        Battle:onStart();
    end
end

function Battle:onStart()
    Components["qte"]:Start();
    Components["result"]:BeginWatching()
end
function Battle:onEnd()
    Battle.ShowInfo = true;
    Components["qte"]:Init();
    Components["shift"]:Init();
    Components["HP"]:Init();
end
return Battle;