--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-7
-- Time: 下午1:40
-- To change this template use File | Settings | File Templates.
--

local CEnhanceLayer = class("CChooseLayer", function()
    return display.newLayer()
    --return CCLayerColor:create(ccc4(100, 100, 100, 155), display.width, display.height)
end)

function CEnhanceLayer:init(itemData)

    self:setTouchEnabled(true)
    self:registerScriptTouchHandler(function(eventType, x, y)
        if eventType == "began" then
            return true
        end
    end, false, -128, true)

    local bg = display.newSprite("item_bg.png")
    bg:setPosition(display.width / 2, display.height / 2)
    self.node:addChild(bg)

    local layerLabel = ui.newTTFLabel({
        text = "装备强化",
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (7 / 8),
        color = ccc3(0, 255, 0)
    })
    bg:addChild(layerLabel)

    local sprite = display.newSprite("bg1.png")
    sprite:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height / 2)
    bg:addChild(sprite)

    local icon = ResourceMgr:getIconSprite(itemData:getIcon())
    icon:setPosition(sprite:getContentSize().width / 2, sprite:getContentSize().height / 2)
    sprite:addChild(icon)

    local costLabel = ui.newTTFLabel({
        text = "银子100两",
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (1.5 / 8),
        color = ccc3(0, 255, 0)
    })
    bg:addChild(costLabel)

    local function initButton()
        local okButton = CSingleImageMenuItem:create("button.png")
        okButton:setPosition(bg:getContentSize().width * (1 / 4), bg:getContentSize().height * (1 / 10))
        okButton:registerScriptTapHandler(function()
            local layer = require("possessions.CEnhanceAnimLayer").new()
            layer:setPosition(0, 0)

            self:getParent():addChild(layer)


        end)
        local okLabel = ui.newTTFLabel({
            text = "强化",
            x    = okButton:getContentSize().width / 2,
            y    = okButton:getContentSize().height / 2,
            align = ui.TEXT_ALIGN_CENTER
        })
        okButton:addChild(okLabel)

        local cancelButton = CSingleImageMenuItem:create("button.png")
        cancelButton:setPosition(bg:getContentSize().width * (3 / 4), bg:getContentSize().height * (1 / 10))
        cancelButton:registerScriptTapHandler(function()
            self:removeAllChildrenWithCleanup(true)
            self:removeFromParentAndCleanup(true)

            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["EQUIPMENT_ENHANCE_LAYER"],
                info = "Hello"
            })
        end)
        local cancelLabel = ui.newTTFLabel({
            text = "返回",
            x    = cancelButton:getContentSize().width / 2,
            y    = cancelButton:getContentSize().height / 2,
            align = ui.TEXT_ALIGN_CENTER
        })
        cancelButton:addChild(cancelLabel)

        local menu = ui.newMenu({okButton, cancelButton})
        menu:setPosition(0, 0)
        bg:addChild(menu)
    end
    initButton()

end

function CEnhanceLayer:ctor(itemData, parent)

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)
    self:init(itemData, parent)
end

return CEnhanceLayer

