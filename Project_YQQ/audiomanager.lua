-- AudioManager = {sourcepath = nil, type = 'static', loop = false,enabled = true}
-- AudioManager.Audios = {};
-- AudioManager.Audios["CREDITSAudio"] = "assets/audio/CREDITSAudio.mp3"

-- AudioManager:load()
--     for k, v in pairs(AudioManager.Audios) do
--         AudioManager.Audios[k] = love.audio.newSource(AudioManager.Audios[k], type)

--     end

-- end

-- function AudioManager:new(sourcepath, type)
--     o = {}
--     setmetatable(o, {__index = self})
--     self.source = love.audio.newSource(sourcepath, type)
--     return o
-- end

-- -- function AudioManager:PlayAudio()
-- --     love.audio.play(self.source)
-- -- end
-- function AudioManager:PlayAudio(name)
--     if AudioManager.Audios[name] == nil then
--         return
--     end

--     love.audio.play(AudioManager.Audios[name])
-- end