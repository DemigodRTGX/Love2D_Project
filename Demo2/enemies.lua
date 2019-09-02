function newenemies(enemie1, dt)
    newenemie = {}
    newenemie.img = enemie1.img
    newenemie.speed = enemie1.speed
    newenemie.x = love.graphics.getWidth() + 10
    newenemie.y = love.math.random(10, love.graphics.getHeight() - 20)
    newenemie.sx = enemie1.sx
    newenemie.sy = enemie1.sy
    newenemie.hp = enemie1.hp
    table.insert(enemie1renderlist, newenemie)
    createEnemyTimer = createEnemyTimerMax
end

enemie1renderlist = {}

function enemieMove(dt)
    for i, v in ipairs(enemie1renderlist) do
        v.x = v.x - v.speed * dt
    end
end
function enemieDraw()
    for i, v in ipairs(enemie1renderlist) do
        love.graphics.draw(v.img, v.x, v.y, 0, v.sx, v.xy)
        if showCollider == true then
            love.graphics.rectangle('line', v.x, v.y, v.img:getWidth() * v.sx, v.img:getHeight() * v.sy)
        end

        if v.x <= 0 - 40 then
            table.remove(enemie1renderlist, i)
        end
    end
end
