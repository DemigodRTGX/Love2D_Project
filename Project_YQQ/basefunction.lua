function DelayTimer(dt,delaytime)
    delaytime = math.max(0,delaytime - dt)
     print(delaytime)

    return delaytime
end
