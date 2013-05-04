--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午10:02
-- To change this template use File | Settings | File Templates.
--

local ItemType_KungFu = 1
local ItemType_Equip  = 2

local CMajorHerosScene = class("CMajorHerosScene", function()
    return display.newScene("CMajorHerosScene")
end)

function CMajorHerosScene:init()

    --CCRectMake(0, 0, display.width * (36 / 40), display.height * (36 / 40))
    self.bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame(GAME_RES.HUAWEN_BG))
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    self.bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(self.bg)


    local currentHero = nil
    local initKungIcon   = nil
    local initEquipmentIcon = nil
    local kungFuNodeLayout = nil
    local equipNodeLayout = nil

    local itemSprite = nil
    ----------------------初始化人物icon相关信息----------------------------

    local function c_func(f, ...)
        local args = {...}
        return function() f(unpack(args)) end
    end

    local function initHerosIcon()
        local heros = game.Player:getMajorHeros()
        local nodes = {}
        local onTouchHeros = function(obj)
            itemSprite:refreshWithData(obj)

            currentHero = obj
            initKungIcon()
            initEquipmentIcon()

        end
        ------------显示大图的icon
        local function showBigIcon()
            itemSprite = require("possessions.CDetailItemSprite").new(false, heros[1], ItemShowType.MEMBER_HEROS_INFO)
            itemSprite:setAnchorPoint(CCPointMake(0.5, 1))
            itemSprite:setPosition(game.cx, self.bg:getContentSize().height)
            self.node:addChild(itemSprite)
        end
        -----------------------显示底部icon
        local function showBottomIcon()
            for k, v in ipairs(heros) do
                local iconSprite =CSingleImageMenuItem:create(require("ui_object.CHeroIconSprite").new(v))
                iconSprite:registerScriptTapHandler(c_func(onTouchHeros, v))
                nodes[k] = ui.newMenu({ iconSprite })

            end
            local iconNodes = require("ui_common.CNodeLayout").new({
                nodes = nodes,
                width = CFuncHelper:getRelativeX(30),
                height = 0,
                rowSize = 6
            })
            iconNodes:setPosition(game.cx - CFuncHelper:getRelativeX(15), CFuncHelper:getRelativeY(4.5))
            self.node:addChild(iconNodes)
        end

        if (#heros > 0) then
            currentHero = heros[1]
            showBigIcon()
            showBottomIcon()
        end
    end
    initHerosIcon()

    local function registerNotification(obj)
        local eventListener = nil
        local function updateScene(event)
            eventListener:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"].UPDATA_MEMBERS_SCENE)
            if event.info == ItemType_KungFu then
                initKungIcon()
            elseif event.info == ItemType_Equip then
                initEquipmentIcon()
            end
            itemSprite:refreshWithData(currentHero)
        end

        eventListener = require("framework.client.api.EventProtocol").extend(obj)
        obj:addEventListener(GlobalVariable["NotificationTag"].UPDATA_MEMBERS_SCENE, updateScene)
    end

    -----------------------------------武功----------------------------------------

    local function onKungFuButton(data, bIsEquip)
        if (currentHero == nil) then
            return
        end

        if (bIsEquip) then
             printf("--------------------------------------" .. data:getName())
        else
            local kungFuLayer = require("possessions.CChooseLayer").new(currentHero, data, 1)
            kungFuLayer:setPosition(0, 0)
            self.node:addChild(kungFuLayer)
            registerNotification(kungFuLayer)
        end

    end

    initKungIcon = function()
        if kungFuNodeLayout ~= nil then
            kungFuNodeLayout:removeFromParentAndCleanup(true)
            kungFuNodeLayout = nil

        end

        local iconNodes = {}
        local currentHeroKungFus = nil
        if currentHero then
            currentHeroKungFus = currentHero:getKungFus()
        end

        for i = 1, 4 do
            local button = nil
            if (currentHeroKungFus and currentHeroKungFus[i] ~= nil) then
                button = CSingleImageMenuItem:create(require("ui_object.CSkillIconSprite").new(currentHeroKungFus[i]))
                button:registerScriptTapHandler(c_func(onKungFuButton, currentHeroKungFus[i], true))

                local nameLabel = ui.newBMFontLabel({
                    text = currentHeroKungFus[i]:getName(),
                    font = GAME_FONT.font_youyuan,
                    x = button:getContentSize().width / 2,
                    y = -button:getContentSize().height * (1 / 8)

                })
                nameLabel:setColor(ccc3(0, 0, 255))
                button:addChild(nameLabel)
            else
                button = CSingleImageMenuItem:create(ResourceMgr:getUISprite("icon_bg_white"))
                local label = ui.newTTFLabel({
                    text = "武功" .. i,
                    color = ccc3(0, 0, 0),
                    align = ui.TEXT_ALIGN_CENTER,
                    x = button:getContentSize().width / 2,
                    y = button:getContentSize().height / 2,
                    size = FONT_SIZE.MembersSceneFont.ICON_LABEL_SIZE
                })
                button:addChild(label)

                button:registerScriptTapHandler(c_func(onKungFuButton, i, false))
            end
            iconNodes[i] = ui.newMenu({button})
        end

        kungFuNodeLayout = require("ui_common.CNodeLayout").new({
            nodes = iconNodes,
            width =  CFuncHelper:getRelativeX(13),
            height = CFuncHelper:getRelativeY(24),
            rowSize = 2
        })
        kungFuNodeLayout:setPosition(CFuncHelper:getRelativeX(4), CFuncHelper:getRelativeY(10))
        self.node:addChild(kungFuNodeLayout, 0)

    end
    -----------------------------------装备---------------------------------------

    local function onEquipmentButton(data, bIsEquip, posIndex)

        local function onChangeEquip()
            local equipLayer = require("possessions.CChooseLayer").new(currentHero, posIndex, ItemType_Equip)
            equipLayer:setPosition(0, 0)
            self.node:addChild(equipLayer,3)
            registerNotification(equipLayer)
        end

        if (currentHero == nil) then
            return
        end

        if (bIsEquip) then
            local itemInfo = require("possessions.CItemInfoLayer").new(data)
            require("framework.client.api.EventProtocol").extend(itemInfo)
            itemInfo:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_DETAIL_LAYER, onChangeEquip)
            itemInfo:setPosition(0, 0)
            self.node:addChild(itemInfo, 2)
        else
            local equipLayer = require("possessions.CChooseLayer").new(currentHero, data, ItemType_Equip)
            equipLayer:setPosition(0, 0)
            self.node:addChild(equipLayer)
            registerNotification(equipLayer)
        end
    end

    initEquipmentIcon = function()

        if equipNodeLayout ~= nil then
            equipNodeLayout:removeFromParentAndCleanup(true)
            equipNodeLayout = nil
        end

        local iconNodes = {}
        local currentHeroEqupments = nil
        if currentHero then
            currentHeroEqupments = currentHero:getEquipments()
        end

        local gameText = require("data.GameText")
        local equipMapping = {
            [EquipmentType.WEAPON] = gameText.getText("IDS_WEAPON"),
            [EquipmentType.DRESS]  = gameText.getText("IDS_DRESS"),
            [EquipmentType.SHOES]  = gameText.getText("IDS_SHOES"),
            [EquipmentType.OTHER]  = gameText.getText("IDS_OTHER")
        }
        for k, v in pairs(EquipmentType) do

            local button = nil
            if (currentHeroEqupments and currentHeroEqupments[v] ~= nil) then
                button = CSingleImageMenuItem:create(require("ui_object.CEquipIconSprite").new(currentHeroEqupments[v]))
                button:registerScriptTapHandler(c_func(onEquipmentButton, currentHeroEqupments[v], true, v))
                local nameLabel = ui.newBMFontLabel({
                    text = currentHeroEqupments[v]:getName(),
                    font = GAME_FONT.font_youyuan,
                    x = button:getContentSize().width / 2,
                    y = -button:getContentSize().height * (1 / 8)

                })
                nameLabel:setColor(ccc3(0, 0, 255))
                button:addChild(nameLabel)

            else
                button = CSingleImageMenuItem:create(ResourceMgr:getUISprite("icon_bg_white"))
                button:registerScriptTapHandler(c_func(onEquipmentButton, v, false))
                local label = ui.newTTFLabel({
                    text = equipMapping[v],
                    color = ccc3(0, 0, 0),
                    align = ui.TEXT_ALIGN_CENTER,
                    x = button:getContentSize().width / 2,
                    y = button:getContentSize().height / 2,
                    size = FONT_SIZE.MembersSceneFont.ICON_LABEL_SIZE
                })
                button:addChild(label)
            end
            iconNodes[v] = ui.newMenu({button})
        end

        equipNodeLayout = require("ui_common.CNodeLayout").new({
            nodes = iconNodes,
            width =  CFuncHelper:getRelativeX(13),
            height = CFuncHelper:getRelativeY(24),
            rowSize = 2
        })

        equipNodeLayout:setPosition(CFuncHelper:getRelativeX(27), CFuncHelper:getRelativeY(10))
        self.node:addChild(equipNodeLayout, 0)
    end

    initKungIcon()
    initEquipmentIcon()

    local baseLayer = require("CBorderLayer").new(true, "精英小组")
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)


end

function CMajorHerosScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CMajorHerosScene
