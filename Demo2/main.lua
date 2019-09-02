function love.load(arg)
    assert(love.filesystem.load('basefunction.lua'))()
    assert(love.filesystem.load('Parameters.lua'))()
    assert(love.filesystem.load('Shader.lua'))()
    assert(love.filesystem.load('enemies.lua'))()
    assert(love.filesystem.load('damage.lua'))()

    Background.img = love.graphics.newImage('asset/background02.png')
    Background.img:setWrap('repeat', 'repeat')
    BackgroundStone.img = {
       -- love.graphics.newImage('asset/stone01.png'),
        love.graphics.newImage('asset/stone02.png'),
        love.graphics.newImage('asset/stone03.png')
    }

    Player.img = love.graphics.newImage('asset/player_flight.png')
    Player.colliderX = Player.img:getWidth() * Player.sx * 0.8
    Player.colliderY = Player.img:getHeight() * Player.sy * 0.8

    bullets.img = love.graphics.newImage('asset/bullet.png')
    enemie1.img = love.graphics.newImage('asset/enemie1.png')

    Backgrondshader()
    uv_x_move = 0

    gameover = false
    gameoverImg = love.graphics.newImage('asset/GameOver.png')
    loadaudio()
    love.audio.play(BGM)
    love.audio.play(restartaudio)
    --newbullets(bullets)
    IsDamageScreen = false

    isPause = false
end

function love.update(dt)
    menu(dt)
    Damege()

    if isPause == false then
        Playrmove(dt)

        uv_x_move = love.timer.getTime() * Background.speed
        uv_x_move = uv_x_move - math.floor(uv_x_move)

        bulletfire(bullets, dt)

        enemieMove(dt)
        createEnemyTimer = createEnemyTimer - (1 * dt)
        if createEnemyTimer <= 0 then
            newenemies(enemie1, dt)
        end
        createEnemyTimerMax = 1 - Player.score / 500
        DamageScreenUpdate(dt)
        BackGroundUpdate(dt)

    end
end

function love.draw()
    BackgroundDraw(Background)
    bulletDraw()
    PlayerDraw(Player)
    enemieDraw()

    DamageScreenDraw()

    menuDraw()

    -- love.graphics.print(createEnemyTimerMax,0,10)
    -- love.graphics.print(createEnemyTimer,0,30)
    --  Debug(#enemie1renderlist)
end
