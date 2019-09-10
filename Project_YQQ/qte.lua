local qteView = {}
qteView.keys={"up","down","left","right"};
qteView.keys_tail = {"j"};
qteView.keyImages_tail={"assets/img/querenanjian1.png"}
qteView.pressedImages_tail={"assets/img/querenanjian2.png"}
qteView.keyImages = {"assets/img/anjian-shang.png","assets/img/anjian-xia.png","assets/img/anjian-zuo.png","assets/img/anjian-you.png"}
qteView.pressedImages = {"assets/img/anjiananxia-shang.png","assets/img/anjiananxia-xia.png","assets/img/anjiananxia-zuo.png","assets/img/anjiananxia-you.png"}
qteView.OtherImages={};
qteView.OtherImages["timeOutSlider_bg"]="assets/img/daojishi-di.png";
qteView.OtherImages["timeOutSlider"]="assets/img/daojishi-tiao.png";
qteView.OtherImages["keys_bg"]="assets/img/di.png";
function qteView:Init()
    qteView.enabled = false;
    qteView.QTETime = 7
    qteView.currentRange={}
end
-- 定义功能函数
--创建一个随机的按键
function qteView:getRandomKey()
    index = love.math.random(1,table.getn(qteView.keyImages));
    theKey = {};
    theKey.key = qteView.keys[index];
    theKey.keyImage = qteView.keyImages[index];
    theKey.pressedImage = qteView.pressedImages[index];
    theKey.isPressed = false;
    return theKey;
end
function qteView:getTailKey()
    index = love.math.random(1,table.getn(qteView.keys_tail));
    theKey = {};
    theKey.key = qteView.keys_tail[index];
    theKey.keyImage = qteView.keyImages_tail[index];
    theKey.pressedImage = qteView.pressedImages_tail[index];
    theKey.isPressed = false;
    return theKey;
end

--当进行下一局
function qteView:nextRange()
    -- print("下一局");
    --上一局按键比上一局多一个
    local keyCount = table.getn(qteView.currentRange);
    if keyCount > 5 then
        keyCount = 5;
    end
    --重置上一局的按钮图片
    -- currentRange = {}
    -- print("xfdsg"..keyCount);
    for i =1, keyCount do
        qteView.currentRange[i] = qteView:getRandomKey();
        -- print(currentRange[i])
    end
    qteView.currentRange[keyCount+1] = qteView:getTailKey();
    --重置时间
    qteView.leftTime = qteView.QTETime;
end
-- Shift=0
function qteView:succeed()
    -- print("succeed");
    qteView.enabled = false;
    Components["caiQuan"]:ShowResult(-1)
    -- Components["shift"]:shiftChange(1);
end

function qteView:Continue(result)
    if result == 1 then
        Components["shift"]:shiftChange(1);
        Components["HP"]:ChangeEnemyHP(-10);
    else
        Components["HP"]:ChangeMyHP(-20);
    end
    qteView.enabled = true;
    -- Components["HP"].enabled = false;

end
function qteView:failed()
    qteView.enabled = false;
    Components["HP"].enabled = true;
    Components["chooseGestures"]:Show()
    -- print("failed");
end
function qteView:Start()
    print('QTE');
    qteView.currentRange={}
    qteView.enabled = true;
    Components["shift"].enabled = true;
    Components["HP"].enabled = true;
    qteView:nextRange()
end
function qteView:drawTimeSlider()
    love.graphics.draw(qteView.OtherImages["timeOutSlider_bg"], 15,180);
    local sliderWidth = 296 * qteView.leftTime/qteView.QTETime;
    sliderWidth = math.floor(sliderWidth);
    love.graphics.setScissor(15 + 296 - sliderWidth, 180, sliderWidth, 7)
    -- scissorWidth = math.floor(296 * );
    -- scissorWidth = math.floor(296 * (1- qteView.leftTime / qteView.QTETime));
    -- love.graphics.setScissor(15, 180, scissorWidth, 7)
    love.graphics.draw(qteView.OtherImages["timeOutSlider"], 15,180);
    local width, height = love.window.getDesktopDimensions(1)
    love.graphics.setScissor(0,0,width,height);
end

function qteView:load()
    
    -- print("中文");
    love.graphics.setFont(love.graphics.newFont(11))
    red = 215/255
    green = 108/255
    blue = 142/255
    alpha = 50/100
   -- love.graphics.setBackgroundColor( red, green, blue, alpha)
    --先将图片全部加载进来
    for i=1,table.getn(qteView.keyImages) do
        qteView.keyImages[i] = love.graphics.newImage(qteView.keyImages[i]);
        qteView.pressedImages[i] = love.graphics.newImage(qteView.pressedImages[i]);
    end
    for i=1,table.getn(qteView.keyImages_tail) do
        qteView.keyImages_tail[i] = love.graphics.newImage(qteView.keyImages_tail[i]);
        qteView.pressedImages_tail[i] = love.graphics.newImage(qteView.pressedImages_tail[i]);
    end
    
    for k, v in pairs(qteView.OtherImages) do
        qteView.OtherImages[k] = love.graphics.newImage(v);
    end
end
qteView.currentRange = {}
qteView.imageWidth = 40
qteView.imagePadding = qteView.imageWidth * 1.1
function qteView:draw()
    local y=100
    --先画背景
    love.graphics.draw(qteView.OtherImages["keys_bg"], 0 ,y - 20);
    qteView:drawTimeSlider()
    local keyCount = table.getn(qteView.currentRange);
    lineLength = keyCount * qteView.imagePadding;
    x = math.floor((love.graphics.getWidth() - lineLength)/2)
    
    for i = 1,keyCount do
        if qteView.currentRange[i].isPressed then
            love.graphics.draw(qteView.currentRange[i].pressedImage, x+ qteView.imagePadding * (i-1),y)
        else
            love.graphics.draw(qteView
            .currentRange[i].keyImage, x + qteView.imagePadding * (i-1),y)
        end
    end
end

function qteView:keypressed(key)
    -- print("Pressed_"..key)
    local keyCount = table.getn(qteView.currentRange);
    -- print("keyCount="..keyCount);
    --变量作用域的问题，只能重新定义个变量去接受
    local hitIndex=-1;
    for i = 1,keyCount do
        -- print("for..i="..i);
        if not(qteView.currentRange[i].isPressed) then
            if qteView.currentRange[i].key == key then
                hitIndex = i;
                qteView.currentRange[i].isPressed = true;
            end
            break;
        end
    end
    -- print("i="..hitIndex);
    if hitIndex== keyCount then
        qteView:succeed()
        qteView:nextRange()
    end
end

qteView.leftTime = qteView.QTETime;
function qteView:update(dt)
    qteView.leftTime = qteView.leftTime - dt;
    if qteView.leftTime < 0 then
        qteView:failed()
        qteView:nextRange();
    end
    -- print(leftTime)
end
qteView:Init()
return qteView