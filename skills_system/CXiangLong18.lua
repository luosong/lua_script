--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-8
-- Time: 下午2:09
-- To change this template use File | Settings | File Templates.
--

local CXiangLong18 = class("CXiangLong18", function()
    return CCLayerColor:create(ccc4(0, 0, 0, 255), display.width, display.height)
end)



function CXiangLong18:init(heroData, attacker, enemys, pos)


    local atkSprite = ResourceMgr:getSprite(attacker:getAnimId())
    atkSprite:setPosition(display.width * (1 / 4), display.height / 2)
    atkSprite:setFlipX(true)
    self:addChild(atkSprite)

    ----------------------------------------------------------------------------------------------

    local enemysNode = display.newNode()
    enemysNode:setPosition(0, 0)
    self:addChild(enemysNode)

    for k, v in ipairs(enemys) do

        local sprite = require("battle_system.CHeroSprite").new(v, "body")
        sprite:setPosition(pos[v.tag])
        enemysNode:addChild(sprite)
        sprite:setScale(0.8)
    end

    local animation = display.newSprite("xianglong18/4.png")
    animation:setPosition(0, display.height / 2)
    self:addChild(animation)
    animation:runAction(CCMoveTo:create(1.0, CCPointMake(display.width, display.height / 2)))


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
end

function CXiangLong18:ctor(heroData, attacker, enemys, pos)
     self:init(heroData, attacker, enemys, pos)
end

return CXiangLong18