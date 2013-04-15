--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-2
-- Time: 下午7:18
-- To change this template use File | Settings | File Templates.
--

local ItemType_KungFu = 1
local ItemType_Equip  = 2

local CChooseLayer = class("CChooseLayer", function()

    return CCLayerColor:create(ccc4(100, 100, 100, 155), display.width, display.height)
end)

function CChooseLayer:init(data, index, itemType)
    self:setTouchEnabled(true)

    self:registerScriptTouchHandler(function(eventType, x, y)
        if eventType == "began" then
            return true
        end
    end, false, -128, true)

    local bg = display.newSprite("item_bg.png")
    bg:setPosition(display.width / 2, display.height / 2)
    self:addChild(bg)

    local nodes = {}
    local preButton = nil
    local function initItem()

        local items = nil

        if itemType == ItemType_KungFu then
            items = game.Player:getSkills()
        elseif itemType == ItemType_Equip then
            items = game.Player:getEquipments()
        end
        if items and #items >= 1 then

            local function onTouchItem(itemData)
                printf("----------------详细信息----------------" .. itemData:getName())
            end


            local function onEquipButton(itemData, sender)

                if (preButton ~= nil) then
                    --preButton.data:setOwner(nil)
                    preButton:setEnabled(true)
                    preButton:unselected()
                end

                preButton = sender
                preButton.data = itemData
                sender:setEnabled(false)
                sender:selected()

            end

            local function c_func(f, ...)
                local args = {... }
                return function() f(unpack(args)) end
            end

            for k, v in ipairs(items) do

                nodes[k] = require("possessions.CChooseItemSprite").new(v, itemType)
                nodes[k]:setTouchListener(c_func(onTouchItem, v))

                local button = CSingleImageMenuItem:create("button_use.png")
                button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
                button:registerScriptTapHandler(c_func(onEquipButton, v, button))
                button:setScale(0.6)

                local _, bIsEquip = v:getStatus()
                if (bIsEquip) then
                    button:setEnabled(false)
                    button:selected()
                end

                local text = ui.newTTFLabel({
                    text = "装备",
                    x    = button:getContentSize().width / 2,
                    y    = button:getContentSize().height / 2,
                    align = ui.TEXT_ALIGN_CENTER,
                    size = 36
                })
                button:addChild(text)

                local menu = ui.newMenu({button})
                menu:setPosition(0, 0)
                nodes[k]:addChild(menu)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = CFuncHelper:getRelativeX(9),
                y =CFuncHelper:getRelativeY(9),
                width = CFuncHelper:getRelativeX(23),
                height = CFuncHelper:getRelativeY(27),
                pageSize = 4,
                rowSize = 1,
                nodes = nodes,
                vertical = true
            })
            scrollLayer:setPosition(0, 0)
            self:addChild(scrollLayer)
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

    local function initButton()
        local okButton = CSingleImageMenuItem:create("button_use.png")
        okButton:setPosition(bg:getContentSize().width * (1 / 4), bg:getContentSize().height * (1 / 10))
        okButton:registerScriptTapHandler(function()

            if (preButton) then
                if itemType == ItemType_KungFu then
                    data:addKungFu(preButton.data:getId(), index)
                elseif itemType == ItemType_Equip then
                    data:addEquipment(preButton.data, index)
                    preButton.data:setOwner(data)
                end
            end
            self:removeFromParentAndCleanup(true)
            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["UPDATA_MEMBERS_SCENE"],
                info = itemType
            })
        end)
        local okLabel = ui.newTTFLabel({
            text = require("data.GameText").getText("confirm"),
            x    = okButton:getContentSize().width / 2,
            y    = okButton:getContentSize().height / 2,
            align = ui.TEXT_ALIGN_CENTER
        })
        okButton:addChild(okLabel)

        local cancelButton = CSingleImageMenuItem:create("button_use.png")
        cancelButton:setPosition(bg:getContentSize().width * (3 / 4), bg:getContentSize().height * (1 / 10))
        cancelButton:registerScriptTapHandler(function()

            self:removeFromParentAndCleanup(true)
            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["UPDATA_MEMBERS_SCENE"],
                info = itemType
            })
        end)
        local cancelLabel = ui.newTTFLabel({
            text = require("data.GameText").getText("concel"),
            x    = cancelButton:getContentSize().width / 2,
            y    = cancelButton:getContentSize().height / 2,
            align = ui.TEXT_ALIGN_CENTER
        })
        cancelButton:addChild(cancelLabel)

        local menu = ui.newMenu({okButton, cancelButton})
        menu:setPosition(0, 0)
        bg:addChild(menu)
    end

    initItem()
    initButton()
end



function CChooseLayer:ctor(data, index, itemType)

    self:init(data,index, itemType)
end

return CChooseLayer

