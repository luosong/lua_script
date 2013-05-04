--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-30
-- Time: 上午10:54
-- To change this template use File | Settings | File Templates.
--

local ItemType_Bag    = 1
local ItemType_KungFu = 2
local ItemType_Equip  = 3

local CItemSprite = class("CItemSprite", function(data, itemType)
    local sprite = CCScale9Sprite:create("bartile.png")

    local spriteH = sprite:getContentSize().height
    if ItemType_Bag == itemType then
        sprite:setPreferredSize(CCSizeMake(display.width * (33 / 40), spriteH))
    elseif ItemType_Equip == itemType then
        sprite:setPreferredSize(CCSizeMake(display.width * (30 / 40), spriteH))
    elseif ItemType_KungFu == itemType then
        sprite:setPreferredSize(CCSizeMake(display.width * (32.5 / 40), spriteH))
    end

    return require("ui_common.CScrollCell").new(sprite)

end)

function CItemSprite:init(data, itemType)

    local function initEquip()
        local icon = require("ui_object.CEquipIconSprite").new(data)
        icon:setPosition(-self:getContentSize().width * (12 / 32), 0)
        self:addChild(icon)
        local desc = ui.newTTFLabel({
            text = data:getName(),
            x = -self:getContentSize().width * (8 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.DESC_LABEL_SIZE
        })
        self:addChild(desc)

        local effectValue = ui.newTTFLabel({
            text = data:getEffect(),
            x = -self:getContentSize().width * (8 / 32),
            y = -self:getContentSize().height * (1 / 3.5),
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.EFFECT_VALUE_LABEL_SIZE
        })
        self:addChild(effectValue)

        for i = 1, data:getProperty() do
            local starSprite =  ResourceMgr:getUISprite("icon_star")
            starSprite:setPosition(0 + starSprite:getContentSize().width + (i - 1) * starSprite:getContentSize().width,
                self:getContentSize().height * (1 / 3.5))
            self:addChild(starSprite)
        end

        local levelLabel = ui.newTTFLabel({
            text = "级别:  " .. tostring(data:getLevel()),
            x = self:getContentSize().width * (1 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.PROPERTY_LABEL_SIZE
        })
        self:addChild(levelLabel)



        local statusLabel = ui.newTTFLabel({
            text = data:getStatus(),
            x = self:getContentSize().width * (1 / 32),
            y = -self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.EFFECT_VALUE_LABEL_SIZE
        })
        self:addChild(statusLabel)
    end

    local function initKungFu()
        local icon = require("ui_object.CSkillIconSprite").new(data)
        icon:setPosition(-self:getContentSize().width * (12 / 32), 0)
        self:addChild(icon)
        local desc = ui.newTTFLabel({
            text = data:getName(),
            x = -self:getContentSize().width * (8 / 32),
            y = self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.DESC_LABEL_SIZE
        })
        self:addChild(desc)

        local name = "攻"

        local atkTypeNameMap = {
            [SkillAtkType.SINGLE_PERSON] = "单体攻击",
            [SkillAtkType.SINGLE_ROW]    = "单行攻击",
            [SkillAtkType.SINGLE_COL]    = "单列攻击",
            [SkillAtkType.CROSS]         = "十字攻击",
            [SkillAtkType.ALL]           = "全体攻击",
            [SkillAtkType.CIRCLE]        = "回字攻击"
        }

        local effectValue = ui.newTTFLabel({
            text = name .. "  " .. tostring(data:getValue()) .. "   " .. atkTypeNameMap[data:getAttackType()],
            x = -self:getContentSize().width * (8 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.EFFECT_VALUE_LABEL_SIZE
        })
        self:addChild(effectValue)

        for i = 1, data:getProperty() do
            local starSprite =  ResourceMgr:getUISprite("icon_star")
            starSprite:setPosition(0 + starSprite:getContentSize().width + (i - 1) * starSprite:getContentSize().width,
                self:getContentSize().height * (1 / 3.5))
            self:addChild(starSprite)
        end

        local levelLabel = ui.newTTFLabel({
            text = "级别:  " .. tostring(data:getLevel()),
            x = self:getContentSize().width * (1 / 32),
            y = 0,
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.PROPERTY_LABEL_SIZE
        })
        self:addChild(levelLabel)

        local statusLabel = ui.newTTFLabel({
            text = data:getStatus(),
            x = self:getContentSize().width * (1 / 32),
            y = -self:getContentSize().height * (1 / 4.5),
            color = ccc3(0, 0, 255),
            size = FONT_SIZE.ItemSpriteFont.EFFECT_VALUE_LABEL_SIZE
        })
        self:addChild(statusLabel)
    end

    local function initBag()

    end

    if ItemType_Bag == itemType then
        initBag()
    elseif ItemType_KungFu == itemType then
        initKungFu()
    elseif ItemType_Equip == itemType then
        initEquip()
    end
end

function CItemSprite:ctor(data, itemType)

    self:init(data, itemType)
end

return CItemSprite