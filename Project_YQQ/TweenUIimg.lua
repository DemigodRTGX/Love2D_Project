TweenUIimg = {imgpath = nil, x = 0, y = 0, r = 0, sx = 1, sy = 1, fadetime = 0}
function TweenUIimg:new(imgpath, x, y, r, sx, sy)
    o = {} or o
    setmetatable(o, self)
    self.__index = self
    self.img = love.graphics.newImage(imgpath)
    self.x = x
    self.y = y
    self.r = r
    self.sx = sx
    self.sy = sy
    return o
end

local d = 0
local fade = 0
function TweenUIimg:fade(dt, fadetime)
    d = d + dt * fadetime
    fade = (-math.pow(d, 2) + 2 * d)
    fade = math.max(0, fade)
end

function TweenUIimg:translate(dt, x, y)
    TweenUIimg.x = TweenUIimg.x + x * dt
    TweenUIimg.y = TweenUIimg.y + y * dt
end

function TweenUIimg:rotate(dt, r)
    TweenUIimg.r = TweenUIimg.r + r * dt
end

function TweenUIimg:Scale(dt, sx, sy)
    TweenUIimg.sx = TweenUIimg.sx + sx * dt
    TweenUIimg.sy = TweenUIimg.sy + sy * dt
end

function TweenUIimg:draw()
    love.graphics.setColor(1, 1, 1, fade)
    love.graphics.draw(TweenUIimg.img, TweenUIimg.x, TweenUIimg.y, TweenUIimg.r, TweenUIimg.sx, TweenUIimg.sy)
end


