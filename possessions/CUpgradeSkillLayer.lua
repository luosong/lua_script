--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-7
-- Time: 下午1:40
-- To change this template use File | Settings | File Templates.
--

local CUpgradeSkillLayer = class("CUpgradeSkillLayer", function()
    return display.newLayer()
end)

function CUpgradeSkillLayer:init(itemData)

    self:setTouchEnabled(true)
    self:registerScriptTouchHandler(function(eventType, x, y)
        if eventType == "began" then
            return true
        end
    end, false, -128, true)

    local bg = ResourceMgr:getUISprite("dazao_bg")
    bg:setPosition(display.width / 2, display.height / 2)
    self.node:addChild(bg)

    local layerLabel = ui.newTTFLabel({
        text = itemData:getName(),
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (7.3 / 8),
        color = ccc3(0, 0, 0)
    })
    bg:addChild(layerLabel)

    for i = 1, itemData:getProperty() do
        local starSprite =  ResourceMgr:getUISprite("icon_star")
        starSprite:setPosition(bg:getContentSize().width / 2 - starSprite:getContentSize().width * (itemData:getProperty() / 2) +
                starSprite:getContentSize().width * (i - 1) + starSprite:getContentSize().width / 2,  bg:getContentSize().height * (6.8 / 8))
        bg:addChild(starSprite)
    end

    local icon = ResourceMgr:getSprite(itemData:getAnimId())
    icon:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height * (3 / 5))
    bg:addChild(icon)

    local costMoney = GameFormula.GetUpGradeEquipSilver( GAME_BLACKSMITH_COST.LEVEL_1, itemData:getProperty(), itemData:getLevel() )
    local costLabel = ui.newTTFLabel({
        text = "银子" .. costMoney,
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (1.5 / 8),
        color = ccc3(0, 255, 0)
    })
    bg:addChild(costLabel)

    local function initButton()
        local okButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            x =  bg:getContentSize().width * (1 / 4),
            y = bg:getContentSize().height * (1 / 10)
        })
        okButton:registerScriptTapHandler(function()
            printf("-----------------升级-----------------------")
        end)

        local okLabel = ResourceMgr:getUISprite("font_sj")
        okLabel:setPosition(okButton:getContentSize().width / 2, okButton:getContentSize().height / 2)
        okButton:addChild(okLabel)

        local cancelButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            x =  bg:getContentSize().width * (3 / 4),
            y = bg:getContentSize().height * (1 / 10)
        })
        cancelButton:registerScriptTapHandler(function()
            self:removeAllChildrenWithCleanup(true)
            self:removeFromParentAndCleanup(true)

            printf("------------------- 返回 ------------------")

        end)
        local cancelLabel = ResourceMgr:getUISprite("font_back")
        cancelLabel:setPosition(cancelButton:getContentSize().width / 2, cancelButton:getContentSize().height / 2 )
        cancelButton:addChild(cancelLabel)

        local menu = ui.newMenu({okButton, cancelButton})
        menu:setPosition(0, 0)
        bg:addChild(menu)
    end
    initButton()

end

function CUpgradeSkillLayer:ctor(itemData)

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)
    self:init(itemData)
end

return CUpgradeSkillLayer

