local testcomponents = {}
testcomponents.enabled = true

function testcomponents:load()
end

function testcomponents:update(dt)
    if not testcomponents.enabled then
        return
    end

  --  print('test')
end

function testcomponents:draw()
    if not testcomponents.enabled then
        return
    end
end

return testcomponents
