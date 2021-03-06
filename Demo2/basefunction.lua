function BackGroundUpdate(dt)
    Backgroundtimer = Backgroundtimer - dt
    if Backgroundtimer <= -0.2 then
        newBackGroundStone(BackgroundStone)
        Backgroundtimer = 0.5
    end
    for i, v in ipairs(newBackGroundStoneRender) do
        v.x = v.x - dt * v.speed
        if v.x < -320 then
            table.remove(newBackGroundStoneRender, i)
        end
    end
end

function BackgroundDraw(Background)
    love.graphics.setShader(bgShader)
    bgShader:send('Time', uv_x_move)
    love.graphics.draw(Background.img)
    love.graphics.setShader()

    for i, v in ipairs(newBackGroundStoneRender) do
        love.graphics.draw(v.img, v.x, v.y, v.r, v.sx, v.sy)
    end

    love.graphics.setShader(bgShader)
    bgShader:send('Time', uv_x_move * 2)
    love.graphics.draw(Background.img2)
    love.graphics.setShader()
end
newBackGroundStoneRender = {}
function newBackGroundStone(BackgroundStone)
    index = love.math.random(1, #BackgroundStone.img)
    randomScale = love.math.random(0.5, BackgroundStone.sx)
    rotation = love.math.random(0, 180)

    newBackGroundStonelist = {}
    newBackGroundStonelist.img = BackgroundStone.img[index]
    newBackGroundStonelist.x = love.graphics.getWidth() + 20
    newBackGroundStonelist.y = love.math.random(0, love.graphics.getHeight() - BackgroundStone.img[index]:getHeight())
    newBackGroundStonelist.sx = randomScale * BackgroundStone.sx
    newBackGroundStonelist.sy = randomScale * BackgroundStone.sy
    newBackGroundStonelist.r = rotation
    newBackGroundStonelist.speed = love.math.random(50, BackgroundStone.speed)
    table.insert(newBackGroundStoneRender, newBackGroundStonelist)
end

function Playrmove(dt)
    --y
    if love.keyboard.isDown('up') then
        Player.y = Player.y - Player.speed * dt
    elseif love.keyboard.isDown('down') then
        Player.y = Player.y + Player.speed * dt
    end
    --x
    if love.keyboard.isDown('left') then
        Player.x = Player.x - Player.speed * dt
        fireparticlesize.max = -300
        fireparticlesize.min = -100
        bgspeed = Background.speed * 0.8
    elseif love.keyboard.isDown('right') then
        Player.x = Player.x + Player.speed * dt
        fireparticlesize.max = -1400
        fireparticlesize.min = -400
        bgspeed = Background.speed * 1.2
    else
        fireparticlesize.max = -700
        fireparticlesize.min = -200
        bgspeed = Background.speed
    end
    psystem:setLinearAcceleration(fireparticlesize.min, 0, fireparticlesize.max, 0)

    --lim x
    if Player.x <= 0 then
        Player.x = 0
    elseif Player.x >= (love.graphics.getWidth() - Player.colliderX) then
        Player.x = love.graphics.getWidth() - Player.colliderX
    end
    --lim y
    if Player.y <= 0 then
        Player.y = 0
    elseif Player.y >= (love.graphics.getHeight() - Player.colliderY) then
        Player.y = love.graphics.getHeight() - Player.colliderY
    end
end

function PlayerDraw(Player)
    love.graphics.draw(Player.img, Player.x, Player.y, Player.r, Player.sx, Player.sy)
    if showCollider == true then
        love.graphics.rectangle('line', Player.x, Player.y, Player.colliderX, Player.colliderY)
    end
end

bulletsRenderlist = {}

function FireAudioPlay(fireaudio)
    love.audio.stop(fireaudio)
    love.audio.play(fireaudio)
end
function newbullets(bullets, x, y)
    newbullet = {}
    newbullet.img = bullets.img
    newbullet.x = Player.x + Player.colliderX - x
    newbullet.y = Player.y + Player.colliderY - y
    newbullet.speed = bullets.speed
    newbullet.s = bullets.s

    table.insert(bulletsRenderlist, newbullet)
end

function bulletDraw()
    for i, v in ipairs(bulletsRenderlist) do
        love.graphics.draw(v.img, v.x, v.y, 0, 0.8, 0.8)
        if showCollider == true then
            love.graphics.rectangle('line', v.x, v.y, v.img:getWidth() / v.s, v.img:getHeight() / v.s)
        end
        if v.x >= love.graphics.getWidth() + 10 then
            table.remove(bulletsRenderlist, i)
        end
    end

    --  Debug(#bulletsRenderlist)
end

function bulletMove(bullets, dt)
end

function bulletfire(bullets, dt)
    canShootTimer = canShootTimer - dt
    if canShootTimer <= 0 then
        canShootTimer = canShootTimerMax
        canShoot = true
    end

    for i, v in ipairs(bulletsRenderlist) do
        v.x = v.speed * dt + v.x
    end
end

function menu(dt)
    if love.keyboard.isDown('j', 'k') and canShoot and isPause == false and isStartScreen == false then
        if Player.score < 200 then
            newbullets(bullets, 8, 14)
        elseif Player.score < 400 then
            if levelupID == 1 then
                levelupAudio()
                levelupID = levelupID + 1
            end

            newbullets(bullets, 8, 8)
            newbullets(bullets, 8, 14)
        else
            if levelupID == 2 then
                levelupAudio()
                levelupID = levelupID + 1
            end

            newbullets(bullets, 8, 8)
            newbullets(bullets, 8, 14)
            newbullets(bullets, 8, 20)
        end
        FireAudioPlay(fireaudio)

        canShoot = false
    end

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    if love.keyboard.isDown('return') then
        if isStartScreen == true and StartScreenFade == 1 then
            isStartScreen = false
            love.audio.play(restartaudio)
        end
        if gameover == true then
            gameover = false
            IsReset = true
            isPause = false
            IsDamageScreen = false
        end
    end

    if IsReset == true then
        if #bulletsRenderlist == 0 and #enemie1renderlist == 0 then
            IsReset = false
        else
            Reset()
        end
    end
end

function menuDraw()
    if isStartScreen == false then
        love.graphics.print('HP:')
        love.graphics.print(Player.hp, 20, 0)
        love.graphics.print('Score:', 50, 0)
        love.graphics.print(Player.score, 120, 0)
        --gameover
        if Player.hp <= 0 and gameover == false then
            --   Reset()
            love.audio.play(PlayerDeadaudio)
            -- love.graphics.print('Game Over~')
            gameover = true
            isPause = true
            IsDamageScreen = false
        end
        if gameover then
            love.graphics.draw(gameoverImg)
            love.graphics.setFont(font)
            love.graphics.print('score:', 60, 140)
            love.graphics.print(Player.score, 135, 140)
            love.graphics.setFont(defaultfont)
        end

        if isPause == true and gameover == false then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', 0, 0, 320, 240)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print('Pause', 140, 120, 0, 1, 1)
        end
    end

    -- love.graphics.print(#enemie1renderlist, 0, 50)
end

function Debug(Text)
    love.graphics.print(Text)
end

function Reset()
    for i, v in ipairs(enemie1renderlist) do
        table.remove(enemie1renderlist, i)
    end

    for i, v in ipairs(bulletsRenderlist) do
        table.remove(bulletsRenderlist, i)
    end

    Player.x = 10
    Player.y = love.graphics.getHeight() / 2
    Player.hp = 10
    love.audio.play(restartaudio)
    Player.score = 0
    createEnemyTimerMax = 1
    DamageScreentimer = DamageScreentimerMax
end

function loadaudio()
    fireaudio = love.audio.newSource('sound/Fire.mp3', 'static')
    BGM = love.audio.newSource('sound/Meltdown.ogg', 'static')
    BGM:setLooping(true)
    enemyDeadaudio = love.audio.newSource('sound/EnemyDead.mp3', 'static')
    PlayerDeadaudio = love.audio.newSource('sound/PlayerDead.mp3', 'static')
    restartaudio = love.audio.newSource('sound/Start.mp3', 'static')
    levelup = love.audio.newSource('sound/LevelUp.mp3', 'static')
    enemyfire = love.audio.newSource('sound/Enemyfire.mp3', 'static')
end

IsReset = false
function love.keyreleased(key)
    if key == 'space' then
        love.keyboard.setKeyRepeat(false)
        isPause = not isPause
    end

    if key == 'r' then
        IsReset = true
    end
end

--levelup = false
levelupID = 1
function levelupAudio()
    love.audio.play(levelup)
end

function loadpatricle()
    --particle Player
    local img = love.graphics.newImage('asset/fireparticle.png')
    psystem = love.graphics.newParticleSystem(img, 32)
    psystem:setParticleLifetime(0.2, 0.3) -- Particles live at least 2s and at most 5s.
    psystem:setEmissionRate(40)
    psystem:setSizeVariation(0)
    psystem:setLinearAcceleration(fireparticlesize.min, 0, fireparticlesize.max, 0) -- Random movement in all directions.
    psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    --
    enemyimg = love.graphics.newImage('asset/fireparticle_enemy.png')
end

d = 0
PressStartFade = 0
function StartScreenUpdate(dt)
    StartScreenFade = StartScreenFade + dt * 0.5
    StartScreenFade = math.min(StartScreenFade, 1)
    if StartScreenFade == 1 then
        d = d + dt * 2
        PressStartFade = math.abs(math.sin(d))
    end
    --  print(PressStartFade)
    -- print(StartScreenFade)
end

function StartScreenDraw()
    love.graphics.setColor(StartScreenFade, StartScreenFade, StartScreenFade, StartScreenFade)
    love.graphics.draw(StartScreen)
    love.graphics.setColor(1, 1, 1, PressStartFade)
    love.graphics.draw(PressStartImg, 0, 20)
    love.graphics.setColor(1, 1, 1, 1)
end
