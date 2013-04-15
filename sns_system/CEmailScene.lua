--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-15
-- Time: 下午6:38
-- To change this template use File | Settings | File Templates.
--

local CEmailScene = class("CEmailScene", function()
    return display.newScene("CEmailScene")
end)

function CEmailScene:init()
    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = display.newSprite("email.png")
    self.bg:setPosition(game.cx, self.bg:getContentSize().height / 2)
    self.node:addChild(self.bg)
end

function CEmailScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

end

return CEmailScene
