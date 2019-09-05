AudioManager = {sourcepath = nil, type = 'static', loop = false}

function AudioManager:new(sourcepath, type)
    o = {}
    setmetatable(o, {__index = self})
    self.source = love.audio.newSource(sourcepath, type)
    return o
end

function AudioManager:PlayAudio()
    love.audio.play(self.source)
end