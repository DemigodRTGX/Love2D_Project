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
