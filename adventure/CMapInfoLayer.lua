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

    if self.dropItem1[1] > 0 then
        local icon = nil
        local data = nil
        if self.dropItem1[1] == ItemType.EQUIPMENT then
            data = require("game_model.CEquip").new(BaseData_equipments[self.dropItem1[2]])
            icon = require("ui_object.CEquipIconSprite").new(data)
        elseif self.dropItem1[1] == ItemType.SKILL then
            data = require("game_model.CSkill").new(BaseData_skills[self.dropItem1[2]])
            icon = require("ui_object.CSkillIconSprite").new(data)
        end
        icon:setPosition(self.bg:getContentSize().width / 4, self.bg:getContentSize().height / 6)
        icon:setScale(0.8)
        self.bg:addChild(icon)

        local nameLabel = ui.newBMFontLabel({
            text = data:getName(),
            font = GAME_FONT.font_youyuan,
            x = icon:getContentSize().width / 2,
            y = -icon:getContentSize().height * (1 / 8)

        })
        nameLabel:setColor(ccc3(0, 0, 255))
        icon:addChild(nameLabel)
    end

    if self.dropItem2[1] > 0 then
        local icon = nil
        local data = nil
        if self.dropItem2[1] == ItemType.EQUIPMENT then
            data = require("game_model.CEquip").new(BaseData_equipments[self.dropItem2[2]])
            icon = require("ui_object.CEquipIconSprite").new(data)
        elseif self.dropItem2[1] == ItemType.SKILL then
            data = require("game_model.CSkill").new(BaseData_skills[self.dropItem2[2]])
            icon = require("ui_object.CSkillIconSprite").new(data)
        end
        icon:setPosition(self.bg:getContentSize().width * (2.5 / 4), self.bg:getContentSize().height / 6)
        icon:setScale(0.8)
        self.bg:addChild(icon)
        local nameLabel = ui.newBMFontLabel({
            text = data:getName(),
            font = GAME_FONT.font_youyuan,
            x = icon:getContentSize().width / 2,
            y = -icon:getContentSize().height * (1 / 8)

        })
        nameLabel:setColor(ccc3(0, 0, 255))
        icon:addChild(nameLabel)
    end
end

function CMapInfoLayer:getContentSize()
    return self.bg:getContentSize()
end

function CMapInfoLayer:ctor(data)
    self.name = data.name or ""
    self.exp  = data.exp or 0
    self.gold = data.gold or 0
    self.desc = data.desc or ""

    self.dropItem1 = data.drop_item1
    self.dropItem2 = data.drop_item2

    self:init()
end

return  CMapInfoLayer