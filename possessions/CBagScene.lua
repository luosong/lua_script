--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午10:02
-- To change this template use File | Settings | File Templates.
--
local CBagScene = class("CBagScene", function()
    return display.newScene("CBagScene")
end)

function CBagScene:init()
    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame("board19"))
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))

    self.bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(self.bg)

    local nodes = {}
    local function initItem()
        local bag = game.Player:getPackage()
        if #bag >= 1 then

            local function onTouchItem()

            end

            local function onEnhanceButton(tag, sender)
                 printf("------------------------ 包裹-------")
            end

            for k, v in ipairs(bag) do

                nodes[k] = require("possessions.CItemSprite").new(v, 1)
                nodes[k]:setTouchListener(onTouchItem)

                local button = CSingleImageMenuItem:create("button_use.png")
                button.data = v
                button:setPosition(nodes[k]:getContentSize().width * (10 / 32), -nodes[k]:getContentSize().height * (1.2 / 4.5))
                button:registerScriptTapHandler(onEnhanceButton)

                local menu = ui.newMenu({button})
                menu:setPosition(0, 0)
                nodes[k]:addChild(menu)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (4 / 40),
                y = display.height * (0.6 / 40),
                width = display.width * (35.8 / 40),
                height = display.height * (35 / 40),
                pageSize = 2,
                rowSize = 1,
                nodes = nodes,
                vertical = true
            })
            scrollLayer:setPosition(0, 0)
            self.node:addChild(scrollLayer)
        else
            local label = ui.newTTFLabel({
                text = "穷的什么都没有",
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

function CBagScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

end

return CBagScene
