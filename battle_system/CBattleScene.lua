
require "GameConst"
require "Animation"
require "data.heros_gs"
require "data.levels_gs"
require "battle_system.HeroPosition"

local action = require("AnimAction")
local ourArmyPosition = getOutPositon()
local enemyArmyPosition = getArmyPosition()
local enemys = {0, 0, 0, 0, 0, 0, 0, 0, 0}
local ourArmy = {}

local atkResult = require("battle_system.CAttackStruct").new()

local CBattleScene = class("CBattleScene", function()
	return display.newScene("CBattleScene")
end)

function CBattleScene:init()
	local ourArmyCount = #(game.Player:getCurrentFormation():getHerosOnForm())
	local maxRound = 3
    local cardOffset = 0
	self.layer = display.newBackgroundSprite("ui/bg03.png")
	self:addChild(self.layer)
	self.layer:setPosition(self.layer:getContentSize().width/2, display.height/2)

	local titleLabel = ui.newTTFLabel({
		text = levels[self.map[1]][self.map[2]].name,
		size = 36,
		align = ui.TEXT_ALIGN_CENTER,
		color = ccc3(0, 0, 255),
		x = display.width / 2,
		y = display.height * (9 / 10)
	})
	self.layer:addChild(titleLabel)

	self.ourMembersNode = display.newNode()
	self.ourMembersNode:setPosition(0, 0)
	self.layer:addChild(self.ourMembersNode)

	self.enemyMembersNode = display.newNode()
	self.enemyMembersNode:setPosition(0, 0)
	self.layer:addChild(self.enemyMembersNode)


	--加载自己队伍
	local function loadOursArmy()
		local function sortFighter(m1, m2)
			if m1:getTag() < m2:getTag() then
				return true
			end
			return false
		end

        local form = game.Player:getCurrentFormation()

        local index = 1
		for k, v in ipairs(form:getHeros()) do
            if (v ~= 0) then
                local fighter = require("battle_system.CHeroSprite").new(v, "card", true)
                fighter:setPosition(ourArmyPosition[k])
                self.ourMembersNode:addChild(fighter)
                fighter:setTag(k)
                self.ourArmySprite[index] = fighter
                local n = ui.newTTFLabel({
                    text = index,
                    size = 20,
                    color = ccc3(0, 255, 0),
                    align = ui.TEXT_ALIGN_CENTER
                })
                fighter:addChild(n)

                index = index + 1
            end
		end

		table.sort( self.ourArmySprite, sortFighter)
	end

	--加载敌人队伍
	local function loadEnemyArmy()
		math.randomseed(os.time())
		local count = 1

		local enemyQueue = levels[self.map[1]][self.map[2]].form
		for k, v in ipairs(enemyQueue) do
			if v >= 1 then
                enemys[k] = require("game_model.HeroData").new(BaseData_heros[v])
                self.enemyArmySprite[count] = require("battle_system.CHeroSprite").new( enemys[k], "card")
				self.enemyArmySprite[count]:setPosition(enemyArmyPosition[k])
				self.enemyArmySprite[count]:setTag(k + 100)
				self.enemyMembersNode:addChild(self.enemyArmySprite[count])

				local n = ui.newTTFLabel({
					text = (k + 100),
					size = 20,
					color = ccc3(0, 255, 0),
					align = ui.TEXT_ALIGN_CENTER
				})
				self.enemyArmySprite[count]:addChild(n)
				count = count + 1
			end
        end
        if (self.enemyArmySprite[1]) then
            cardOffset = self.enemyArmySprite[1]:getContentSize().width
        end
		self.atkTotalCount = (ourArmyCount + #self.enemyArmySprite) * maxRound
	end

	--加载所有队伍
	local function loadArmy()
		loadOursArmy()
		loadEnemyArmy()
	end

	--生成攻击顺序列表
	local atkOrderList = {}
	local function generateAtkOrder()
		local count = math.max(ourArmyCount, #self.enemyArmySprite)
		local orderIndex = 1
		local m = 1
		local n = 1
		for i = 1, count do
			if (self.ourArmySprite[n] ~= nil) then
				atkOrderList[orderIndex] = self.ourArmySprite[n]
				orderIndex = orderIndex + 1
				n = n + 1
            end

			if (self.enemyArmySprite[m] ~= nil) then
				atkOrderList[orderIndex] = self.enemyArmySprite[m]
				orderIndex = orderIndex + 1
				m = m  + 1
			end
		end	
	end

	require("GameFormula")
	--atker_1发起攻击的人,atker_2被攻击的人
	local function hitHarm(atker_1, atker_2)

        local delayTime = 0
        local layer = nil
        if (atker_1:getTag() > 100) then
            layer = require("skills_system.CSkillsMgr").new(atker_1:getHeroData(),
                game.Player:getCurrentFormation():getHeros(), ourArmyPosition, false)
        else
            layer = require("skills_system.CSkillsMgr").new(atker_1:getHeroData(),
                enemys, enemyArmyPosition, true)
        end

        --大招发动时间，如果大于0，则有大招
        delayTime = layer:getDelayTime()
        if delayTime > 0 then
            self:addChild(layer)
        end
        layer = nil

		local ap = GameFormula.GetAttactResult(atker_1:getHeroData():getLevel(), atker_1:getHeroData():getAp(), 1, atker_2:getHeroData():getDp())

        atkResult.addItem({
            atk_A = atker_1:getHeroData():getId(),
            atk_B = atker_2:getHeroData():getId(),
            delayTime = delayTime,
            cutHP = ap
        })
        printf(atker_1:getHeroData():getName() .. "(攻" .. atker_1:getHeroData():getAp() ..")   ->   " ..
                atker_2:getHeroData():getName() .. "(防" .. atker_2:getHeroData():getDp() .. ")" .. "   **伤害 " .. ap)
        if atker_2:hurt(ap) == true then
			printf("******************死了")	
		end
        atker_2:resetHp()
        if delayTime == 0 then
            local label = ui.newTTFLabel({
                text = string.format("%d", -ap),
                size = 20,
                color = ccc3(255, 0, 0)
            })
            label:setPosition(atker_2:getPosition())
            self.layer:addChild(label)
            label:setVisible(false)

            label:runAction(transition.sequence({
                CCDelayTime:create(0.3),
                CCCallFunc:create(function()
                    label:setVisible(true)
                end),
                action:onHitHarmAction(CCPointMake(atker_2:getPosition())),   -- moving right

            }))
        end

        return delayTime
	end


	--取得被攻击的人（根据攻击者的tag取得可以攻击的人）
	local AttackSearchList = require("battle_system.AttackSearchList")
	local function getAttackedMember(tag)
		local child = nil
		if (tag > 100) then
			tag = tag - 100
			child = AttackSearchList:getMemberByTag(tag, self.ourMembersNode, atkOrderList)
		else
			tag = tag + 100
			child = AttackSearchList:getMemberByTag(tag, self.enemyMembersNode, atkOrderList)
		end
		return child
	end

	--队员攻击敌人
	local atkCount = 0

	local function showDlg()
		local dlg = nil
		function onOKButton()
			dlg:removeFromParentAndCleanup(true)
            display.replaceScene(require("adventure.CAdventureScene").new(self.map[1]))
			
		end

        dump(atkResult:getResult())
		dlg = require("ui_common.CPromptBox").new({
			title       = "提示",
			info        = "是否进行下一关？",
			ok_text     = "确认",
			cancel_text = "取消",
			listener    = onOKButton
		})
		self:addChild(dlg, 1003)
    end

    local function onGameOver()

        game.Player:setLevelStar(self.map[1], self.map[2], 2)
        showDlg()
    end

	local function onAttackScheduler()

		if (atkCount == self.atkTotalCount) then
            atkCount = 0

            onGameOver()
			return
		end

		local attackedMember = nil
		local atkOrderIndex = atkCount % (ourArmyCount + #self.enemyArmySprite) + 1

		if (atkOrderList[atkOrderIndex]:isDead() == false) then
			local tag = atkOrderList[atkOrderIndex]:getTag()
			attackedMember = getAttackedMember(tag)

			if (attackedMember == nil) then
                onGameOver()
				return
			end

			local posA = CCPointMake(atkOrderList[atkOrderIndex]:getPosition())
			local posB = CCPointMake(attackedMember:getPosition())
            local rotateAngle = 0
            if (attackedMember:getTag() > 100) then
                posB.x = posB.x - cardOffset
                rotateAngle = 30
            else
                posB.x = posB.x + cardOffset
                rotateAngle = -30
            end

            local delayTime = hitHarm(atkOrderList[atkOrderIndex], attackedMember)
            local nextHero = nil
            if (delayTime >0 ) then
                nextHero = transition.sequence({
                    CCDelayTime:create(delayTime),
                    CCCallFunc:create(function()
                        onAttackScheduler()
                    end),
                })
            else
                nextHero = transition.sequence({
                    CCSpawn:createWithTwoActions(CCMoveTo:create(0.5, posB), CCRotateTo:create(0.3, rotateAngle)),
                    CCRotateTo:create(0, 0),
                    CCMoveTo:create(0.3, posA),
                    CCDelayTime:create(delayTime),
                    CCCallFunc:create(function()
                        onAttackScheduler()
                    end),
                })
            end

            atkOrderList[atkOrderIndex]:runAction(nextHero)
            atkCount = atkCount + 1

		else 
			atkCount = atkCount + 1	
			onAttackScheduler(dt)
		end
    end

--    self.layer:registerScriptHandler(function(action)
--        if action == "exit" then
--            --self.layer:removeAllChildrenWithCleanup(true)
--            self:removeAllChildrenWithCleanup(true)
--        end
--    end)

	--initPos()
	loadArmy()
	generateAtkOrder()
    onAttackScheduler()

end

function CBattleScene:onEnter()
	self:init()
end

function CBattleScene:ctor(m)
	self.map = m
	--self.fighters = {}
	self.ourArmySprite = {}
 	self.enemyArmySprite = {}
 	self.atkTotalCount = 0
end

return CBattleScene