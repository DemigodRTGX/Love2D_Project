function love.load(arg)
    assert(love.filesystem.load('TweenUIimg.lua'))()
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('parameters.lua'))()
    assert(love.filesystem.load('AudioManager.lua'))()

    zhonggao = TweenUIimg:new('asset/img/youxizhonggao.png', 0, 0, 0, 1, 1)

    StartBG = TweenUIimg:new('asset/img/StartBG.png', 0, 0, 0, 1, 1)
    Shift = TweenUIimg:new('asset/img/Shift.png', 0, 245, 0, 1, 1)
    PressStart = TweenUIimg:new('asset/img/PressStart.png', 0, 0, 0, 1, 1)

    StartGameAnimation = true
    LoginScreen = false
    Store = false
    CREDITS = 0
end

function love.update(dt)
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
end

function love.draw()
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
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.push('quit')
    end
    if k == 'space' and LoginScreen == true then
        CREDITSAudio = AudioManager:new('asset/audio/CREDITSAudio.mp3', 'static')

        CREDITSAudio:PlayAudio()
        CREDITS = CREDITS + 1
    end
    if k == 'return' and CREDITS > 0 then
        LoginScreen = false
        Store = true
    end
end
gametime = 0
function timer(dt)
    gametime = gametime + dt
    print(gametime)
end
