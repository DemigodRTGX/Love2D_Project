caiQuanView = {};
caiQuanView.Images={};
caiQuanView.Images["jiandao"]="assets/jiandao.png";
caiQuanView.Images["quantou"]="assets/quantou.png";
caiQuanView.Images["bu"]="assets/bu.png";
caiQuanView.Images["my_qipao"]="assets/qipao2.png"
caiQuanView.Images["other_qipao"]="assets/qipao.png"
function caiQuanView:Init()
    caiQuanView.enabled = false;
    caiQuanView.showTime = -3;
    caiQuanView.my_choose = 0;
    caiQuanView.other = 0;
    caiQuanView.theResult = -1;
end
function caiQuanView:load()
    for k, v in pairs(caiQuanView.Images) do
        caiQuanView.Images[k] = love.graphics.newImage(v);
    end
    --caiQuanView:ShowResult(2)
end
function caiQuanView:getResult()
    local r = caiQuanView.theResult;
    caiQuanView.theResult = -1;
    return r;
end
 function caiQuanView:getWin(mine)
    local win = 0;
    if mine == 0 then 
        win = 1;
    elseif mine == 1 then
        win = 2;
    elseif mine == 2 then
        win = 0;
    end
    caiQuanView.theResult = 1;
    return win;
 end
 function caiQuanView:getFail(mine)
    local Fail = 0;
    if mine == 0 then 
        Fail = 2;
    elseif mine == 1 then
        Fail = 0;
    elseif mine == 2 then
        Fail = 1;
    end
    caiQuanView.theResult = 0;
    return Fail;
 end

--显示结果
-- select表示出的手势 0布 1拳头 2剪刀 -1表示钦定
function caiQuanView:ShowResult(select)
    caiQuanView.showTime = 3;
    caiQuanView.enabled = true;
    --这里定义一个随机数 如果是钦定胜利，作为自己的出拳
    --如果是手术选择，这个随机数作为胜利的概率，1/3
    local mine = love.math.random(0,2);
    --
    if select == -1 then
        caiQuanView.my_choose = mine;
        caiQuanView.other = caiQuanView:getWin(mine);
        
    else
        caiQuanView.my_choose = select;
        if mine == 1 then
            caiQuanView.other = caiQuanView:getWin(select);
        else
            caiQuanView.other = caiQuanView:getFail(select);
        end
    end
    print(caiQuanView.my_choose)
    print(caiQuanView.other)

end
function caiQuanView:draw()
    local my_x = 130;
    local my_y = 130;
    local other_x = 95;
    local other_y = 25;
    love.graphics.draw(caiQuanView.Images["other_qipao"], other_x ,other_y);
    love.graphics.draw(caiQuanView.Images["my_qipao"], my_x ,my_y);
    if caiQuanView.my_choose == 0 then
        love.graphics.draw(caiQuanView.Images["bu"], my_x ,my_y);
    elseif caiQuanView.my_choose == 1 then
        love.graphics.draw(caiQuanView.Images["quantou"], my_x ,my_y);
    elseif caiQuanView.my_choose == 2 then
        love.graphics.draw(caiQuanView.Images["jiandao"], my_x ,my_y);
    end

    if caiQuanView.other == 0 then
        love.graphics.draw(caiQuanView.Images["bu"], other_x ,other_y);
    elseif caiQuanView.other == 1 then
        love.graphics.draw(caiQuanView.Images["quantou"], other_x ,other_y);
    elseif caiQuanView.other == 2 then
        love.graphics.draw(caiQuanView.Images["jiandao"], other_x ,other_y);
    end

end
function caiQuanView:update(dt)
    if caiQuanView.showTime < -1 then
        return
    end

    caiQuanView.showTime = caiQuanView.showTime - dt;
    if caiQuanView.showTime < 0 then
        caiQuanView.showTime = -3;
        caiQuanView.enabled = false;
        Components["qte"]:Continue(caiQuanView:getResult());
    end
end
caiQuanView:Init();
return caiQuanView
