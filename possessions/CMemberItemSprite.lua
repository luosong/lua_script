--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-19
-- Time: 上午10:09
-- To change this template use File | Settings | File Templates.
--

local ItemType_MemberLayer      = 1
local ItemType_ChooseMajorLayer = 2

local CMemberItemSprite = class("CMemberItemSprite", function()
    local sprite = CCScale9Sprite:create("bartile.png")
    sprite:setPreferredSize(CCSizeMake(display.width * (28 / 40), display.height * (8 / 40)))
    return require("ui_common.CScrollCell").new(sprite)
end)

function CMemberItemSprite:ctor(heroData, itemType, index)
    local iconSprite = require("game_object.CHeroIconSprite").new(heroData)
    iconSprite:setPosition(-self:getContentSize().width * (12 / 32), 0)
    self:addChild(iconSprite)

    local nameLabel = ui.newTTFLabel({
        text = heroData:getName(),
        x = -self:getContentSize().width * (8 / 32),
        y = self:getContentSize().height * (1 / 4.5),
        color = ccc3(0, 0, 255),
        size = 28
    })
    self:addChild(nameLabel)

    local stateLabel = ui.newTTFLabel({
        text = heroData:getState(),
        x = 0,
        y = self:getContentSize().height * (1 / 4.5),
        color = ccc3(0, 0, 255),
        size = 16
    })
    self:addChild(stateLabel)

    for i = 1, heroData:getProperty() do
        local starSprite = ResourceMgr:getUISprite("icon_star2")
        starSprite:setAnchorPoint(CCPointMake(1, 0.5))
        starSprite:setPosition(i * (starSprite:getContentSize().width + 2) - self:getContentSize().width * (8 / 32),
            -self:getContentSize().height * (1 / 4.5))
        self:addChild(starSprite)
    end

    local levelLabel = ui.newTTFLabel({
        text = "级别:  " .. tostring(heroData:getLevel()),
        x = -self:getContentSize().width * (8 / 32),
        y = 0,
        color = ccc3(0, 0, 255),
        size = 16
    })
    self:addChild(levelLabel)

    if ItemType_MemberLayer == itemType then
        local function onTrainButton()
            printf("培养")
        end

        local trainButton = CSingleImageMenuItem:create("ui/button.png")
        trainButton:registerScriptTapHandler(onTrainButton)
        trainButton:setPosition(self:getContentSize().width * (5 / 32), 0)
        local trainButtonLabel = ui.newTTFLabel({
            text = "培养",
            size = 22,
            align = ui.TEXT_ALIGN_CENTER,
            x = trainButton:getContentSize().width / 2,
            y = trainButton:getContentSize().height / 2
        })
        trainButton:addChild(trainButtonLabel)


        local function onExchange()
            printf("传功")
        end
        local exchangeButton = CSingleImageMenuItem:create("ui/button.png")
        exchangeButton:setPosition(self:getContentSize().width * (11 / 32), 0)
        exchangeButton:registerScriptTapHandler(onExchange)
        local exchangeButtonLabel = ui.newTTFLabel({
            text = "传功",
            size = 22,
            align = ui.TEXT_ALIGN_CENTER,
            x = exchangeButton:getContentSize().width / 2,
            y = exchangeButton:getContentSize().height / 2
        })
        exchangeButton:addChild(exchangeButtonLabel)

        local menu = ui.newMenu({trainButton, exchangeButton})
        self:addChild(menu)
    elseif ItemType_ChooseMajorLayer == itemType then
        
        -- 上阵按钮CB
        local function onJoinMajor()
            game.Player:addMajorHero(heroData:getId(), index)
            game.KZNetWork:UploadMajorHeros()
        end


        local joinMajorButton = CSingleImageMenuItem:create("ui/button.png")
        joinMajorButton:setPosition(self:getContentSize().width * (11 / 32), 0)
        joinMajorButton:registerScriptTapHandler(onJoinMajor)
        local _, bIsJoin = heroData:getState()
        local stateText = "上阵"
        if (bIsJoin) then
            stateText = heroData:getState()
            joinMajorButton:setEnabled(false)
        end
        local onJoinMajorButtonLabel = ui.newTTFLabel({
            text = stateText,
            size = 22,
            align = ui.TEXT_ALIGN_CENTER,
            x = joinMajorButton:getContentSize().width / 2,
            y = joinMajorButton:getContentSize().height / 2
        })
        joinMajorButton:addChild(onJoinMajorButtonLabel)

        local menu = ui.newMenu({joinMajorButton})
        self:addChild(menu)
    end
end

return CMemberItemSprite