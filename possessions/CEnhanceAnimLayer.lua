--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-7
-- Time: 下午5:34
-- To change this template use File | Settings | File Templates.
--

local CEnhanceAnimLayer = class("CChooseLayer", function()
    return CCLayerColor:create(ccc4(0, 0, 0, 255), display.width, display.height)
end)

function CEnhanceAnimLayer:init()
    local bg = display.newSprite("luzi.png")
    bg:setPosition(display.width / 2, display.height / 2)
    self:addChild(bg)

    local sprite1 = display.newSprite("luzi_7.png")
    sprite1:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height / 2)
    bg:addChild(sprite1)
    local a1 = CCRotateBy:create(1, 360);
    sprite1:runAction(a1)

    local sprite2 = display.newSprite("luzi_2.png")
    sprite2:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height / 2)
    sprite2:setScale(0.2)
    bg:addChild(sprite2)
    local a2 = CCScaleTo:create(1.0, 1.0)
    sprite2:runAction(a2)

    local sprite3_1 = display.newSprite("luzi_3.png")
    sprite3_1:setPosition(display.width / 2, display.height)
    self:addChild(sprite3_1)
    transition.moveTo(sprite3_1, {time = 1.0, x = display.width / 2, y = display.height / 2})

    local sprite3_2 = display.newSprite("luzi_4.png")
    sprite3_2:setFlipX(true)
    sprite3_2:setRotation(-45)
    sprite3_2:setPosition(0, 0)
    self:addChild(sprite3_2)
    transition.moveTo(sprite3_2, {time = 1.0, x = display.width / 2, y = display.height / 2})

    local sprite3_3 = display.newSprite("luzi_6.png")
    sprite3_3:setPosition(display.width, 0)
    sprite3_3:setRotation(45)
    self:addChild(sprite3_3)
    transition.moveTo(sprite3_3, {time = 1.0, x = display.width / 2, y = display.height / 2})

    local equipSprite = display.newSprite("biyudi.png")
    equipSprite:setScale(0.1)
    equipSprite:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height / 2)
    bg:addChild(equipSprite)
    equipSprite:setVisible(false)

    local a2 = CCDelayTime:create(1)
    local action = transition.sequence({
        CCDelayTime:create(0.7),
        CCCallFunc:create(function()
            equipSprite:setVisible(true)
        end),
        CCScaleTo:create(0.3, 1),   -- moving up
        CCDelayTime:create(0.2),
        CCCallFunc:create(function()
            self:removeAllChildrenWithCleanup(true)

            local luckSprite = display.newSprite("luck.png")
            luckSprite:setPosition(display.width / 2, display.height / 2)
            self:addChild(luckSprite)
            luckSprite:setScale(0.5)
            luckSprite:runAction(transition.sequence({
                CCScaleTo:create(0.2, 1.0),
                CCDelayTime:create(0.2),
                CCCallFunc:create(function()
                    self:removeAllChildrenWithCleanup(true)
                    self:removeFromParentAndCleanup(true)
                end)
                }))

        end)
    })

    equipSprite:runAction(action)


    local cancelButton = CSingleImageMenuItem:create("button_use.png")
    cancelButton:setPosition(display.width * (3 / 4), display.height * (1 / 10))
    cancelButton:registerScriptTapHandler(function()

        self:removeAllChildrenWithCleanup(true)
        self:removeFromParentAndCleanup(true)
    end)
    local cancelLabel = ui.newTTFLabel({
        text = require("data.GameText").getText("concel"),
        x    = cancelButton:getContentSize().width / 2,
        y    = cancelButton:getContentSize().height / 2,
        align = ui.TEXT_ALIGN_CENTER
    })
    cancelButton:addChild(cancelLabel)

    local menu = ui.newMenu({cancelButton})
    menu:setPosition(0, 0)
    self:addChild(menu)


--
--    local scheduler = require("framework.client.scheduler")
--    self.animEndSchedule = scheduler.scheduleGlobal(
--        function(dt)
--            scheduler.unscheduleGlobal(self.animEndSchedule)
--            self:removeAllChildrenWithCleanup(true)
--            --self:removeFromParentAndCleanup(true)
--            printf("--------------------------------------------")
--        end,
--        1,
--        false)

end

function CEnhanceAnimLayer:ctor()
   self:init()
end

return CEnhanceAnimLayer

