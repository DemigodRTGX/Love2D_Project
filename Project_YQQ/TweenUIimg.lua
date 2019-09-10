TweenUIimg = {img = nil, x = 0, y = 0, r = 0, sx = 1, sy = 1, fadetime = 0}
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
function TweenUIimg:wait()
end

function TweenUIimg:replace(img)
    self.img = img
end

local d = 0
function TweenUIimg:fade(dt, fadetime)
    d = d + dt * fadetime
    d = math.min(1, d)

    self.fadetime = d

    if d == 1 then
        return true
    else
        return false
    end
    --print(self.fadetime)
end

function TweenUIimg:translate(dt, x, y)
    self.x = self.x + x * dt
    self.y = self.y + y * dt
end

function TweenUIimg:rotate(dt, r)
    self.r = self.r + r * dt
end

function TweenUIimg:MoveTo(dt, x, y, speedX, speedY)
    if floatdistacne(self.x, x) == false then
        self.x = self.x + dt * speedX
    end
    if floatdistacne(self.y, y) == false then
        self.y = self.y + dt * speedY
    end

    --  print(math.abs(self.y - y))
end

function TweenUIimg:Scale(dt, sx, sy)
    self.sx = self.sx + sx * dt
    self.sy = self.sy + sy * dt
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
    love.graphics.setColor(1, 1, 1, self.fadetime)
    love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy)
end

fadesintimer = 0
function TweenUIimg:fadesin(dt, fadetime)
    fadesintimer = fadesintimer + dt * fadetime
    --fadesintimer = math.sin(fadesintimer)
    -- print(math.sin(fadesintimer))
    self.fadetime = math.abs(math.sin(fadesintimer))
end
