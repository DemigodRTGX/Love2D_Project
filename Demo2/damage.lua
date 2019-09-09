function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function Damege()
    for i, enemy in ipairs(enemie1renderlist) do
        if
            CheckCollision(
                enemy.x,
                enemy.y,
                enemy.img:getWidth() * enemy.sx,
                enemy.img:getHeight() * enemy.sy,
                Player.x,
                Player.y,
                Player.colliderX,
                Player.colliderY
            )
         then
            love.audio.stop(enemyDeadaudio)
            love.audio.play(enemyDeadaudio)
            table.remove(enemie1renderlist, i)
            Player.hp = Player.hp - enemy.damage
            IsDamageScreen = true
        end
        for j, bullet in ipairs(bulletsRenderlist) do
            if
                CheckCollision(
                    enemy.x,
                    enemy.y,
                    enemy.img:getWidth() * enemy.sx,
                    enemy.img:getHeight() * enemy.sy,
                    bullet.x,
                    bullet.y,
                    bullet.img:getWidth() / bullet.s,
                    bullet.img:getHeight() / bullet.s
                )
             then
                if enemy.id <= 3 then
                    table.remove(bulletsRenderlist, j)
                    enemy.hp = enemy.hp - Player.damge
                end

                if enemy.hp < 0 then
                    table.remove(enemie1renderlist, i)
                    love.audio.stop(enemyDeadaudio)

                    love.audio.play(enemyDeadaudio)
                    if enemy.id == 1 then
                        Player.score = Player.score + 10
                        newexp(
                            exp,
                            enemy.x + enemy.img:getWidth() * enemy.sx / 2,
                            enemy.img:getHeight() * enemy.sy / 2 + enemy.y,
                            0,
                            0.5,
                            0.5,
                            0.05
                        )
                    elseif enemy.id == 2 then
                        Player.score = Player.score + 20
                        newexp(
                            exp,
                            enemy.x + enemy.img:getWidth() * enemy.sx / 2,
                            enemy.img:getHeight() * enemy.sy / 2 + enemy.y,
                            0,
                            0.8,
                            0.8,
                            0.05
                        )
                    elseif enemy.id == 3 then
                        Player.score = Player.score + 50
                        newexp(
                            exp,
                            enemy.x + enemy.img:getWidth() * enemy.sx / 2,
                            enemy.img:getHeight() * enemy.sy / 2 + enemy.y,
                            0,
                            1.2,
                            1.2,
                            0.05
                        )
                    end
                end
            end
        end
    end
end

function DamageScreenUpdate(dt)
    if IsDamageScreen == true then
        DamageScreentimer = DamageScreentimer - dt
    end
    if DamageScreentimer <= 0 then
        IsDamageScreen = false
        DamageScreentimer = DamageScreentimerMax
    end
    expupdate(dt)
end

function DamageScreenDraw()
    if IsDamageScreen == true then
        love.graphics.draw(damageScreenimg)
    end
    expdraw()
end

expeffectlist = {}
function newexp(img, x, y, r, sx, sy, timer)
    exptable = {}
    exptable.img = img
    exptable.x = x
    exptable.y = y
    --exptable.r = love.math.random(0, 180)
    exptable.sx = sx
    exptable.sy = sy
    exptable.timer = timer
    table.insert(expeffectlist, exptable)
end

function expupdate(dt)
    for i, v in ipairs(expeffectlist) do
        v.sy = v.sy - dt
        v.sx = v.sx - dt
        v.timer = v.timer - dt
    end
end

function expdraw()
    for i, v in ipairs(expeffectlist) do
        love.graphics.draw(v.img, v.x, v.y, v.r, v.sx, v.sy, v.img:getWidth() / 2, v.img:getHeight() / 2)
        if v.timer < 0 then
            table.remove(expeffectlist, i)
        end
    end
end
