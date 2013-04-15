--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-15
-- Time: 下午6:43
-- To change this template use File | Settings | File Templates.
--

local CChargeDartScene = class("CChargeDartScene", function()
    return display.newScene("CChargeDartScene");
end)

function CChargeDartScene:init()
    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    local taskDescBg = display.newSprite("task_desc.png")
    taskDescBg:setPosition(display.width * (10 / 40), game.cy)
    self.node:addChild(taskDescBg)

    local nodes = {}
    for i = 1, 8 do
        nodes[i] = require("ui_common.CScrollCell").new(display.newSprite("task_item.png"))
    end

    local scrollLayer = require("ui_common.CScrollLayer").new({
        x = display.width * (16 / 40),
        y = 0,
        width = display.width * (24 / 40),
        height = display.height * (35 / 40),
        pageSize = 5,
        rowSize = 1,
        nodes = nodes,
        vertical = true
    })
    scrollLayer:setPosition(0, 0)
    self.node:addChild(scrollLayer)

end


function CChargeDartScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CChargeDartScene