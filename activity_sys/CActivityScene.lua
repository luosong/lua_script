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

    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    self.bg:setPreferredSize(CCSizeMake(display.width * (33.2 / 40), display.height * (36 / 40)))

    self.bg:setPosition(display.width * (20.4 / 40), display.height * (18 / 40))
    self.node:addChild(self.bg)



end

function CActivityScene:ctor()

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CActivityScene

