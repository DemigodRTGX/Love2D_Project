--这里处理整个战斗界面的逻辑
Battle={}
Battle.enabled = false;
Battle.ShowInfo = false;
Battle.BattleInfo={"assets/img/battle1.png","assets/img/battle2.png","assets/img/battle3.png"}
Battle.CurrentBattle = 1;
-- Battle.
function Battle:load()
    for k, v in pairs(Battle.BattleInfo) do
        Battle.BattleInfo[k] = love.graphics.newImage(v);
    end

end
function Battle:Start()
    Battle.enabled = true;
    Battle.ShowInfo = true;
    Components[1].enabled = true
end
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