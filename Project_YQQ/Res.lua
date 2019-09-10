

Res = {}
Res.enabled = true;
Res.Images={};
Res.Audios = {}
Res.Audios["CREDITSAudio"] = "assets/audio/CREDITSAudio.mp3"
-- Res.Images[""] = ""
function Res:load()
    for k, v in pairs(Res.Images) do
        Res.Images[k] = love.graphics.newImage(v)
        print( Res.Images[k])
    end
    for k, v in pairs(Res.Audios) do
        Res.Audios[k] = love.audio.newSource(v, 'static');
        print(Res.Audios[k])
    end

end

function Res:PlayAudio(name,...)
    if name == nil then
        return nil
    end
    local arg = {...}
    force = false;
    if table.getn(arg) > 1 then
        force = arg[1];
    end
    if Res.Audios[name] == nil then
        print("cant find audio file "..name);
        return
    end
    if force then
        Res.Audios[name]:stop()
    end
    -- print(Res.Audios[name])
    -- local isp = Res.Audios[name]:isStopped()
    -- print(isp)
    -- if not isp then
    --      Res.Audios[name]:stop()
    -- end
    Res.Audios[name]:play()
    -- love.audio.play(Res.Audios[name])
end

function Res:GetImage(name)
    if Res.Images[name] == nil then
        print("cant find audio file "..name);
        return
    end
    
    return  Res.Images[name]
end
return Res