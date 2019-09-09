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
                    Player.score = Player.score + 10
                    table.remove(enemie1renderlist, i)
                    love.audio.stop(enemyDeadaudio)

                    love.audio.play(enemyDeadaudio)
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
end

function DamageScreenDraw()
    if IsDamageScreen == true then
        love.graphics.draw(damageScreenimg)
    end
end
