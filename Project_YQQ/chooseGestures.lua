chooseGesturesView = {};
chooseGesturesView.Images={};
chooseGesturesView.Images["bu"]="assets/img/bu.png";
chooseGesturesView.Images["quantou"]="assets/img/quantou.png";
chooseGesturesView.Images["jiandao"]="assets/img/jiandao.png";
chooseGesturesView.Images["gesture_bg"]="assets/img/caiquan-anjian.png";
chooseGesturesView.Images["gesture_bg_checked"]="assets/img/caiquan-anjian2.png";
chooseGesturesView.Images["Slider_bg"]="assets/img/daojishi-di.png"
chooseGesturesView.Images["Slider"]="assets/img/daojishi-tiao.png"
function chooseGesturesView:Init()
    chooseGesturesView.enabled = false;
    chooseGesturesView.selected = 1;
    chooseGesturesView.showTime = 3;
    

end
function chooseGesturesView:load()
    for k, v in pairs(chooseGesturesView.Images) do
        chooseGesturesView.Images[k] = love.graphics.newImage(v);
    end
end
function chooseGesturesView:update(dt)
    chooseGesturesView.showTime = chooseGesturesView.showTime - dt;
    if chooseGesturesView.showTime < 0 then
        chooseGesturesView.enabled = false;
        Components["caiQuan"]:ShowResult(chooseGesturesView.selected);
    end
end

function chooseGesturesView:drawTimeSlider()
    local y = 160;
    love.graphics.draw(chooseGesturesView.Images["Slider_bg"], 15,y);
    local sliderWidth = 296 * chooseGesturesView.showTime/3;
    sliderWidth = math.floor(sliderWidth);
    love.graphics.setScissor(15 + 296 - sliderWidth, y, sliderWidth, 7)
    -- scissorWidth = math.floor(296 * );
    -- scissorWidth = math.floor(296 * (1- qteView.leftTime / qteView.QTETime));
    -- love.graphics.setScissor(15, 180, scissorWidth, 7)
    love.graphics.draw(chooseGesturesView.Images["Slider"], 15,y);
    width, height = love.window.getDesktopDimensions(1)
    love.graphics.setScissor(0,0,width,height);
end
function chooseGesturesView:draw()
    local leftx=10;
    local y = 60;
    local offset = 100;
    love.graphics.draw(chooseGesturesView.Images["gesture_bg"], leftx ,y);
    love.graphics.draw(chooseGesturesView.Images["gesture_bg"], leftx + offset ,y);
    love.graphics.draw(chooseGesturesView.Images["gesture_bg"], leftx + offset * 2 ,y);
    if chooseGesturesView.selected == 0 then
        love.graphics.draw(chooseGesturesView.Images["gesture_bg_checked"], leftx ,y);
    elseif chooseGesturesView.selected == 1 then
        love.graphics.draw(chooseGesturesView.Images["gesture_bg_checked"], leftx + offset ,y);
    elseif chooseGesturesView.selected == 2 then 
        love.graphics.draw(chooseGesturesView.Images["gesture_bg_checked"], leftx + offset * 2 ,y);
    end
    love.graphics.draw(chooseGesturesView.Images["bu"], leftx ,y);
    love.graphics.draw(chooseGesturesView.Images["quantou"], leftx + offset ,y);
    love.graphics.draw(chooseGesturesView.Images["jiandao"], leftx + offset * 2 ,y);
    chooseGesturesView:drawTimeSlider();
end

function chooseGesturesView:keypressed(key)
    if key == "left" then
        chooseGesturesView.selected = chooseGesturesView.selected - 1;
        chooseGesturesView.selected =  chooseGesturesView.selected % 3;
    elseif key == "right" then
        chooseGesturesView.selected = chooseGesturesView.selected + 1;
        chooseGesturesView.selected =  chooseGesturesView.selected % 3;
    elseif key == "j" then
        chooseGesturesView.enabled = false;
        Components["caiQuan"]:ShowResult(chooseGesturesView.selected)
    end
end

function chooseGesturesView:Show()
    chooseGesturesView.enabled = true;
    chooseGesturesView.showTime = 3;
    chooseGesturesView.selected = 1;
end
chooseGesturesView:Init();
return chooseGesturesView;