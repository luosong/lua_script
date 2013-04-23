--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-20
-- Time: 下午2:46
-- To change this template use File | Settings | File Templates.
--

local CCompetitionScene = class("CCompetitionScene", function()
    return display.newScene("CCompetitionScene")
end)

function CCompetitionScene:init()
    local layer = display.newLayer()
    layer:setPosition(0, 0)
    self:addChild(layer)

    local commonButton = require("CBorderLayer").new()
    commonButton:setPosition(0, 0)
    layer:addChild(commonButton)

    local bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame(GAME_RES.HUAWEN_BG))
    bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (35 / 40)))
    bg:setPosition(game.cx, display.height * (17.8 / 40))
    layer:addChild(bg)

    local testBrainsButton = ui.newTTFLabelMenuItem({
        text = "文斗",
        size = 48,
        color = ccc3(0, 255, 0),
        listener = function()
            display.replaceScene(require("competition.answer_system.CAnswerScene").new())
        end
    })
    testBrainsButton:setPosition(bg:getContentSize().width * (1 / 4), bg:getContentSize().height / 2)

    local testMightsButton = ui.newTTFLabelMenuItem({
        text = "比武",
        size = 48,
        color = ccc3(0, 255, 0),
        listener = function()
            display.replaceScene(require("competition.fight.CChallengeScene").new())
        end
    })
    testMightsButton:setPosition(bg:getContentSize().width * (3 / 4), bg:getContentSize().height / 2)

    local menu = ui.newMenu({testBrainsButton, testMightsButton})
    menu:setPosition(0, 0)
    bg:addChild(menu)

end

function CCompetitionScene:ctor()
    self:init()
end

return CCompetitionScene

