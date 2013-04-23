--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-9
-- Time: 下午3:30
-- To change this template use File | Settings | File Templates.
--

 local CLoadingLayer = class("CLoadingLayer")

function CLoadingLayer:init()

    -- self:setTouchEnabled(true)
    -- self:registerScriptTouchHandler(function(eventType, x, y)
    --     if eventType == "began" then
    --         return true
    --     end
    -- end, false, -128, true)

    -- local sprite = display.newSprite("loading.png")
    -- sprite:setPosition(display.cx, display.cy)
    -- self.node:addChild(sprite)


    -- sprite:runAction(CCRepeatForever:create(transition.sequence({
    --     CCRotateBy:create(1, 180)
    -- })))


end

function CLoadingLayer:ctor( loadfunc, ptr )

    -- self.node = display.newNode()
    -- self.node:setPosition(0, 0)
    -- self:addChild(self.node)
    -- self:init()
    self.loadfunc = loadfunc

    self.index = 1
    local function LoadUpdate( dt )
        if(self.index == 1) then
            device.showActivityIndicator()
        elseif(self.index == 2) then
            self:loadfunc(ptr)
        elseif(self.index == 3) then
            self.index = 0
            device.hideActivityIndicator()
            self.scheduler.unscheduleGlobal(self.schedulerUpdate)
        end
        self.index = self.index + 1
    end
    self.scheduler = require("framework.client.scheduler")
    self.schedulerUpdate = self.scheduler.scheduleGlobal( LoadUpdate, 0.1, false )
end

return CLoadingLayer
