--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-22
-- Time: 下午6:50
-- To change this template use File | Settings | File Templates.
--

local CChallengeItemSprite = class("CSettingItemSprite", function()
    local sprite = CCScale9Sprite:create("bartile.png")
    sprite:setPreferredSize(CCSizeMake(display.width * (32 / 40), display.height * (7.8 / 40)))
    return require("ui_common.CScrollCell").new(sprite)
end)

function CChallengeItemSprite:ctor(data)
    local nameLabel = ui.newTTFLabel({
        text = data:getName(),
        x = -self:getContentSize().width * (1.2 / 3),
        y = 0,
        size = 32
    })
    self:addChild(nameLabel)

    local rankingLabel = ui.newTTFLabel({
        text = "排名  " .. tostring(data:getRanking()),
        x = -self:getContentSize().width * (1.2 / 3),
        y = - self:getContentSize().height * (1 / 3),
        size = 22
    })

    self:addChild(rankingLabel)

    local majorHeros = data:getMajorHeros()
    for k, v in ipairs(majorHeros) do
        if k > 3 then
            break
        end
        local sprite = require("ui_object.CHeroIconSprite").new(v)
        sprite:setPosition(sprite:getContentSize().width * k - self:getContentSize().width * (0.9 / 3), 0)
        self:addChild(sprite)
    end

    local function onChallenge(memData)
         printf("----------- " .. memData:getName())
    end

    local function c_func(f, ...)
        local args = {... }
        return function()
            f(unpack(args))
        end
    end

    local challengeButton = ui.newImageMenuItem({
        image = "#button10.png",
        imageSelected = "#button11.png",
        listener = c_func(onChallenge, data),
        x =  self:getContentSize().width * (1.15 / 3),
        y = 0
    })
    local menu = ui.newMenu({challengeButton})
    self:addChild(menu)

end

return CChallengeItemSprite