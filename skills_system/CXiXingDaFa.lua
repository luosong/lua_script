--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-9
-- Time: 上午11:28
-- To change this template use File | Settings | File Templates.
--

local CXiXingDaFa = class("CXiXingDaFa", function()
    return display.newNode()
end)


function CXiXingDaFa:init()
    local sprite1 = display.newSprite("xixingdafa/1.png")
    sprite1:setPosition(0, display.height / 2)
    self:addChild(sprite1)

   -- local action = CCRotateTo:create(1, 2800)
    sprite1:runAction(transition.sequence({
        CCSpawn:createWithTwoActions(
            CCRotateTo:create(1, 1900),
            CCMoveTo:create(1, CCPointMake(display.width, display.height / 2))),
        CCCallFunc:create(function()
            local sprite2 = display.newSprite("xixingdafa/3.png")
            sprite2:setPosition(0, display.height / 2)
            sprite2:setRotation(90)
            self:addChild(sprite2)

            sprite2:runAction(transition.sequence({
                CCMoveTo:create(0.3, CCPointMake(display.width, display.height / 2)),
                CCCallFunc:create(function()
                    local s1 = display.newSprite("xixingdafa/xi.png")
                    s1:setPosition(-10, display.height * (27.5 / 40))
                    s1:setRotation(-90)
                    self:addChild(s1)
                    local s2 = display.newSprite("xixingdafa/xing.png")
                    s2:setPosition(-10, display.height * (22.5 / 40))
                    self:addChild(s2)
                    s2:setRotation(-90)
                    local s3 = display.newSprite("xixingdafa/da.png")
                    s3:setPosition(-10, display.height * (17.5 / 40))
                    self:addChild(s3)
                    s3:setRotation(-90)
                    local s4 = display.newSprite("xixingdafa/fa.png")
                    s4:setPosition(-10, display.height * (12.5 / 40))
                    self:addChild(s4)
                    s4:setRotation(-90)
                    s1:runAction(transition.sequence({
                        CCMoveTo:create(0.1, CCPointMake(display.width / 2, display.height * (32 / 40)))
                    }))

                    s2:runAction(transition.sequence({
                        CCDelayTime:create(0.05),
                        CCMoveTo:create(0.1, CCPointMake(display.width / 2, display.height * (24 / 40)))
                    }))

                    s3:runAction(transition.sequence({
                        CCDelayTime:create(0.1),
                        CCMoveTo:create(0.1, CCPointMake(display.width / 2, display.height * (16 / 40)))
                    }))

                    s4:runAction(transition.sequence({
                        CCDelayTime:create(0.15),
                        CCMoveTo:create(0.1, CCPointMake(display.width / 2, display.height * (8 / 40)))
                    }))

                end)
            }))
        end)
    }))




end

function CXiXingDaFa:ctor()
    self:init()
end

return CXiXingDaFa