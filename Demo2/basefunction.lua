function BackGroundUpdate(dt)
    Backgroundtimer = Backgroundtimer - dt
    if Backgroundtimer <= -0.2 then
        newBackGroundStone(BackgroundStone)
        Backgroundtimer = 0.5
    end
    for i, v in ipairs(newBackGroundStoneRender) do
        v.x = v.x - dt * v.speed
    end
end

function BackgroundDraw(Background)
    love.graphics.setShader(bgShader)
    bgShader:send('Time', uv_x_move)
    love.graphics.draw(Background.img)
    love.graphics.setShader()

    for i, v in ipairs(newBackGroundStoneRender) do
        love.graphics.draw(v.img, v.x, v.y, v.r, v.sx, v.sy)
        if v.x < -10 then
            table.remove(newBackGroundStoneRender, i)
        end
    end

    --    love.graphics.print(#newBackGroundStoneRender, 0, 50)
    --    love.graphics.print(Backgroundtimer, 0, 60)
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
    elseif love.keyboard.isDown('right') then
        Player.x = Player.x + Player.speed * dt
        fireparticlesize.max = -1400
        fireparticlesize.min = -400
    else
        fireparticlesize.max = -700
        fireparticlesize.min = -200
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

function FireAudioPlay()
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
    if love.keyboard.isDown('j', 'k') and canShoot and isPause == false then
        if Player.score < 200 then
            newbullets(bullets, 5, 5)
        elseif Player.score < 400 then
            newbullets(bullets, 5, 5)
            newbullets(bullets, 5, 12)
        else
            newbullets(bullets, 5, 5)
            newbullets(bullets, 5, 12)

            newbullets(bullets, 5, 19)
        end
        FireAudioPlay()

        canShoot = false
    end

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    if love.keyboard.isDown('return') and gameover == true then
        gameover = false
        IsReset = true
        isPause = false
        IsDamageScreen = false
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
    love.graphics.print('HP:')
    love.graphics.print(Player.hp, 20, 0)
    love.graphics.print('Score:', 50, 0)
    love.graphics.print(Player.score, 120, 0)
    --gameover
    if Player.hp <= 0 and gameover == false then
        Reset()
        love.audio.play(PlayerDeadaudio)
        love.graphics.print('Game Over~')
        gameover = true
        isPause = true
    end
    if gameover then
        love.graphics.draw(gameoverImg)
    end

    if isPause == true and gameover == false then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 0, 0, 320, 240)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('Pause', 140, 120, 0, 1, 1)
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
