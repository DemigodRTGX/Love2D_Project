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
    damageScreenimg = love.graphics.newImage('asset/Damage.png')

    --particle
    local img = love.graphics.newImage('asset/fireparticle.png')

    psystem = love.graphics.newParticleSystem(img, 32)
    psystem:setParticleLifetime(0.2, 0.3) -- Particles live at least 2s and at most 5s.
    psystem:setEmissionRate(40)
    psystem:setSizeVariation(0)
    psystem:setLinearAcceleration(fireparticlesize.min, 0, fireparticlesize.max, 0) -- Random movement in all directions.
    psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
    --
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
    bgspeed = Background.speed

end

bgtime = 0
function love.update(dt)
    menu(dt)
    Damege()

    if isPause == false then
        Playrmove(dt)
        psystem:update(dt)
        bgtime = bgtime + dt * bgspeed
        uv_x_move = bgtime
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
    love.graphics.draw(psystem, Player.x + 2, Player.y + 12)

    DamageScreenDraw()

    menuDraw()

    -- love.graphics.print(createEnemyTimerMax,0,10)
    -- love.graphics.print(createEnemyTimer,0,30)
    --  Debug(#enemie1renderlist)
end
