--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-8
-- Time: 上午10:27
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-7
-- Time: 下午1:40
-- To change this template use File | Settings | File Templates.
--

local CItemInfoLayer = class("CItemInfoLayer", function()
    return display.newLayer()
    --return CCLayerColor:create(ccc4(100, 100, 100, 155), display.width, display.height)
end)

function CItemInfoLayer:init(itemData)

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
        text = "装备信息",
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

    local function initButton()
        local okButton = CSingleImageMenuItem:create("button.png")
        okButton:setPosition(bg:getContentSize().width * (1 / 4), bg:getContentSize().height * (1 / 10))
        okButton:registerScriptTapHandler(function()
            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["EQUIPMENT_DOUBLE_DETAIL"],
                info = "Hello"
            })

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
                name = GlobalVariable["NotificationTag"]["EQUIPMENT_DETAIL_LAYER"],
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

function CItemInfoLayer:getData()
     return self.itemData
end

function CItemInfoLayer:ctor(itemData)
    self.itemData = itemData
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)
    self:init(itemData)
end

return CItemInfoLayer

