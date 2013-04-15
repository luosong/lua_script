--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-20
-- Time: 下午4:00
-- To change this template use File | Settings | File Templates.
--

local CFriendsScene = class("CFriendsScene", function()
    return display.newScene("CFriendsScene")
end)

function CFriendsScene:init()

    local bg = display.newSprite("ui/bg01.png")
    bg:setAnchorPoint(CCPointMake(0, 0))
    bg:setPosition(0, 0)
    self.node:addChild(bg)

    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = display.newSprite("kongfu_bg.png")
    self.bg:setPosition(game.cx, self.bg:getContentSize().height / 2)
    self.node:addChild(self.bg)
    local nodes = {}

    local function initItem()

        local friends = game.Player:getFriends()
        if #friends >= 1 then

            local function onFriend()

            end

            local function onEnhanceButton(tag, sender)
                --printf("--------------Friends----------" .. sender.data:getName())
            end

            for k, v in ipairs(friends) do

                nodes[k] = require("possessions.CItemSprite").new(v, 2)
                nodes[k]:setTouchListener(onTouchItem)

                local button = CSingleImageMenuItem:create("button_use.png")
                button.data = v
                button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
                button:registerScriptTapHandler(onFriend)

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
                text = "江湖上行走，没有几个朋友哪行？",
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

function CFriendsScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CFriendsScene



