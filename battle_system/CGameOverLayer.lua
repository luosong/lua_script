--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-24
-- Time: 上午11:15
-- To change this template use File | Settings | File Templates.
--

local CGameOverLayer = class("CGameOverLayer", function()
    return display.newLayer()
end)

local imageMap = {
    bg = {"win_bg", "lose_bg"},
    infoBg = {"win_title_bg", "lose_title_bg" },
    label  = {"font_win", "font_lose"},
    iconBg = {"win_hero_bg", "lose_hero_bg"}
}

function CGameOverLayer:init(data, battleType)
    local flag = 1
    if data.bWin then
       flag = 1
    else
        flag = 2
    end
    local bg = ResourceMgr:getUISprite(imageMap["bg"][flag])
    -- bg:setAnchorPoint(CCPointMake(0, 0))
    bg:setPosition(display.width/2, display.height/2)
    self:addChild(bg)

    ----胜利描述背景
    local infoSprite = ResourceMgr:getUISprite(imageMap["infoBg"][flag])
    infoSprite:setPosition(CFuncHelper:getRelativeX(31), CFuncHelper:getRelativeY(19))
    bg:addChild(infoSprite, 1)

    ----胜利文字
    local labelSprite = ResourceMgr:getUISprite(imageMap["label"][flag])
    labelSprite:setPosition(infoSprite:getContentSize().width / 2, infoSprite:getContentSize().height * (4 / 5))
    infoSprite:addChild(labelSprite)

    local function initButton()
        ---------重播按钮
        local repeatButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            listener = function()
                self:dispatchEvent({
                    name = GlobalVariable["NotificationTag"]["REPEAT_FIGHTING_ANIMATION"],
                    info = nil
                })
                self:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["REPEAT_FIGHTING_ANIMATION"])
                self:removeAllChildrenWithCleanup(true)
                self:removeFromParentAndCleanup(true)
            end,
            x =  infoSprite:getContentSize().width * (1 / 4),
            y = 0
        })
        local repeatLable = ResourceMgr:getUISprite("font_replay")
        repeatLable:setPosition(repeatButton:getContentSize().width / 2, repeatButton:getContentSize().height / 2)
        repeatButton:addChild(repeatLable)

        -----------确定按钮
        local okButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            listener = function()
                --CCDirector:sharedDirector():popScene()
                if battleType == BattleType.Adventure_map then
                    display.replaceScene(require("adventure.CAdventureScene").new())
                else
                    display.replaceScene(require("competition.fight.CChallengeScene").new())
                end
            end,
            x =  infoSprite:getContentSize().width * (3 / 4),
            y = 0
        })
        local okLabel = ResourceMgr:getUISprite("font_enter")
        okLabel:setPosition(okButton:getContentSize().width / 2, okButton:getContentSize().height / 2)
        okButton:addChild(okLabel)

        local menu = ui.newMenu({repeatButton, okButton})
        infoSprite:addChild(menu)
    end



    ----------------创建人物头像
    local function createItem(v, level)
        local iconSprite = require("ui_object.CHeroIconSprite").new(v)
        local node = ResourceMgr:getUISprite(imageMap["iconBg"][flag])
        iconSprite:setPosition(0, node:getContentSize().height / 2)
        node:addChild(iconSprite)

        local nameLabel = ui.newBMFontLabel({
            text = v:getName(),
            align = ui.TEXT_ALIGN_LEFT,
            x    = iconSprite:getContentSize().width/2,
            y    = node:getContentSize().height * (5 / 6),
            -- size = 22,
            font = GAME_FONT.font_youyuan,
            -- color = ccc3(0, 0, 0)
        })
        nameLabel:setColor(display.COLOR_BLACK)
        node:addChild(nameLabel)

        local expSprite = ResourceMgr:getUISprite("sicon18")
        expSprite:setAnchorPoint(CCPointMake(0, 0.5))
        expSprite:setPosition(iconSprite:getContentSize().width / 2, node:getContentSize().height / 2)
        node:addChild(expSprite)


        local expLabel = ui.newTTFLabel({
            text = "+" .. tostring(data.heroExp),
            x    = iconSprite:getContentSize().width / 2 + expSprite:getContentSize().width * 1.2,
            y    = node:getContentSize().height / 2,
            size = 26,
        })
        node:addChild(expLabel)

        local lvText = "Lv" .. tostring(level)
        local lvColor = ccc3(0, 0, 0)
        if true and level < v:getLevel() then
            lvColor = ccc3(255, 255, 255)
            local arrawSprite = ResourceMgr:getUISprite("arrow")
            arrawSprite:setPosition(iconSprite:getContentSize().width, node:getContentSize().height * (1 / 6))
            node:addChild(arrawSprite)

            local realLvLabel = ui.newTTFLabelWithShadow({
                text = "Lv " .. tostring(v:getLevel()),
                x    = iconSprite:getContentSize().width + arrawSprite:getContentSize().width / 2,
                y    = node:getContentSize().height * (1 / 6),
                size = 16,
                color = lvColor
            })
            node:addChild(realLvLabel)
        end
        local lvLable = ui.newTTFLabelWithShadow({
            text = "Lv " .. tostring(level),
            x    = iconSprite:getContentSize().width / 2,
            y    = node:getContentSize().height * (1 / 6),
            size = 16,
            color = lvColor
        })
        node:addChild(lvLable)
        return node
    end

    local function initHeroIcon()
        local form = game.Player:getCurrentFormation()

        local nodes = {}
        for k, v in ipairs(data.ourArmyData) do
            nodes[k] = createItem(v:getHeroData(), v:getLevel())
        end

        local iconNodes = require("ui_common.CNodeLayout").new({
            nodes = nodes,
            width = CFuncHelper:getRelativeX(25),
            height = CFuncHelper:getRelativeY(25),
            rowSize = 2
        })
        iconNodes:setPosition(CFuncHelper:getRelativeX(2), CFuncHelper:getRelativeY(8))
        bg:addChild(iconNodes)
    end

    local function showReward()


        if (data.reward) then
            ----奖励物品背景
            local winSpriteBg = ResourceMgr:getUISprite("itembg")
            winSpriteBg:setPosition(winSpriteBg:getContentSize().width / 2, winSpriteBg:getContentSize().height / 2)
            bg:addChild(winSpriteBg)

            local winIcon = nil
            if data.reward.ItemType == ItemType.EQUIPMENT then
                winIcon = require("ui_object.CEquipIconSprite").new(data.reward.ItemData)
            elseif data.reward.ItemType == ItemType.SKILL then
                winIcon = require("ui_object.CSkillIconSprite").new(data.reward.ItemData)
            end


            winIcon:setScale(0.8)
            winIcon:setPosition(winIcon:getContentSize().width * 1.3, winIcon:getContentSize().height * 0.4)
            winSpriteBg:addChild(winIcon)

            local nameLabel = ui.newTTFLabel({
                text = data.reward.ItemData:getName(),
                x    = winIcon:getContentSize().width * 1.8,
                y    = winSpriteBg:getContentSize().height / 2,
                size = 28
            })
            winSpriteBg:addChild(nameLabel)

            for i = 1, data.reward.ItemData:getProperty() do

                local starSprite =  ResourceMgr:getUISprite("icon_star")
                starSprite:setPosition(winIcon:getContentSize().width * 1.8 + starSprite:getContentSize().width * i - starSprite:getContentSize().width / 2,
                    winSpriteBg:getContentSize().height * (0.7 / 3))
                winSpriteBg:addChild(starSprite)
            end
        end


    end

    if (data.bWin) then

        showReward()
        ---------- 星星
        for i = 1, 3 do
            local starSprite = ResourceMgr:getUISprite("icon_star")
            starSprite:setPosition(infoSprite:getContentSize().width * (2.9 / 4),
                infoSprite:getContentSize().height - starSprite:getContentSize().height * i + starSprite:getContentSize().height / 2)
            infoSprite:addChild(starSprite)
        end
        local stateLabel = ui.newTTFLabel({
            text = "本次战斗8回合",
            x    = infoSprite:getContentSize().width / 3,
            y    = infoSprite:getContentSize().height * (6 / 12),
            size = 22,
            color = ccc3(0, 0, 0)
        })
        infoSprite:addChild(stateLabel)

        local expLabel = ui.newTTFLabel({
            text = "镖局经验： +" .. tostring(data.gameExp),
            x    = infoSprite:getContentSize().width / 3,
            y    = infoSprite:getContentSize().height * (5 / 12),
            size = 22,
            color = ccc3(0, 0, 0)
        })
        infoSprite:addChild(expLabel)

        local sliverSprite = ResourceMgr:getUISprite("icon_silver")
        sliverSprite:setPosition(infoSprite:getContentSize().width / 3 + sliverSprite:getContentSize().width / 2,
            infoSprite:getContentSize().height * (4 / 12))
        infoSprite:addChild(sliverSprite)

        local moneyLabel = ui.newTTFLabel({
            text = "  +" .. tostring(data.gold),
            x    = infoSprite:getContentSize().width / 3 + sliverSprite:getContentSize().width,
            y    = infoSprite:getContentSize().height * (4 / 12),
            size = 28,
            color = ccc3(0, 0, 0)
        })
        infoSprite:addChild(moneyLabel)
    end

    initButton()
    initHeroIcon()

--    local gridLine = CGridLineLayer:create()
--    gridLine:setPosition(0, 0)
--    self:addChild(gridLine)

end

function CGameOverLayer:ctor(data, battleType)
    self:init(data, battleType)
end

return CGameOverLayer