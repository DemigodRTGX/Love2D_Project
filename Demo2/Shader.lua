function Backgrondshader()
    local pixelcode =
        [[

            extern float Time;

    vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
    {
       
        vec4 texcolor = Texel(tex, vec2(texture_coords.x + Time,texture_coords.y));
        return texcolor * color;
    }
]]

    local vertexcode =
        [[
    vec4 position( mat4 transform_projection, vec4 vertex_position )
    {
        return transform_projection * vertex_position;
    }
]]

    bgShader = love.graphics.newShader(pixelcode)
    
end
