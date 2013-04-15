--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-30
-- Time: 上午10:54
-- To change this template use File | Settings | File Templates.
--

local ItemType_KungFu = 1
local ItemType_Equip  = 2

local CChooseItemSprite = class("CChooseItemSprite", function(data, itemType)
    local bgFile = "choose_item.png"
    return require("ui_common.CScrollCell").new(display.newSprite(bgFile))
end)

function CChooseItemSprite:init(data, itemType)

    local function initEquip()
        local icon = ResourceMgr:getIconSprite(data:getIcon())
        icon:setScale(0.6)
        icon:setPosition(-self:getContentSize().width * (12 / 32), 0)
        self:addChild(icon)
        local desc = ui.newTTFLabel({
            text = data:getName(),
            x = -self:getContentSize().width * (8 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 22
        })
        self:addChild(desc)

        local et = data:getEffectType()
        local name = "攻"
        if EquipmentEffectType.ATTACK == et then
            name = "攻"
        elseif EquipmentEffectType.DEFENSE == et then
            name = "防"
        elseif EquipmentEffectType.HP == et then
            name = "血"
        elseif EquipmentEffectType.MAGIC == et then
            name = "内"
        end

        local effectValue = ui.newTTFLabel({
            text = name .. "  " .. tostring(data:getValue()),
            x = -self:getContentSize().width * (8 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(effectValue)

        local property = ui.newTTFLabel({
            text = "星级:  " .. tostring(data:getProperty()),
            x = self:getContentSize().width * (1 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(property)

        local levelLabel = ui.newTTFLabel({
            text = "级别:  " .. tostring(11),
            x = self:getContentSize().width * (1 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(levelLabel)

        local statusLabel = ui.newTTFLabel({
            text = data:getStatus(),
            x = self:getContentSize().width * (1 / 32),
            y = -self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 12
        })
        self:addChild(statusLabel)
    end

    local function initKungFu()
        local icon = ResourceMgr:getIconSprite(data:getIcon())
        icon:setPosition(-self:getContentSize().width * (12 / 32), 0)
        self:addChild(icon)
        local desc = ui.newTTFLabel({
            text = data:getName(),
            x = -self:getContentSize().width * (8 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 22
        })
        self:addChild(desc)

        local name = "攻"

        local atkTypeNameMap = {
            [SkillAtkType.SINGLE_PERSON] = "单体攻击",
            [SkillAtkType.SINGLE_ROW]    = "单行攻击",
            [SkillAtkType.SINGLE_COL]    = "单列攻击",
            [SkillAtkType.CROSS]         = "十字攻击",
            [SkillAtkType.All]           = "全体攻击"
        }

        local effectValue = ui.newTTFLabel({
            text = name .. "  " .. tostring(data:getValue()) .. "   " .. atkTypeNameMap[data:getAttackType()],
            x = -self:getContentSize().width * (8 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(effectValue)

        local property = ui.newTTFLabel({
            text = "星级:  " .. tostring(data:getProperty()),
            x = self:getContentSize().width * (1 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(property)

        local levelLabel = ui.newTTFLabel({
            text = "级别:  " .. tostring(11),
            x = self:getContentSize().width * (1 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = 22
        })
        self:addChild(levelLabel)

        local statusLabel = ui.newTTFLabel({
            text = data:getStatus(),
            x = self:getContentSize().width * (1 / 32),
            y = -self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = 18
        })
        self:addChild(statusLabel)
    end

   if ItemType_KungFu == itemType then
        initKungFu()
    elseif ItemType_Equip == itemType then
        initEquip()
    end
end

function CChooseItemSprite:ctor(data, itemType)

    self:init(data, itemType)
end

return CChooseItemSprite