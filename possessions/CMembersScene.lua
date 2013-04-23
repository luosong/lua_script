--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-19
-- Time: 上午9:48
-- To change this template use File | Settings | File Templates.
--

local CMembersScene = class("CMembersScene", function()
    return display.newScene("CMembersScene")
end)

function CMembersScene:ctor()
    local node = display.newNode()
    node:setPosition(0, 0)
    self:addChild(node)

    local borderLayer = require("CBorderLayer").new(true, "队员")
    borderLayer:setPosition(0, 0)
    node:addChild(borderLayer)

    local bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    bg:setPosition(game.cx, display.height * (18 / 40))
    node:addChild(bg)

    local function initItem()
        local heros = game.Player:getHeros()
        local nodes = {}
        for k, v in ipairs(heros) do
            nodes[k] = require("possessions.CMemberItemSprite").new(v, 1)
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
        node:addChild(scrollLayer)
    end
    initItem()

end

return CMembersScene