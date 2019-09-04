TweenUIimg = {imgpath = nil, x = 0, y = 0, r = 0, sx = 1, sy = 1, fadetime = 0}
function TweenUIimg:new(imgpath, x, y, r, sx, sy)
    o = {}
    setmetatable(o, {__index = self})
    o.img = love.graphics.newImage(imgpath)
    o.x = x
    o.y = y
    o.r = r
    o.sx = sx
    o.sy = sy
    o.fadetime = 0
    return o
end

local d = 0
local fade = 1
function TweenUIimg:fade(dt, fadetime)
    d = d + dt
    d = math.min(fadetime, d)
    fade = math.abs(math.sin(d)) * fadetime
end

function TweenUIimg:translate(dt, x, y)
    TweenUIimg.x = TweenUIimg.x + x * dt
    TweenUIimg.y = TweenUIimg.y + y * dt
end

function TweenUIimg:rotate(dt, r)
    TweenUIimg.r = TweenUIimg.r + r * dt
end

function TweenUIimg:MoveTo(dt, x, y, speedX, speedY)
    if floatdistacne(self.x, x) == false then
        self.x = self.x + dt * speedX
    end
    if floatdistacne(self.y, y) == false then
        self.y = self.y + dt * speedY
    end

    print(math.abs(self.y - y))
end

function TweenUIimg:Scale(dt, sx, sy)
    TweenUIimg.sx = TweenUIimg.sx + sx * dt
    TweenUIimg.sy = TweenUIimg.sy + sy * dt
end

function TweenUIimg:SetPosition(x, y)
    self.x = self.x
    self.y = self.y
end

function TweenUIimg:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy)
end

function TweenUIimg:drawfade()
    love.graphics.setColor(1, 1, 1, fade)
    love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy)
end
