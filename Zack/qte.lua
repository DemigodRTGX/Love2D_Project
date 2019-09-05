local qteView = {}
qteView.enabled = true;
qteView.QTETime = 7
qteView.keys={"up","down","left","right"};
qteView.keys_tail = {"a","k"};
qteView.keyImages_tail={"assets/A.png","assets/B.png"}
qteView.pressedImages_tail={"assets/A_g.png","assets/B_g.png"}
qteView.keyImages = {"assets/up.png","assets/down.png","assets/left.png","assets/right.png"}
qteView.pressedImages = {"assets/up_g.png","assets/down_g.png","assets/left_g.png","assets/right_g.png"}
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
    print("succeed");
end
function qteView:failed()
    print("failed");
end

function qteView:load()
    -- print("中文");
    love.graphics.setFont(love.graphics.newFont(11))
    red = 0
    green = 122/255
    blue = 204/255
    alpha = 50/100
    love.graphics.setBackgroundColor( 0, 0, 0, alpha)
    --先将图片全部加载进来
    for i=1,table.getn(qteView.keyImages) do
        qteView.keyImages[i] = love.graphics.newImage(qteView.keyImages[i]);
        qteView.pressedImages[i] = love.graphics.newImage(qteView.pressedImages[i]);
    end
    for i=1,table.getn(qteView.keyImages_tail) do
        qteView.keyImages_tail[i] = love.graphics.newImage(qteView.keyImages_tail[i]);
        qteView.pressedImages_tail[i] = love.graphics.newImage(qteView.pressedImages_tail[i]);
    end

    qteView:nextRange()
end
qteView.currentRange = {}
qteView.imageWidth = 32
qteView.imagePadding = qteView.imageWidth * 1.2
qteView.keyImageScale = qteView.imageWidth / 200;
function qteView:draw()
    if not qteView.enabled then
        return
    end
    local keyCount = table.getn(qteView.currentRange);
    lineLength = keyCount * qteView.imagePadding;
    x = math.floor((love.graphics.getWidth() - lineLength)/2)
    y=100
    for i = 1,keyCount do
        if qteView.currentRange[i].isPressed then
            love.graphics.draw(qteView.currentRange[i].pressedImage, x+ qteView.imagePadding * (i-1), y,0,qteView.keyImageScale,qteView.keyImageScale)
        else
            love.graphics.draw(qteView.currentRange[i].keyImage, x + qteView.imagePadding * (i-1), y,0,qteView.keyImageScale,qteView.keyImageScale)
        end
    end
end

function qteView:keypressed(key)
    if not qteView.enabled then
        return
    end
    if key == "rctrl" then --set to whatever key you want to use
        debug.debug()
     end
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
    if not qteView.enabled then
        return
    end
    qteView.leftTime = qteView.leftTime - dt;
    if qteView.leftTime < 0 then
        qteView:failed()
        qteView:nextRange();
    end
    -- print(leftTime)
end

return qteView