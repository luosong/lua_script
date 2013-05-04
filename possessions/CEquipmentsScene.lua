--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-20
-- Time: 下午4:03
-- To change this template use File | Settings | File Templates.
--
local ItemType_Equip  = 3
local CEquipmentsScene = class("CFriendsScene", function()
    return display.newScene("CFriendsScene")
end)

function CEquipmentsScene:init()

    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    -- self.bg:setPreferredSize(CCSizeMake(display.width * (33.2 / 40), display.height * (36 / 40)))
    -- self.bg:setPosition(display.width * (20.4 / 40), display.height * (18 / 40))

    self.node:addChild(self.bg)

    local allButton = nil
    local weaponButton = nil
    local dressButton = nil
    local otherButton = nil
    local perButton = nil


    local nodes = {}
    local itemNodes = display.newNode()
    itemNodes:setPosition(0, 0)
    self.node:addChild(itemNodes)
    local function setSelButtonDisable(buttonType)
        if (perButton) then
            perButton:setEnabled(true)
            perButton:unselected()
        end

        if buttonType == EquipmentType.WEAPON then
            if weaponButton then
                weaponButton:setEnabled(false)
                weaponButton:selected()
                perButton = weaponButton
            end
        elseif buttonType == EquipmentType.DRESS then
            if (dressButton) then
                dressButton:setEnabled(false)
                dressButton:selected()
                perButton = dressButton
            end
        elseif buttonType == EquipmentType.OTHER then
            if (otherButton) then
                otherButton:setEnabled(false)
                otherButton:selected()
                perButton = otherButton
            end
        else
            if allButton then
                allButton:setEnabled(false)
                allButton:selected()
                perButton = allButton
            end

        end
    end

    local function initItem(equitType)
        nodes = {}
        itemNodes:removeAllChildrenWithCleanup(true)
        setSelButtonDisable(equitType)
        local equips = game.Player:getEquipments()
        if #equips >= 1 then
            local dlgNode = display.newNode()
            dlgNode:setPosition(0, 0)
            itemNodes:addChild(dlgNode, 2)

            local function displayAction()

                local a1 = CCMoveTo:create(0.5, CCPointMake(display.width * (1/ 4), 0))
                local a2 = CCScaleTo:create(0.5, 0.8)
                dlgNode.Enhancelayer:runAction(CCSpawn:createWithTwoActions(a1, a2))

                local a3 = CCMoveTo:create(0.5, CCPointMake(-display.width * (1/ 4), 0))
                local a4 = CCScaleTo:create(0.5, 0.8)
                dlgNode.detailLayer:runAction(CCSpawn:createWithTwoActions(a3, a4))

            end

            local function eventListener(event)

                  if string.upper(event.name) == string.upper(GlobalVariable["NotificationTag"]["EQUIPMENT_DETAIL_LAYER"]) then
                      dlgNode.detailLayer = nil
                      dlgNode.detailEvent:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["EQUIPMENT_DETAIL_LAYER"])
                      dlgNode.detailEvent:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["EQUIPMENT_DOUBLE_DETAIL"])
                  elseif string.upper(event.name) == string.upper(GlobalVariable["NotificationTag"]["EQUIPMENT_ENHANCE_LAYER"]) then
                      dlgNode.Enhancelayer = nil
                      dlgNode.enhancelEvent:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["EQUIPMENT_ENHANCE_LAYER"])
                      if (dlgNode.detailLayer ~= nil) then
                          local a3 = CCMoveTo:create(0.5, CCPointMake(0, 0))
                          local a4 = CCScaleTo:create(0.5, 1)
                          dlgNode.detailLayer:runAction(CCSpawn:createWithTwoActions(a3, a4))
                      end
                  elseif string.upper(event.name) == string.upper(GlobalVariable["NotificationTag"]["EQUIPMENT_DOUBLE_DETAIL"]) then

                      dlgNode.Enhancelayer = require("possessions.CEnhanceLayer").new(dlgNode.detailLayer:getData(), dlgNode.Enhancelayer)
                      dlgNode:addChild(dlgNode.Enhancelayer)
                      dlgNode.enhancelEvent = require("framework.client.api.EventProtocol").extend(dlgNode.Enhancelayer)
                      dlgNode.Enhancelayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_ENHANCE_LAYER, eventListener)
                      displayAction()
                  end

            end

            local function onTouchItem(itemData)
                dlgNode.detailLayer = require("possessions.CItemInfoLayer").new(itemData, 1)
                dlgNode:addChild(dlgNode.detailLayer)

                dlgNode.detailEvent = require("framework.client.api.EventProtocol").extend(dlgNode.detailLayer)
                dlgNode.detailLayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_DETAIL_LAYER, eventListener)
                dlgNode.detailLayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_DOUBLE_DETAIL, eventListener)

            end

            local function c_func(f, ...)
                local args = {... }

                return function() f(unpack(args)) end
            end

            local function onEnhanceButton(obj)
                dlgNode.Enhancelayer = require("possessions.CEnhanceLayer").new(obj, dlgNode.Enhancelayer)
                dlgNode:addChild(dlgNode.Enhancelayer)

                dlgNode.enhancelEvent = require("framework.client.api.EventProtocol").extend(dlgNode.Enhancelayer)
                dlgNode.Enhancelayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_ENHANCE_LAYER, eventListener)

            end

            local i = 1
            for k, v in ipairs(equips) do

                if (equitType == nil or equitType == v:getType()) then
                    nodes[i] = require("possessions.CItemSprite").new(v, ItemType_Equip)
                    nodes[i]:setTouchListener(c_func(onTouchItem, v))
                    local button = ui.newImageMenuItem({
                        image = "#button12.png",
                        imageSelected = "#button13.png",
                        listener = c_func(onEnhanceButton, v),
                        x =  nodes[i]:getContentSize().width * (12 / 32),
                        y = -nodes[i]:getContentSize().height * (1 / 6)
                    })

                    local label = ResourceMgr:getUISprite("font_dz")
                    label:setPosition(button:getContentSize().width / 2, button:getContentSize().height / 2)
                    button:addChild(label)

                    local menu = ui.newMenu({button})
                    menu:setPosition(0, 0)
                    nodes[i]:addChild(menu)
                    i = i + 1
                end

            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (5 / 40),
                y = CFuncHelper:getTopBarH() + 20,
                width = display.width * (30.8 / 40),
                height = self.bg:getContentSize().height-40,
                pageSize = 4,
                rowSize = 1,
                nodes = nodes,
                vertical = true
            })
            scrollLayer:setPosition(0, 0)
            itemNodes:addChild(scrollLayer)
        else
            local label = ui.newTTFLabel({
                text = "赶紧战斗，抢几件装备吧",
                size = 38,
                x    = game.cx,
                y    = display.cy,
                align = ui.TEXT_ALIGN_CENTER
            })

            itemNodes:addChild(label)
        end

    end

    local function initButton()

        local function onButton(buttonType)
            initItem(buttonType)

        end

        local function c_func(f, ...)
            local argc = {... }
            return function()
                f(unpack(argc))
            end
        end

        allButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton),
        })
        allButton:setPosition(display.width - allButton:getContentSize().width / 2,
            baseLayer:getLeftHeight() + CFuncHelper:getTopBarH() - allButton:getContentSize().height/2)
        local allLabel = ui.newTTFLabel({
            text = "所\n有",
            size = 28,
            align = ui.TEXT_ALIGN_CENTER,
            x = allButton:getContentSize().width / 2,
            y = allButton:getContentSize().height / 2
        })
        allButton:addChild(allLabel)
        local maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(0, allButton:getContentSize().height/2)
        allButton:addChild(maodingSprite, 2)


        weaponButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, EquipmentType.WEAPON),
        })
        weaponButton:setPosition(display.width - weaponButton:getContentSize().width / 2,
            baseLayer:getLeftHeight() + CFuncHelper:getTopBarH() - weaponButton:getContentSize().height * 1.5)
        local weaponLabel = ResourceMgr:getUISprite("font_bq")
        weaponLabel:setPosition(weaponButton:getContentSize().width / 2, weaponButton:getContentSize().height / 2)
        weaponButton:addChild(weaponLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(0, weaponButton:getContentSize().height/2)
        weaponButton:addChild(maodingSprite, 2)


        dressButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, EquipmentType.DRESS),
        })
        dressButton:setPosition(display.width - dressButton:getContentSize().width / 2,
            baseLayer:getLeftHeight() + CFuncHelper:getTopBarH() - dressButton:getContentSize().height * 2.5)
        local dressLabel = ResourceMgr:getUISprite("font_fz")
        dressLabel:setPosition(dressButton:getContentSize().width / 2, dressButton:getContentSize().height / 2)
        dressButton:addChild(dressLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(0, dressButton:getContentSize().height/2)
        dressButton:addChild(maodingSprite, 2)


        otherButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, EquipmentType.OTHER),
        })
        otherButton:setPosition(display.width - otherButton:getContentSize().width / 2,
            baseLayer:getLeftHeight() + CFuncHelper:getTopBarH() - otherButton:getContentSize().height * 3.5)
        local otherLabel = ResourceMgr:getUISprite("font_sp")
        otherLabel:setPosition(otherButton:getContentSize().width / 2, otherButton:getContentSize().height / 2)
        otherButton:addChild(otherLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(0, otherLabel:getContentSize().height/2)
        otherLabel:addChild(maodingSprite, 2)

        local menu = ui.newMenu({allButton, weaponButton, dressButton, otherButton})
        self:addChild(menu)
    end


    initButton()

    self.bg:setPreferredSize(CCSizeMake(display.width - baseLayer:getLeftWidth() - weaponButton:getContentSize().width, baseLayer:getLeftHeight()))
    self.bg:setPosition(baseLayer:getLeftWidth() + self.bg:getContentSize().width/2, baseLayer:getLeftHeight()/2 + CFuncHelper:getTopBarH())

    initItem()




end

function CEquipmentsScene:ctor()

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CEquipmentsScene