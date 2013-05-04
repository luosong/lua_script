--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-27
-- Time: 上午11:54
-- To change this template use File | Settings | File Templates.
--

require("battle_system.HeroPosition")

require("ResourceMgr")

local armyPositions = getArmyPosition()

local CTestAttackType = class("CTestAttackType", function()
    return CCLayerColor:create(ccc4(0, 0, 0, 255), display.width, display.height)
end)

function CTestAttackType:ctor()
    for k, v in ipairs(armyPositions) do

        local sprite = ResourceMgr:getSprite("damozushi")
        sprite:setScale(0.6)
        sprite:setPosition(v)
        self:addChild(sprite)
    end




    local testButton = ui.newTTFLabelMenuItem({
        text = "退出",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            self:removeAllChildrenWithCleanup(true)
            self:removeFromParentAndCleanup(true)
        end
    })

    local function disPlayAtkAnimation(atkList)
        for k, v in ipairs(atkList) do
            local attackSprite1 = display.newSprite("xianglong18/12.png")
            attackSprite1:setPosition(display.width * (3 / 4), display.height)
            self:addChild(attackSprite1)

            attackSprite1:runAction(transition.sequence({
                CCMoveTo:create(0.2, armyPositions[atkList[k]]),
                CCDelayTime:create(0.1),
                CCCallFunc:create(function()
                    attackSprite1:removeFromParentAndCleanup(true)
                end)
            }))

        end
    end

    local b1 = ui.newTTFLabelMenuItem({
        text = "单体攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.SINGLE_PERSON, 9)
            disPlayAtkAnimation(atkList)

        end
    })

    local b2 = ui.newTTFLabelMenuItem({
        text = "单行攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.SINGLE_ROW, 9)
            disPlayAtkAnimation(atkList)
        end
    })

    local b3 = ui.newTTFLabelMenuItem({
        text = "单列攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.SINGLE_COL, 7)
            disPlayAtkAnimation(atkList)
        end
    })

    local b4 = ui.newTTFLabelMenuItem({
        text = "十字攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.CROSS, 7)
            disPlayAtkAnimation(atkList)
        end
    })

    local b5 = ui.newTTFLabelMenuItem({
        text = "回字攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.CIRCLE, 7)
            disPlayAtkAnimation(atkList)
        end
    })

    local b6 = ui.newTTFLabelMenuItem({
        text = "全体攻击",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            local atkList = require("battle_system.AttackSearchList"):getEnemysByLocation(SkillAtkType.ALL, 7)
            disPlayAtkAnimation(atkList)
        end
    })

    local testButton = ui.newTTFLabelMenuItem({
        text = "退出",
        size = 48,
        color = ccc3(222, 222, 200),
        listener = function()
            self:removeAllChildrenWithCleanup(true)
            self:removeFromParentAndCleanup(true)
        end
    })

    local menu = ui.newMenu({b1, b2, b3, b4, b5, b6, testButton})
    menu:setPosition(display.width / 3, display.height / 2)
    menu:alignItemsVertically()
    self:addChild(menu)
end

return CTestAttackType