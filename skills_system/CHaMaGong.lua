--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-17
-- Time: 下午7:57
-- To change this template use File | Settings | File Templates.
--

local CHaMaGong = class("CHaMaGong", function()
    return display.newNode()
end)



function CHaMaGong:init()

    local sprite1 = display.newSprite("wugong/hama_2.png")
    sprite1:setRotation(180)
    sprite1:setScaleX(display.width/sprite1:getContentSize().width)
    sprite1:setPosition(display.width / 2, display.height)
    self:addChild(sprite1)

    local sprite2 = display.newSprite("wugong/hama_2.png")
    sprite2:setPosition(display.width / 2, 0)
    sprite2:setScaleX(display.width/sprite1:getContentSize().width)
    self:addChild(sprite2)

    local sprite3 = display.newSprite("wugong/hama_1.png")
    sprite3:setPosition(display.width / 2, display.height / 2)
    self:addChild(sprite3)
    sprite3:setScale(0)

    transition.moveTo(sprite1, {time = 0.3, x = display.width / 2, y = display.height / 2})
    --transition.moveTo(sprite2, {time = 0.5, x = display.width / 2, y = display.height / 2})
    sprite2:runAction(transition.sequence({
        CCMoveTo:create(0.3, CCPointMake(display.width / 2, display.height / 2)),
        CCCallFunc:create(function()
            sprite3:runAction(transition.sequence({
                CCScaleTo:create(0.4, 3),
                CCScaleTo:create(0.3, 1)
            }))
        end)
    }) )

end

function CHaMaGong:ctor()
    self:init()
end

return CHaMaGong