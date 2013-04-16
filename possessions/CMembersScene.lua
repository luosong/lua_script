--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午10:02
-- To change this template use File | Settings | File Templates.
--

local ItemType_KungFu = 1
local ItemType_Equip  = 2

local CMembersScene = class("CMembersScene", function()
    return display.newScene("CMembersScene")
end)

function CMembersScene:init()

    --CCRectMake(0, 0, display.width * (36 / 40), display.height * (36 / 40))
    self.bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame("board19"))
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    self.bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(self.bg)


    local currentHero = nil
    local initKungIcon   = nil
    local initEquipmentIcon = nil
    local kungFuNodeLayout = nil
    local equipNodeLayout = nil

    ----------------------初始化人物icon相关信息----------------------------
    local function initHerosIcon()
        local heros = game.Player:getHeros()
        local nodes = {}

        local itemSprite = nil
        local onTouchHeros = function(sender)
            itemSprite:refreshWithData(sender:getData())

            currentHero = sender:getData()
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

                local head =require("battle_system.CHeroSprite").new(v, "head")
                nodes[k] = require("ui_common.CScrollCell").new(head)
                nodes[k]:setTouchListener(onTouchHeros)

            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = game.cx - CFuncHelper:getRelativeX(15),
                y = 0,
                width = CFuncHelper:getRelativeX(30),
                height = CFuncHelper:getRelativeY(8),
                pageSize = 6,
                rowSize = 6,
                nodes = nodes,
                vertical = false
            })
            scrollLayer:setPosition(0 , 0)
            self.node:addChild(scrollLayer)
        end

        if (#heros > 0) then
            currentHero = heros[1]
            showBigIcon()
            showBottomIcon()
        end
    end
    initHerosIcon()


    -----------------------------------武功----------------------------------------

    local function registerNotification(obj)
        local eventListener = nil

        local function updateScene(event)
            eventListener:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"].UPDATA_MEMBERS_SCENE)
            if event.info == ItemType_KungFu then
                initKungIcon()
            elseif event.info == ItemType_Equip then
                initEquipmentIcon()
            end
        end

        eventListener = require("framework.client.api.EventProtocol").extend(obj)
        obj:addEventListener(GlobalVariable["NotificationTag"].UPDATA_MEMBERS_SCENE, updateScene)
    end

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

    local function c_func(f, ...)
        local args = {...}
        return function() f(unpack(args)) end
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
            if (currentHeroKungFus[i] ~= nil) then
                button = CSingleImageMenuItem:create(ResourceMgr:getIconSprite(currentHeroKungFus[i]:getIcon()))
                button:registerScriptTapHandler(c_func(onKungFuButton, currentHeroKungFus[i], true))
            else
                button = CSingleImageMenuItem:create(display.newSprite("frame_bg.png"))
                local label = ui.newTTFLabel({
                    text = "武功" .. i,
                    color = ccc3(0, 0, 0),
                    align = ui.TEXT_ALIGN_CENTER,
                    x = button:getContentSize().width / 2,
                    y = button:getContentSize().height / 2
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
        self.node:addChild(kungFuNodeLayout)

    end
    -----------------------------------装备---------------------------------------

    local function onEquipmentButton(data, bIsEquip)

        if (currentHero == nil) then
            return
        end

        if (bIsEquip) then

            printf("--------------------------------------------------" .. data:getName())
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

        local equipMapping = {
            [EquipmentType.WEAPON] = "武器",
            [EquipmentType.DRESS]  = "衣服",
            [EquipmentType.SHOES]  = "鞋",
            [EquipmentType.OTHER]  = "配饰"
        }
        for k, v in pairs(EquipmentType) do

            local button = nil
            if (currentHeroEqupments[v] ~= nil) then
                button = CSingleImageMenuItem:create(ResourceMgr:getIconSprite(currentHeroEqupments[v]:getIcon()))
                button:registerScriptTapHandler(c_func(onEquipmentButton, currentHeroEqupments[v], true))
            else
                button = CSingleImageMenuItem:create(display.newSprite("frame_bg.png"))
                button:registerScriptTapHandler(c_func(onEquipmentButton, v, false))
                local label = ui.newTTFLabel({
                    text = equipMapping[v],
                    color = ccc3(0, 0, 0),
                    align = ui.TEXT_ALIGN_CENTER,
                    x = button:getContentSize().width / 2,
                    y = button:getContentSize().height / 2
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
        self.node:addChild(equipNodeLayout)
    end

    initKungIcon()
    initEquipmentIcon()

    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)


end

function CMembersScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

end

return CMembersScene
