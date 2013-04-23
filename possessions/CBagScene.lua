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
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))

    self.bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(self.bg)

    local nodes = {}
    local function initItem()
        local bag = game.Player:getPackage()
        if #bag >= 1 then

            local function onUseButton(bagData)
                 printf("------------------------ 包裹-------")
            end

            local function c_func(f, ...)
                local args = {... }
                return function()
                    f(unpack(args))
                end
            end

            for k, v in ipairs(bag) do

                nodes[k] = require("possessions.CItemSprite").new(v, 1)

                local button = ui.newImageMenuItem({
                    image = "#button10.png",
                    imageSelected = "#button11.png",
                    listener = c_func(onUseButton, v),
                    x =  nodes[k]:getContentSize().width * (12 / 32),
                    y = 0
                })

                local menu = ui.newMenu({button})
                menu:setPosition(0, 0)
                nodes[k]:addChild(menu)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (4 / 40),
                y = display.height * (0.6 / 40),
                width = display.width * (35.8 / 40),
                height = display.height * (35 / 40),
                pageSize = 3,
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
