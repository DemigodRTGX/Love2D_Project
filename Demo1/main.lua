function love.load(arg)
    assert(love.filesystem.load('BasicFunction.lua'))()
    assert(love.filesystem.load('Parameters.lua'))()

    img = love.graphics.newImage('asset/01.png')

    local screen_width, screen_height = love.graphics.getDimensions()
    local max_stars = 100

    stars = {}

    for i = 1, max_stars do
        local x = love.math.random(5, screen_width - 5)
        local y = love.math.random(5, screen_height - 5)
        stars[i] = {x, y}
    end

    timer = IconTime
    DrawIcon = false
end

function love.update(dt)
    InstanceIMG_Update(dt)

    timer = timer - dt

    if timer <= 0 then
        if DrawIcon == false then
            timer = IconTime
            DrawIcon = true
            InstanceIcon()
        end
    end
end

function love.draw()
    for i, star in ipairs(stars) do
        love.graphics.points(star[1], star[2])
    end
    RenderDrawCall()
     love.graphics.print(timer,0,50)
end

function InstanceIcon()
    InstanceIMG_Draw(img, love.graphics.getWidth() - imgspeed.x, love.graphics.getHeight() / 2, 0, 1, 1)
    DrawIcon = false
end
