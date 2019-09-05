function DelayTimer(dt, delaytime)
    delaytime = math.max(0, delaytime - dt)
    --   print(delaytime)

    return delaytime
end

function Lerp(a, b, t)
    return a * (1 - t) + b * t
end

function floatdistacne(x, y)
    if math.abs(x - y) <= 1 then
        return true
    else
        return false
    end
end

function ToggleTime(time)
    if gametime < time then
        return true
    else
        return false
    end
end

function DrawFont(text, x, y, size, r, g, b, a)
    font = love.graphics.newFont(size)
    love.graphics.setFont(font)
    love.graphics.setColor(r, g, b, a)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1, 1)
end
