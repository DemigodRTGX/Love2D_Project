function love.load(arg)
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('Parameters.lua'))()
    assert(love.filesystem.load('Shader.lua'))()
    assert(love.filesystem.load('enemies.lua'))()
    assert(love.filesystem.load('damage.lua'))()

    Background.img = love.graphics.newImage('asset/background02.png')
    Background.img:setWrap('repeat', 'repeat')
    Background.img2 = love.graphics.newImage('asset/background01.png')
    Background.img2:setWrap('repeat', 'repeat')
    StartScreen = love.graphics.newImage('asset/StartScreen.png')
    PressStartImg = love.graphics.newImage('asset/PressStart.png')

    BackgroundStone.img = {
        --love.graphics.newImage('asset/stone01.png'),
        love.graphics.newImage('asset/stone02.png'),
        love.graphics.newImage('asset/stone03.png')
    }

    Player.img = love.graphics.newImage('asset/player_flight.png')
    Player.colliderX = Player.img:getWidth() * Player.sx
    Player.colliderY = Player.img:getHeight() * Player.sy

    bullets.img = love.graphics.newImage('asset/bullet.png')
    enemie1.img = love.graphics.newImage('asset/enemie1.png')
    enemie2.img = love.graphics.newImage('asset/enemie2.png')
    enemie3.img = love.graphics.newImage('asset/enemie3.png')
    enemybullets.img = love.graphics.newImage('asset/enemybullets.png')

    damageScreenimg = love.graphics.newImage('asset/Damage.png')

    exp = love.graphics.newImage('asset/exp.png')

    loadpatricle()

    Backgrondshader()
    uv_x_move = 0

    gameover = false
    gameoverImg = love.graphics.newImage('asset/GameOver.png')
    loadaudio()
    love.audio.play(BGM)

    --newbullets(bullets)
    IsDamageScreen = false

    isPause = false
    bgspeed = Background.speed

    font = love.graphics.newFont(22)
    defaultfont = love.graphics.getFont()

    isStartScreen = true
    StartScreenFade = 0
    love.graphics.setColor(0, 0, 0, 0)
end

bgtime = 0
function love.update(dt)
    --set FPS
    -- if dt < 1 / 60 then
    --     love.timer.sleep(1 / 60 - dt)
    -- end

    menu(dt)
    bgtime = bgtime + dt * bgspeed
    uv_x_move = bgtime
    uv_x_move = uv_x_move - math.floor(uv_x_move)
    BackGroundUpdate(dt)

    if isStartScreen == false then
        if isPause == false then
            Damege()

            Playrmove(dt)
            psystem:update(dt)

            bulletfire(bullets, dt)

            enemieMove(dt)
            createEnemyTimer = createEnemyTimer - dt
            if createEnemyTimer <= 0 then
                newenemies(enemie1, dt)
            end

            createEnemyTimer1 = createEnemyTimer1 - dt
            if createEnemyTimer1 <= 0 and Player.score >= 100 then
                enemie1.speed = 120
                newenemies(enemie2, dt)
            end

            createEnemyTimer2 = createEnemyTimer2 - dt
            if createEnemyTimer2 <= 0 and Player.score >= 200 then
                enemie1.speed = 150
                enemie2.speed = 80

                newenemies(enemie3, dt)
            end

            createEnemyTimerMax = 1 - Player.score / 500
            if createEnemyTimerMax <= 0.2 then
                createEnemyTimerMax = 0.2
            end

            createEnemyTimerMax1 = 4 - Player.score / 800
            if createEnemyTimerMax1 <= 0.5 then
                createEnemyTimerMax1 = 0.5
            end
            --    print(Player.colliderX)

            createEnemyTimerMax2 = 10 - Player.score / 1000
            if createEnemyTimerMax2 <= 2 then
                createEnemyTimerMax2 = 2
            end

            if Player.score >= 1000 then
                enemie1.hp = 20
                enemie2.hp = 100
                enemie3.hp = 200
                enemie3.speed = 80
            end

            DamageScreenUpdate(dt)
        end
    else
        StartScreenUpdate(dt)
    end
end

function love.draw()
    BackgroundDraw(Background)

    if isStartScreen == false then
        bulletDraw()
        PlayerDraw(Player)
        enemieDraw()
        love.graphics.draw(psystem, Player.x + 2, Player.y + 12)

        menuDraw()
        DamageScreenDraw()
    else
        StartScreenDraw()
    end

    --  love.graphics.draw(exp, 100, 100)
    -- love.graphics.print(createEnemyTimerMax,0,10)
    -- love.graphics.print(createEnemyTimer,0,30)
    --  Debug(#enemie1renderlist)
end
