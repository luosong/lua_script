--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-19
-- Time: 下午4:08
-- To change this template use File | Settings | File Templates.
--

local CMapInfoLayer = class("CMapInfoLayer", function()
    return display.newNode()
end)

function CMapInfoLayer:init()

    self.bg = ResourceMgr:getUISprite("level_desc_bg")
    local contSize = self.bg:getContentSize()
    self.bg:setAnchorPoint(CCPointMake(1, 0))
    self.bg:setPosition(0, 0)
    self:addChild(self.bg)
    self:setContentSize(contSize)

    local nameLabel = ui.newTTFLabel({
        text = self.name,
        size = 36,
        x = contSize.width / 2,
        y = contSize.height * (32 / 40),
        align = ui.TEXT_ALIGN_CENTER
    })
    self.bg:addChild(nameLabel)

    local expLabel = ui.newTTFLabel({
        text = "经验:   " .. self.exp,
        size = 20,
        x = contSize.width * (1 / 3),
        y = contSize.height * (25 / 40),
        align = ui.TEXT_ALIGN_CENTER
    })
    self.bg:addChild(expLabel)

    local goldLabel = ui.newTTFLabel({
        text = "金币:   " .. self.gold,
        size = 20,
        x = contSize.width * (1 / 3),
        y = contSize.height * (20 / 40),
        align = ui.TEXT_ALIGN_CENTER
    })
    self.bg:addChild(goldLabel)

    local descLabel = ui.newTTFLabel({
        text = self.desc,
        size = 20,
        x = contSize.width * (1 / 2),
        y = contSize.height * (15 / 40),
        align = ui.TEXT_ALIGN_CENTER
    })
    self.bg:addChild(descLabel)
end

function CMapInfoLayer:getContentSize()
    return self.bg:getContentSize()
end

function CMapInfoLayer:ctor(data)
    self.name = data.name or ""
    self.exp  = data.exp or 0
    self.gold = data.gold or 0
    self.desc = data.desc or ""

    self:init()
end

return  CMapInfoLayer