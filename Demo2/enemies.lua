function newenemies(enemie1, dt, x, y, sx, xy)
    newenemie = {}
    newenemie.img = enemie1.img
    newenemie.id = enemie1.id

    if newenemie.id == 4 then
        newenemie.x = x
        newenemie.y = y
        newenemie.speedX = enemie1.speedX * sx
        newenemie.speedY = enemie1.speedY * xy
    else
        newenemie.x = love.graphics.getWidth() + 10
        newenemie.y = love.math.random(10, love.graphics.getHeight() - enemie1.img:getHeight())
        newenemie.speedX = enemie1.speedX
        newenemie.speedY = enemie1.speedY
    end

    newenemie.sx = enemie1.sx
    newenemie.sy = enemie1.sy
    newenemie.hp = enemie1.hp
    newenemie.hp = enemie1.hp
    newenemie.id = enemie1.id
    newenemie.damage = enemie1.damage
    table.insert(enemie1renderlist, newenemie)

    if newenemie.id == 1 then
        createEnemyTimer = createEnemyTimerMax
        --particle
        newenemie.particle = love.graphics.newParticleSystem(enemyimg, 32)
        newenemie.particle:setParticleLifetime(0.2, 0.5) -- Particles live at least 2s and at most 5s.
        newenemie.particle:setEmissionRate(6)
        newenemie.particle:setSizeVariation(0)
        newenemie.particle:setLinearAcceleration(15, 0, 20, 0)
        newenemie.particle:setColors(1, 1, 1, 1, 1, 1, 1, 0)

        newenemie.px = enemie1.px
        newenemie.py = enemie1.py
        newenemie.ps = enemie1.ps
    elseif newenemie.id == 2 then
        createEnemyTimer1 = createEnemyTimerMax1
        --particle

        newenemie.particle = love.graphics.newParticleSystem(enemyimg, 32)
        newenemie.particle:setParticleLifetime(1, 0.5) -- Particles live at least 2s and at most 5s.
        newenemie.particle:setEmissionRate(4)
        newenemie.particle:setSizeVariation(0)
        newenemie.particle:setLinearAcceleration(20, 0, 40, 0)
        newenemie.particle:setColors(1, 1, 1, 1, 1, 1, 1, 0)

        newenemie.px = enemie2.px
        newenemie.py = enemie2.py
        newenemie.ps = enemie2.ps

        newenemie.enemycanShoot = enemie1.enemycanShoot
        newenemie.enemyShootTimerMax = enemie1.enemyShootTimerMax
        newenemie.enemyShootTimer = newenemie.enemyShootTimerMax
        newenemie.ammo = enemie1.ammo
    elseif newenemie.id == 3 then
        createEnemyTimer2 = createEnemyTimerMax2
        --particle

        newenemie.particle = love.graphics.newParticleSystem(enemyimg, 32)
        newenemie.particle:setParticleLifetime(1, 0.5) -- Particles live at least 2s and at most 5s.
        newenemie.particle:setEmissionRate(8)
        newenemie.particle:setSizeVariation(0)
        newenemie.particle:setLinearAcceleration(20, 0, 80, 0)
        newenemie.particle:setColors(1, 1, 1, 1, 1, 1, 1, 0)

        newenemie.px = enemie3.px
        newenemie.py = enemie3.py
        newenemie.ps = enemie3.ps

        newenemie.enemycanShoot = enemie1.enemycanShoot
        newenemie.enemyShootTimerMax = enemie1.enemyShootTimerMax
        newenemie.enemyShootTimer = newenemie.enemyShootTimerMax
        newenemie.ammo = enemie1.ammo
    end
end

enemie1renderlist = {}

function enemieMove(dt)
    for i, v in ipairs(enemie1renderlist) do
        v.x = v.x - v.speedX * dt
        v.y = v.y - v.speedY * dt

        if v.id <= 3 then
            v.particle:update(dt)
        else
            --    print(v.x)
        end

        if v.id == 3 or v.id == 2 and v.x < 300 then
            v.enemyShootTimer = v.enemyShootTimer - dt
            if v.enemyShootTimer <= 0 then
                v.enemyShootTimer = v.enemyShootTimerMax
                v.enemycanShoot = true
                if v.enemycanShoot == true and v.ammo > 0 then
                    --  print('shoot')
                    if v.id == 3 then
                        newenemies(enemybullets, dt, v.x - 5, v.y + 23, v.x - Player.x, v.y - Player.y)
                    end
                    if v.id == 2 then
                        newenemies(enemybullets, dt, v.x - 5, v.y + 5, v.x - Player.x, v.y - Player.y)
                    end

                    v.ammo = v.ammo - 1
                end
            end
        end
        if v.x < -320 or v.y < -480 or v.y > 240 then
            table.remove(enemie1renderlist, i)
        end
    end
end
function enemieDraw()
    for i, v in ipairs(enemie1renderlist) do
        if v.id <= 3 then
            love.graphics.draw(v.particle, v.x + v.px, v.y + v.py, 0, v.ps, v.ps)
        else
            -- love.graphics.draw(enemybullets.img, v.x, v.y)
            --     print(v.x)
        end

        love.graphics.draw(v.img, v.x, v.y, 0, v.sx, v.xy)

        if showCollider == true then
            love.graphics.rectangle('line', v.x, v.y, v.img:getWidth() * v.sx, v.img:getHeight() * v.sy)
        end
    end
end
