--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-22
-- Time: 上午11:34
-- To change this template use File | Settings | File Templates.
--
--选择对手
local enemyPlayer = {}
local function addEnemy(enemy)
   enemyPlayer[#enemyPlayer + 1] = enemy
end



for i = 1, 10 do
    addEnemy(require("game_model.COtherPlayer").new({
        name    = "张三" .. i,
        ranking = 1000,
        level   = 10,
        majorHeros = {
            require("game_model.HeroData").new(BaseData_heros[2]),
            require("game_model.HeroData").new(BaseData_heros[50]),
            require("game_model.HeroData").new(BaseData_heros[20]),
            require("game_model.HeroData").new(BaseData_heros[5]),
            require("game_model.HeroData").new(BaseData_heros[6]),
            require("game_model.HeroData").new(BaseData_heros[7])
        }
    }))
end

local CChallengeScene = class("CChallengeScene", function()
    return display.newScene("CChallengeScene")
end)

function CChallengeScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    local bg = CCScale9Sprite:createWithSpriteFrameName("board21.png")
    bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(bg)

    local nodes = {}
    local function onFightButton()

    end

    for k, v in ipairs(enemyPlayer) do
        nodes[k] = require("ui_common.CScrollCell").new(require("competition.fight.CChallengeItemSprite").new(v))
        nodes[k]:setTouchListener(onFightButton)
    end

    local scrollLayer = require("ui_common.CScrollLayer").new({
        x = display.width * (5.6 / 40),
        y = display.height * (2 / 40),
        width = display.width * (32.5 / 40),
        height = display.height * (32 / 40),
        pageSize = 4,
        rowSize = 1,
        nodes = nodes,
        vertical = true
    })
    scrollLayer:setPosition(0, 0)
    self.node:addChild(scrollLayer)

    self:registerScriptHandler(function(action)
        if action == "exit" then
            bg:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)

end


function CChallengeScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CChallengeScene