--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-22
-- Time: 上午11:34
-- To change this template use File | Settings | File Templates.
--
--选择对手
local CRivalSelectScene = class("CRivalSelectScene", function()
    return display.newScene("CRivalSelectScene")
end)

function CRivalSelectScene:init()
    local bg = require("CBaseLayer").new()
    bg:setPosition(0, 0)
    self.node:addChild(bg)

    local nodes = {}
    local function onFightButton()
--        printf("---------------------- CRivalSelectScene:init ---------------------")
--        display.replaceScene(require("battle_system.CBattleScene").new({1, 1}))
    end

    for i = 1, 3 do
        nodes[i] = require("ui_common.CScrollCell").new(display.newSprite("friend_info.png"))
        nodes[i]:setTouchListener(onFightButton)
    end

    local scrollLayer = require("ui_common.CScrollLayer").new({
        x = CFuncHelper:getRelativeX(5),
        y = CFuncHelper:getRelativeY(4),
        width =CFuncHelper:getRelativeX(35),
        height = CFuncHelper:getRelativeY(28),
        pageSize = 3,
        rowSize = 1,
        nodes = nodes,
        vertical = true
    })
    scrollLayer:setPosition(0, 0)
    self.node:addChild(scrollLayer)

    self:registerScriptHandler(function(action)
        if action == "exit" then
            printf("-------------CRivalSelectScene on Exit---------------")
            bg:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)

end


function CRivalSelectScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CRivalSelectScene