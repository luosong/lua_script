--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-27
-- Time: 下午4:53
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-19
-- Time: 下午1:41
-- To change this template use File | Settings | File Templates.
--

require("data.levels_gs")

local CActivityScene = class("CActivityScene", function()
    return display.newScene("CActivityScene")
end)

function CActivityScene:init()

    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = display.newSprite("treasure.png")
    self.bg:setPosition(game.cx, self.bg:getContentSize().height / 2)
    self.node:addChild(self.bg)


end

function CActivityScene:ctor()

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CActivityScene

