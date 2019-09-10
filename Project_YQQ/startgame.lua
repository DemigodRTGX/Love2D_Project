local startgameComponents = {}
startgameComponents.enabled = true

function startgameComponents:load(arg)
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    assert(love.filesystem.load('AudioManager.lua'))()

    zhonggao = TweenUIimg:new('assets/img/youxizhonggao.png', 0, 0, 0, 1, 1)

    StartBG = TweenUIimg:new('assets/img/StartBG.png', 0, 0, 0, 1, 1)
    Shift = TweenUIimg:new('assets/img/Shift.png', 0, 245, 0, 1, 1)
    PressStart = TweenUIimg:new('assets/img/CREDITS.png', 0, 0, 0, 1, 1)
    CREDITSimg = love.graphics.newImage('assets/img/PressStart.png')

    StartGameAnimation = true
    LoginScreen = false
    Store = false
    CREDITS = 0
end

function startgameComponents:update(dt)
    if not startgameComponents.enabled then
        -- print('1111')

        return
    end

    timer(dt)
    CREDITS = math.min(CREDITS, 99)
    if StartGameAnimation == true then
        if ToggleTime(TimeManger.zhonggaoFadeIn) then
            zhonggao:fade(dt, 2)
        elseif ToggleTime(TimeManger.zhonggaoStay) then
            zhonggao:wait()
        elseif ToggleTime(TimeManger.zhonggaoFadeOut) then
            zhonggao:fade(dt, -2)
        elseif ToggleTime(TimeManger.StartBGFadeIn) then
            StartBG:fade(dt, 4)
            StartBG:wait()
            Shift:MoveTo(dt, 0, 0, 0, -100)
        elseif ToggleTime(TimeManger.End) == true then
            StartGameAnimation = false
            LoginScreen = true
        end
    end
    if LoginScreen == true then
        PressStart:fadesin(dt, 2)
    end

    EndStartgameScreen(dt)
end

function startgameComponents:draw()
    if not startgameComponents.enabled then
        return
    end

    if StartGameAnimation == true then
        if ToggleTime(TimeManger.zhonggaoFadeIn) then
            zhonggao:drawfade()
        elseif ToggleTime(TimeManger.zhonggaoStay) then
            zhonggao:draw()
        elseif ToggleTime(TimeManger.zhonggaoFadeOut) then
            zhonggao:drawfade()
        elseif ToggleTime(TimeManger.StartBGFadeIn) then
            StartBG:drawfade()
            Shift:draw()
        elseif ToggleTime(TimeManger.End) then
            StartBG:draw()
            Shift:draw()
        else
            StartGameAnimation = false
        end
    end
    if LoginScreen == true then
        StartBG:draw()
        Shift:draw()
        PressStart:drawfade()
        DrawFont('CREDITS:', 225, 215, 14, 1, 1, 1, 1)
        DrawFont(CREDITS, 295, 215, 14, 1, 1, 1, 1)
    end
    EndStartgameScreenDraw()
end

function startgameComponents:keypressed(k)
    if k == 'escape' then
        love.event.push('quit')
    end
    if k == 'return' and LoginScreen == true then
        -- CREDITSAudio = AudioManager:new('assets/audio/CREDITSAudio.mp3', 'static')
        -- CREDITSAudio:PlayAudio()
        Components["Res"]:PlayAudio("CREDITSAudio",true)
        CREDITS = CREDITS + 1
        PressStart:replace(CREDITSimg)
    end
    if k == 'j' and CREDITS > 0 then
        isfadeoutStart = true
        Store = true

    -- Components['Battle']:Start()
    --  Components['startgame'].enabled = false
    end
end
gametime = 0
function timer(dt)
    gametime = gametime + dt
end

isfadeoutStart = false
fadeoutStarttime = 1

function EndStartgameScreen(dt)
    if isfadeoutStart == true then
        fadeoutStarttime = fadeoutStarttime - dt

        if fadeoutStarttime <= 0 then
            Components['storyscreen'].enabled = true

            LoginScreen = false
            startgameComponents.enabled = false
         print(fadeoutStarttime)
        end
    end
end

function EndStartgameScreenDraw()
    if isfadeoutStart == true then
        if fadeoutStarttime <= 0 then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(0, 0, 0, 1 - fadeoutStarttime)
            love.graphics.rectangle('fill', 0, 0, 320, 240)
        end
    end
end

return startgameComponents
