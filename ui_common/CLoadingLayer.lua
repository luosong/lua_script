--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-9
-- Time: 下午3:30
-- To change this template use File | Settings | File Templates.
--

 local CLoadingLayer = class("CLoadingLayer", function()
     return CCLayerColor:create(ccc4(0, 0, 0, 0), display.width, display.height)
 end)

function CLoadingLayer:init()

    self:setTouchEnabled(true)
    self:registerScriptTouchHandler(function(eventType, x, y)
        if eventType == "began" then
            return true
        end
    end, false, -128, true)

    local sprite = display.newSprite("loading.png")
    sprite:setPosition(display.cx, display.cy)
    self.node:addChild(sprite)


    sprite:runAction(CCRepeatForever:create(transition.sequence({
        CCRotateBy:create(1, 180)
    })))


end

function CLoadingLayer:ctor()

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)
    self:init()
end

return CLoadingLayer
