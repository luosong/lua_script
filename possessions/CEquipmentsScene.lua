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

    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    local nodes = {}
    local function initItem()

        local equips = game.Player:getEquipments()
        if #equips >= 1 then
            local dlgNode = display.newNode()
            dlgNode:setPosition(0, 0)
            self.node:addChild(dlgNode, 2)

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
                dlgNode.detailLayer = require("possessions.CItemInfoLayer").new(itemData)
                dlgNode:addChild(dlgNode.detailLayer)

                dlgNode.detailEvent = require("framework.client.api.EventProtocol").extend(dlgNode.detailLayer)
                dlgNode.detailLayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_DETAIL_LAYER, eventListener)
                dlgNode.detailLayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_DOUBLE_DETAIL, eventListener)

            end

            local function c_func(f, ...)
                local args = {... }

                return function() f(unpack(args)) end
            end

            local function onEnhanceButton(tag, sender)
                dlgNode.Enhancelayer = require("possessions.CEnhanceLayer").new(sender.data, dlgNode.Enhancelayer)
                dlgNode:addChild(dlgNode.Enhancelayer)

                dlgNode.enhancelEvent = require("framework.client.api.EventProtocol").extend(dlgNode.Enhancelayer)
                dlgNode.Enhancelayer:addEventListener(GlobalVariable["NotificationTag"].EQUIPMENT_ENHANCE_LAYER, eventListener)

            end

            for k, v in ipairs(equips) do

                nodes[k] = require("possessions.CItemSprite").new(v, ItemType_Equip)
                nodes[k]:setTouchListener(c_func(onTouchItem, v))

                local button = CSingleImageMenuItem:create("button.png")
                button.data = v
                button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
                button:registerScriptTapHandler(onEnhanceButton)
                local label = ui.newTTFLabel({
                    text = "强化",
                    align = ui.TEXT_ALIGN_CENTER,
                    x = button:getContentSize().width / 2,
                    y = button:getContentSize().height / 2
                })
                button:addChild(label)

                local menu = ui.newMenu({button})
                menu:setPosition(0, 0)
                nodes[k]:addChild(menu)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (4 / 40),
                y = display.height * (0.6 / 40),
                width = display.width * (35.8 / 40),
                height = display.height * (35 / 40),
                pageSize = 4,
                rowSize = 1,
                nodes = nodes,
                vertical = true
            })
            scrollLayer:setPosition(0, 0)
            self.node:addChild(scrollLayer)
        else
            local label = ui.newTTFLabel({
                text = "赶紧战斗，抢几件装备吧",
                size = 38,
                x    = game.cx,
                y    = display.cy,
                align = ui.TEXT_ALIGN_CENTER
            })

            self.node:addChild(label)
        end

    end

    initItem()


end

function CEquipmentsScene:ctor()

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CEquipmentsScene