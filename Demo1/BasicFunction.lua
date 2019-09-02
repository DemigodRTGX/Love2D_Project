function Debug(text)
    love.graphics.print(text)
end

renderlist = {}

function InstanceIMG_Update(dt)
    for i, v in ipairs(renderlist) do
        v.x = v.x - 50 * dt
        if v.x < -100 then
            Destroy(i)
        end
    end
end

function InstanceIMG_Draw(drawable, x, y, r, sx, sy, ID)
    renderState = {}
    renderState.img = drawable
    renderState.x = x
    renderState.y = y
    renderState.r = r
    renderState.sx = sx
    renderState.sy = sy
    renderState.ID = 0
    table.insert(renderlist, renderState)
end

function Destroy(id)
    table.remove(renderlist, id)
end

function RenderDrawCall()
    for i, v in ipairs(renderlist) do
        v.ID = i
        love.graphics.draw(v.img, v.x, v.y, v.r, v.sx, v.sy)
    end

    Debug(#renderlist)
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end
