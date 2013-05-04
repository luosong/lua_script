--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-7
-- Time: 下午1:40
-- To change this template use File | Settings | File Templates.
--

local CEnhanceLayer = class("CChooseLayer", function()
    return display.newLayer()
    --return CCLayerColor:create(ccc4(100, 100, 100, 155), display.width, display.height)
end)

function CEnhanceLayer:init(itemData)

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


    local dazaoSprite_A = ResourceMgr:getUISprite("icon_dazao1")
    dazaoSprite_A:setPosition(bg:getContentSize().width / 2 - dazaoSprite_A:getContentSize().width * 1.5,  bg:getContentSize().height / 3.5)
    bg:addChild(dazaoSprite_A)
    local dazaoSprite_B = ResourceMgr:getUISprite("icon_dazao2")
    dazaoSprite_B:setPosition(bg:getContentSize().width / 2 - dazaoSprite_A:getContentSize().width * 0.5,  bg:getContentSize().height / 3.5)
    bg:addChild(dazaoSprite_B)
    local dazaoSprite_C = ResourceMgr:getUISprite("icon_dazao3")
    dazaoSprite_C:setPosition(bg:getContentSize().width / 2 + dazaoSprite_A:getContentSize().width * 0.5,  bg:getContentSize().height / 3.5)
    bg:addChild(dazaoSprite_C)
    local dazaoSprite_D = ResourceMgr:getUISprite("icon_dazao4")
    dazaoSprite_D:setPosition(bg:getContentSize().width / 2 + dazaoSprite_A:getContentSize().width * 1.5,  bg:getContentSize().height / 3.5)
    bg:addChild(dazaoSprite_D)

    local selectSprite = ResourceMgr:getUISprite("dazao_xuanze")
    selectSprite:setPosition(dazaoSprite_A:getPosition())
    bg:addChild(selectSprite)

    local icon = ResourceMgr:getSprite(itemData:getAnimId())
    icon:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height * (3 / 5))
    bg:addChild(icon)

    local costMoney = GameFormula.GetUpGradeEquipSilver( 500, itemData:getProperty(), itemData:getLevel() )
    local costLabel = ui.newTTFLabel({
        text = "打造需要银子: " .. costMoney,
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (1.5 / 8),
        color = ccc3(0, 0, 0)
    })
    bg:addChild(costLabel)

    local lvLabel = ui.newTTFLabel({
        text = "Lv" .. itemData:getLevel(),
        align = ui.TEXT_ALIGN_CENTER,
        x = bg:getContentSize().width / 2,
        y = bg:getContentSize().height * (1 / 8),
        color = ccc3(0, 0, 0)
    })
    bg:addChild(lvLabel)

    local function initButton()


        local scheduler = require("framework.client.scheduler")
        local schedulerHandler = nil
        local arrawSprite = nil
        local cancelButton = nil
        local okButton = nil

        local function getResult()

            okButton:setEnabled(true)
            okButton:unselected()
            cancelButton:setEnabled(true)
            cancelButton:unselected()
            scheduler.unscheduleGlobal(schedulerHandler)
            selectSprite:stopAllActions()
            local lvString = "Lv" .. tostring(itemData:getLevel())
            itemData:upgrade(2)
            lvLabel:setString(lvString .. "       Lv" .. tostring(itemData:getLevel()))
            costMoney = GameFormula.GetUpGradeEquipSilver( 500, itemData:getProperty(), itemData:getLevel() )
            costLabel:setString("打造需要银子: " .. costMoney)

            if (arrawSprite == nil) then
                arrawSprite = ResourceMgr:getUISprite("arrow")
                arrawSprite:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height * (1 / 8))
                bg:addChild(arrawSprite)
            end
        end


        okButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            x =  bg:getContentSize().width * (1 / 4),
            y = bg:getContentSize().height * (1 / 10)
        })

        local tm = {1.7, 1.8, 1.9, 2.0 }
        okButton:registerScriptTapHandler(function()
            okButton:setEnabled(false)
            okButton:selected()
            cancelButton:setEnabled(false)
            cancelButton:selected()

            schedulerHandler = scheduler.performWithDelayGlobal(getResult, tm[2])
            local action = transition.sequence({
                CCDelayTime:create(0.1),
                CCCallFunc:create(function()
                    selectSprite:setPosition(dazaoSprite_A:getPosition())
                end),
                CCDelayTime:create(0.1),
                CCCallFunc:create(function()
                    selectSprite:setPosition(dazaoSprite_B:getPosition())
                end),
                CCDelayTime:create(0.1),
                CCCallFunc:create(function()
                    selectSprite:setPosition(dazaoSprite_C:getPosition())
                end),
                CCDelayTime:create(0.1),
                CCCallFunc:create(function()
                    selectSprite:setPosition(dazaoSprite_D:getPosition())
                end),

            })
            selectSprite:runAction(CCRepeatForever:create(action))
        end)
        local okLabel = ResourceMgr:getUISprite("font_qhua")
        okLabel:setPosition(okButton:getContentSize().width / 2, okButton:getContentSize().height / 2)
        okButton:addChild(okLabel)

        cancelButton = ui.newImageMenuItem({
            image = "#button_small.png",
            imageSelected = "#button_small.png",
            x =  bg:getContentSize().width * (3 / 4),
            y = bg:getContentSize().height * (1 / 10)
        })
        cancelButton:registerScriptTapHandler(function()
            self:removeAllChildrenWithCleanup(true)
            self:removeFromParentAndCleanup(true)

            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["EQUIPMENT_ENHANCE_LAYER"],
                info = "Hello"
            })
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

function CEnhanceLayer:ctor(itemData, parent)

    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)
    self:init(itemData, parent)
end

return CEnhanceLayer

