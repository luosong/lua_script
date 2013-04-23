--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-8
-- Time: 下午5:38
-- To change this template use File | Settings | File Templates.
--
local CSkillsMgr = class("CSkillsMgr", function()
    return CCLayerColor:create(ccc4(0, 0, 0, 255), display.width, display.height)
end)

function CSkillsMgr:getDelayTime()
    local delayTime = 0

    local a =  math.random(1,10)
    if a == 2 then
        delayTime = 3
        self:init(delayTime)
    end
    return delayTime
end

function CSkillsMgr:init(delayTime)
    local atkSprite = ResourceMgr:getSprite(self.attacker:getAnimId())
    if (self.bSelfIsAtk) then
        atkSprite:setPosition(display.width * (1 / 4), display.height / 2)
        atkSprite:setFlipX(true)
    else
        atkSprite:setPosition(display.width * (3 / 4), display.height / 2)
    end

    self:addChild(atkSprite)

    ----------------------------------------------------------------------------------------------

    local enemysNode = display.newNode()
    enemysNode:setPosition(0, 0)
    self:addChild(enemysNode)

    if (self.bSelfIsAtk ) then
        for k, v in ipairs(self.enemys) do
            if (v ~= 0) then
                local sprite = require("battle_system.CHeroSprite").new(v, "body")
                sprite:setPosition(self.pos[k])
                enemysNode:addChild(sprite)
                sprite:setScale(0.8)
            end
        end
    else

        for k, v in ipairs(self.enemys) do
            if v ~= 0 then
                local sprite = require("battle_system.CHeroSprite").new(v, "body")
                sprite:setPosition(self.pos[k])
                enemysNode:addChild(sprite)
                sprite:setScale(0.8)
                sprite:setFlipX(true)
            end
        end
    end

    local skill2 = require("skills_system.CHaMaGong").new()
    self:addChild(skill2)

--
--    local animation = display.newSprite("xianglong18/4.png")
--    animation:setPosition(0, display.height / 2)
--    self:addChild(animation)
--    animation:runAction(transition.sequence({
--        CCMoveTo:create(3.0, CCPointMake(display.width, display.height / 2)),
--        CCCallFunc:create(function()
--
--        end)
--    }))


    ----------------------------------------------------------------------------------------------
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

    require("framework.client.scheduler").performWithDelayGlobal(function()
        self:removeAllChildrenWithCleanup(true)
        self:removeFromParentAndCleanup(true)
    end, delayTime)
end

function CSkillsMgr:ctor(attacker, enemys, pos, bSelfIsAtk)

    self.attacker = attacker
    self.enemys = enemys
    self.pos = pos
    self.bSelfIsAtk =  bSelfIsAtk

end

return CSkillsMgr

