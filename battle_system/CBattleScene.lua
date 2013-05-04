
require "GameConst"
require "Animation"
require "data.heros_gs"
require "data.levels_gs"
require "battle_system.HeroPosition"

local action = require("AnimAction")
--local ourArmyPosition = getOutPositon()
--local enemyArmyPosition = getArmyPosition()
--local enemys = {0, 0, 0, 0, 0, 0, 0, 0, 0}
--local ourArmy = {}
--
--
--
local CBattleScene = class("CBattleScene", function()
	return display.newScene("CBattleScene")
end)
--
--function CBattleScene:init()
--	local ourArmyCount = #(game.Player:getCurrentFormation():getHerosOnForm())
--	local maxRound = 10
--    local cardOffset = 0
--	self.layer = display.newBackgroundSprite("ui/bg03.png")
--	self:addChild(self.layer)
--	self.layer:setPosition(self.layer:getContentSize().width/2, display.height/2)
--
--	local titleLabel = ui.newTTFLabel({
--		text = levels[self.map[1]][self.map[2]].name,
--		size = 36,
--		align = ui.TEXT_ALIGN_CENTER,
--		color = ccc3(0, 0, 255),
--		x = display.width / 2,
--		y = display.height * (9 / 10)
--	})
--	self.layer:addChild(titleLabel)
--
--	self.ourMembersNode = display.newNode()
--	self.ourMembersNode:setPosition(0, 0)
--	self.layer:addChild(self.ourMembersNode)
--
--	self.enemyMembersNode = display.newNode()
--	self.enemyMembersNode:setPosition(0, 0)
--	self.layer:addChild(self.enemyMembersNode)
--
--
--	--加载自己队伍
--	local function loadOursArmy()
--		local function sortFighter(m1, m2)
--			if m1:getTag() < m2:getTag() then
--				return true
--			end
--			return false
--		end
--
--        local form = game.Player:getCurrentFormation()
--
--        local index = 1
--		for k, v in ipairs(form:getHeros()) do
--            if (v ~= 0) then
--                local fighter = require("battle_system.CHeroSprite").new(v, "card", true)
--                fighter:setPosition(ourArmyPosition[k])
--                self.ourMembersNode:addChild(fighter)
--                fighter:setTag(k)
--                self.ourArmySprite[index] = fighter
--                local n = ui.newTTFLabel({
--                    text = index,
--                    size = 20,
--                    color = ccc3(0, 255, 0),
--                    align = ui.TEXT_ALIGN_CENTER
--                })
--                fighter:addChild(n)
--
--                index = index + 1
--            end
--		end
--
--		table.sort( self.ourArmySprite, sortFighter)
--	end
--
--	--加载敌人队伍
--	local function loadEnemyArmy()
--		math.randomseed(os.time())
--		local count = 1
--
--		local enemyQueue = levels[self.map[1]][self.map[2]].form
--		for k, v in ipairs(enemyQueue) do
--			if v >= 1 then
--                enemys[k] = require("game_model.HeroData").new(BaseData_heros[v])
--                self.enemyArmySprite[count] = require("battle_system.CHeroSprite").new( enemys[k], "card")
--				self.enemyArmySprite[count]:setPosition(enemyArmyPosition[k])
--				self.enemyArmySprite[count]:setTag(k + 100)
--				self.enemyMembersNode:addChild(self.enemyArmySprite[count])
--
--				local n = ui.newTTFLabel({
--					text = (k + 100),
--					size = 20,
--					color = ccc3(0, 255, 0),
--					align = ui.TEXT_ALIGN_CENTER
--				})
--				self.enemyArmySprite[count]:addChild(n)
--				count = count + 1
--			end
--        end
--        if (self.enemyArmySprite[1]) then
--            cardOffset = self.enemyArmySprite[1]:getContentSize().width
--        end
--		self.atkTotalCount = (ourArmyCount + #self.enemyArmySprite) * maxRound
--	end
--
--	--加载所有队伍
--	local function loadArmy()
--		loadOursArmy()
--		loadEnemyArmy()
--	end
--
--	--生成攻击顺序列表
--	local atkOrderList = {}
--	local function generateAtkOrder()
--		local count = math.max(ourArmyCount, #self.enemyArmySprite)
--		local orderIndex = 1
--		local m = 1
--		local n = 1
--		for i = 1, count do
--			if (self.ourArmySprite[n] ~= nil) then
--				atkOrderList[orderIndex] = self.ourArmySprite[n]
--				orderIndex = orderIndex + 1
--				n = n + 1
--            end
--
--			if (self.enemyArmySprite[m] ~= nil) then
--				atkOrderList[orderIndex] = self.enemyArmySprite[m]
--				orderIndex = orderIndex + 1
--				m = m  + 1
--			end
--		end
--	end
--
--	require("GameFormula")
--	--atker_1发起攻击的人,atker_2被攻击的人
--	local function hitHarm(atker_1, atker_2)
--
--        local delayTime = 0
--        local layer = nil
--        if (atker_1:getTag() > 100) then
--            layer = require("skills_system.CSkillsMgr").new(atker_1:getHeroData(),
--                game.Player:getCurrentFormation():getHeros(), ourArmyPosition, false)
--        else
--            layer = require("skills_system.CSkillsMgr").new(atker_1:getHeroData(),
--                enemys, enemyArmyPosition, true)
--        end
--
--        --大招发动时间，如果大于0，则有大招
--        delayTime = layer:getDelayTime()
--        if delayTime > 0 then
--            self:addChild(layer)
--        end
--        layer = nil
--
--		local ap = GameFormula.GetAttactResult(atker_1:getHeroData():getLevel(), atker_1:getHeroData():getAp(), 1, atker_2:getHeroData():getDp())
--
--
--        printf(atker_1:getHeroData():getName() .. "(攻" .. atker_1:getHeroData():getAp() ..")   ->   " ..
--                atker_2:getHeroData():getName() .. "(防" .. atker_2:getHeroData():getDp() .. ")" .. "   **伤害 " .. ap)
--        if atker_2:hurt(ap) == true then
--			printf("******************死了")
--		end
--        atker_2:resetHp()
--        if delayTime == 0 then
--            local label = ui.newTTFLabel({
--                text = string.format("%d", -ap),
--                size = 20,
--                color = ccc3(255, 0, 0)
--            })
--            label:setPosition(atker_2:getPosition())
--            self.layer:addChild(label)
--            label:setVisible(false)
--
--            label:runAction(transition.sequence({
--                CCDelayTime:create(0.3),
--                CCCallFunc:create(function()
--                    label:setVisible(true)
--                end),
--                action:onHitHarmAction(CCPointMake(atker_2:getPosition())),   -- moving right
--
--            }))
--        end
--
--        return delayTime
--	end
--
--
--	--取得被攻击的人（根据攻击者的tag取得可以攻击的人）
--	local AttackSearchList = require("battle_system.AttackSearchList")
--	local function getAttackedMember(tag)
--		local child = nil
--		if (tag > 100) then
--			tag = tag - 100
--			child = AttackSearchList:getMemberByTag(tag, self.ourMembersNode, atkOrderList)
--		else
--			tag = tag + 100
--			child = AttackSearchList:getMemberByTag(tag, self.enemyMembersNode, atkOrderList)
--		end
--		return child
--	end
--
--	--队员攻击敌人
--	local atkCount = 0
--
--	local function showDlg()
--		local dlg = nil
--		function onOKButton()
--			dlg:removeFromParentAndCleanup(true)
--            display.replaceScene(require("adventure.CAdventureScene").new(self.map[1]))
--
--		end
--
--		dlg = require("ui_common.CPromptBox").new({
--			title       = "提示",
--			info        = "是否进行下一关？",
--			ok_text     = "确认",
--			cancel_text = "取消",
--			listener    = onOKButton
--		})
--		self:addChild(dlg, 1003)
--    end
--
--
--
--	local function onAttackScheduler()
--
--		if (atkCount == self.atkTotalCount) then
--            atkCount = 0
--
--            onGameOver()
--			return
--		end
--
--		local attackedMember = nil
--		local atkOrderIndex = atkCount % (ourArmyCount + #self.enemyArmySprite) + 1
--
--		if (atkOrderList[atkOrderIndex]:isDead() == false) then
--			local tag = atkOrderList[atkOrderIndex]:getTag()
--			attackedMember = getAttackedMember(tag)
--
--			if (attackedMember == nil) then
--                onGameOver()
--				return
--			end
--
--			local posA = CCPointMake(atkOrderList[atkOrderIndex]:getPosition())
--			local posB = CCPointMake(attackedMember:getPosition())
--            local rotateAngle = 0
--            if (attackedMember:getTag() > 100) then
--                posB.x = posB.x - cardOffset
--                rotateAngle = 30
--            else
--                posB.x = posB.x + cardOffset
--                rotateAngle = -30
--            end
--
--            local delayTime = hitHarm(atkOrderList[atkOrderIndex], attackedMember)
--            local nextHero = nil
--            if (delayTime >0 ) then
--                nextHero = transition.sequence({
--                    CCDelayTime:create(delayTime),
--                    CCCallFunc:create(function()
--                        onAttackScheduler()
--                    end),
--                })
--            else
--                nextHero = transition.sequence({
--                    CCSpawn:createWithTwoActions(CCMoveTo:create(0.5, posB), CCRotateTo:create(0.3, rotateAngle)),
--                    CCRotateTo:create(0, 0),
--                    CCMoveTo:create(0.3, posA),
--                    CCDelayTime:create(delayTime),
--                    CCCallFunc:create(function()
--                        onAttackScheduler()
--                    end),
--                })
--            end
--
--            atkOrderList[atkOrderIndex]:runAction(nextHero)
--            atkCount = atkCount + 1
--
--		else
--			atkCount = atkCount + 1
--			onAttackScheduler(dt)
--		end
--    end
--
----    self.layer:registerScriptHandler(function(action)
----        if action == "exit" then
----            --self.layer:removeAllChildrenWithCleanup(true)
----            self:removeAllChildrenWithCleanup(true)
----        end
----    end)
--
--	--initPos()
--	loadArmy()
--	generateAtkOrder()
--    onAttackScheduler()
--
--end



function CBattleScene:showBattleAnim()
    self.atkResult:reset()

    local ourHerosNode = display.newNode()
    ourHerosNode:setPosition(0, 0)
    self.bg:addChild(ourHerosNode)

    local enemyHerosNode = display.newNode()
    enemyHerosNode:setPosition(0, 0)
    self.bg:addChild(enemyHerosNode)

    local function initOurArmy()
        local ourArmy = self.atkResult:getOurArmy()
        for k, v in ipairs(ourArmy) do
            local heroSprite = require("battle_system.CBattleHeroSprite").new( v, false)
            heroSprite:setPosition(v:getPosition())
            ourHerosNode:addChild(heroSprite)
            v:setHeroSprite(heroSprite)
        end
    end

    local function initEnemyArmy()
        local enemyArmy = self.atkResult:getEnemyArmy()
        for k, v in ipairs(enemyArmy) do
            local heroSprite = require("battle_system.CBattleHeroSprite").new(v)
            heroSprite:setPosition(v:getPosition())
            enemyHerosNode:addChild(heroSprite)
            v:setHeroSprite(heroSprite)
        end
    end

    local function onRepeat()
        self:showBattleAnim()
    end

    local ignorAnimation = false
    local function onGameOver()
        ignorAnimation = false
        ourHerosNode:removeAllChildrenWithCleanup(true)
        ourHerosNode:removeFromParentAndCleanup(true)
        enemyHerosNode:removeAllChildrenWithCleanup(true)
        enemyHerosNode:removeFromParentAndCleanup(true)


        local _heroExp = 0
        local _gameExp = 0
        local _gold    = 0

        if self.battleType == BattleType.Adventure_map then

            game.Player:setLevelStar(self.map[1], self.map[2], 2)

            _heroExp = levels[self.map[1]][self.map[2]].heroExp
            _gameExp = levels[self.map[1]][self.map[2]].exp
            _gold    = levels[self.map[1]][self.map[2]].gold
        end

        if self.atkResult:getWinner()  == false then
            _heroExp = 0
        end
        local endLayer = require("battle_system.CGameOverLayer").new({
            bWin = self.atkResult:getWinner(),
            heroExp = _heroExp,
            gameExp = _gameExp,
            gold = _gold,
            reward = self.reward,
            ourArmyData = self.atkResult:getOurArmy()
        }, self.battleType)
        self:addChild(endLayer)

        require("framework.client.api.EventProtocol").extend(endLayer)
        endLayer:addEventListener(GlobalVariable["NotificationTag"]["REPEAT_FIGHTING_ANIMATION"], onRepeat)
        endLayer:setScale(0.3)

        transition.scaleTo(endLayer, {
                scaleX     = 1.2,
                scaleY     = 1.2,
                time       = 0.3,
                onComplete = function (  )
                    transition.scaleTo(endLayer,{
                        scaleX = 0.9,
                        scaleY = 0.9,
                        time = 0.1,
                        onComplete = function ( ... )
                            transition.scaleTo(endLayer,{
                            scaleX = 1.0,
                            scaleY = 1.0,
                            time = 0.08
                            })
                        end
                    })
                end,
            })
    end

    local function displayAnimation()
        local result = self.atkResult:getResult()
        local index = 1

        local function effectOfBlood(hp, pos)
            local label = ui.newBMFontLabel({
                text = string.format("%d", -hp),
                font = GAME_FONT.font_blood
            })
            label:setPosition(pos)
            self.bg:addChild(label)
            label:setVisible(false)

            label:runAction(transition.sequence({
                CCDelayTime:create(0.4),
                CCCallFunc:create(function()
                    label:setVisible(true)
                end),
                action:onHitHarmAction(pos),   -- moving right

            }))
        end

        local ourForm   = game.Player:getCurrentFormation():getHeros()
        local enemyForm =  nil
        if self.battleType == BattleType.Adventure_map then
            enemyForm =  levels[self.map[1]][self.map[2]].form
        else
            enemyForm =  self.map
        end

        local function locationHaveHero(pos, bSelf)
            local ret = false
            if (bSelf) then
                if enemyForm[pos] ~= 0 then
                    ret = true
                end
            else

                if ourForm[pos] ~= 0 then
                    ret = true
                end
            end
            return ret
        end

        local function disPlayAtkAnimation(oriPos, atkList, bSelf, deadHeroTag)
            local function testHeroIsDead(tag)
                 for k, v in ipairs(deadHeroTag) do
                    if v % 100 == tag then
                        return true
                    end
                 end
                 return false
            end

            local armyPositions = getOutPositon()
            if bSelf then
                armyPositions = getArmyPosition()
            end


            for k, v in ipairs(atkList) do
                local attackSprite1 = display.newSprite("xianglong18/12.png")
                attackSprite1:setPosition(oriPos)
                self.bg:addChild(attackSprite1)
                if locationHaveHero(v, bSelf)  and  testHeroIsDead(v) == false then
                    attackSprite1:setColor(ccc3(255, 0, 0))
                end
                attackSprite1:runAction(transition.sequence({
                    CCMoveTo:create(0.2, armyPositions[v]),
                    CCDelayTime:create(0.1),
                    CCCallFunc:create(function()
                        attackSprite1:removeFromParentAndCleanup(true)
                    end)
                }))

            end
        end


        local function run(v)
            if ((ignorAnimation == false) and v) then
                local angle = -30
                if v.hero_A:isSelf() then
                    angle = 30
                end

                local atkList = nil
                if v.skill then
                    atkList = v.target
                else
                    atkList = {v.hero_B[1]:getTag() % 100}
                end
                v.hero_A:getHeroSprite():runAction(
                    transition.sequence({
                        --CCSpawn:createWithTwoActions(CCMoveTo:create(0.5, v.hero_B:getPosition()), CCRotateTo:create(0.3, angle)),
                        CCDelayTime:create(0.5),
                        CCCallFunc:create(function()

                            local deadHeroTag = {}
                            for k_2, v_2 in ipairs(v.hero_B) do
                                if v_2:tempIsDead() == false then
                                    v_2:addTempHp(-v.cutHP)
                                    effectOfBlood(v.cutHP, CCPointMake(v_2:getPositionX(),v_2:getPositionY()))
                                    v_2:getHeroSprite():refreshHp(v_2:getTempHp(), v_2:getFullHp())

                                else
                                    deadHeroTag[#deadHeroTag + 1] = v_2:getTag()
                                end
                            end
                            disPlayAtkAnimation(v.hero_A:getPosition(), atkList, v.hero_A:isSelf(), deadHeroTag)
--                            v.hero_B:addTempHp(-v.cutHP)
--                            effectOfBlood(v.cutHP, CCPointMake(v.hero_B:getPositionX(),v.hero_B:getPositionY()))
--                            v.hero_B:getHeroSprite():refreshHp(v.hero_B:getTempHp(), v.hero_B:getFullHp())
                        end),
                       -- CCMoveTo:create(0.3, v.hero_A:getPosition()),
                        CCDelayTime:create(0.5),
                        CCCallFunc:create(function()

                            index = index + 1
                            return run(result[index])

                        end)
                    }))
            else
                onGameOver()
            end
        end
        run(result[1])
    end

    local passButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("tiaoguo"))
    passButton:registerScriptTapHandler(function()
        ignorAnimation = true
    end)
    passButton:setPosition(display.width / 2, self.bg:getContentSize().height * (5 / 40))
    local menu = ui.newMenu({passButton})    menu:setPosition(0, 0)
    self.bg:addChild(menu)

    initOurArmy()
    initEnemyArmy()
    displayAnimation()
end

function CBattleScene:generatorResult()

    if self.battleType == BattleType.Adventure_map then
        self.atkResult = require("battle_system.CAttackStruct").new(levels[self.map[1]][self.map[2]].form, 10, levels[self.map[1]][self.map[2]].hero_lv)
        self.atkResult:generateAtkList()

        local bGetReward = CFuncHelper:getRandomResults(levels[self.map[1]].dropPercent)
        if (self.atkResult:getWinner() and bGetReward) then
            local currentLevel = levels[self.map[1]][self.map[2]]
            if (math.random(1, 10) % 2 == 0) then
                if currentLevel.drop_item1[1] == ItemType.EQUIPMENT then
                    self.reward = {}
                    self.reward.ItemType = ItemType.EQUIPMENT
                    self.reward.ItemData = require("game_model.CEquip").new(BaseData_equipments[currentLevel.drop_item1[2]])
                elseif currentLevel.drop_item1[1] == ItemType.SKILL then
                    self.reward = {}
                    self.reward.ItemData = require("game_model.CSkill").new(BaseData_skills[currentLevel.drop_item1[2]])
                    self.reward.ItemType = ItemType.SKILL
                end
            else

                if currentLevel.drop_item2[1] == ItemType.EQUIPMENT then
                    self.reward = {}
                    self.reward.ItemData = require("game_model.CEquip").new(BaseData_equipments[currentLevel.drop_item2[2]])
                    self.reward.ItemType = ItemType.EQUIPMEN
                elseif currentLevel.drop_item2[1] == ItemType.SKILL then
                    self.reward = {}
                    self.reward.ItemData = require("game_model.CSkill").new(BaseData_skills[currentLevel.drop_item2[2]])
                    self.reward.ItemType = ItemType.SKILL
                end
            end
        end
    else
        self.atkResult = require("battle_system.CAttackStruct").new(self.map, 10, 1)
        self.atkResult:generateAtkList()
    end
end

function CBattleScene:synResult()

    if self.battleType == BattleType.Adventure_map then
        local gameExp  = levels[self.map[1]][self.map[2]].exp
        local gold     = levels[self.map[1]][self.map[2]].gold
        game.Player:addSilver(gold)
        game.Player:addExp(gameExp)

        if (self.atkResult:getWinner() ) then
            local heroExp = levels[self.map[1]][self.map[2]].heroExp
            if self.reward then
                if self.reward.ItemType == ItemType.EQUIPMENT then
                    game.Player:addEquipment(self.reward.ItemData)
                elseif self.reward.ItemType == ItemType.SKILL then
                    game.Player:addSkill(self.reward.ItemData)
                end
            end

            game.Player:setLevelStar(self.map[1], self.map[2], 2)

            local form = game.Player:getCurrentFormation()
            for k, v in ipairs(form:getHeros()) do
                if (v ~= 0) then
                    v:addExp(heroExp)
                end
            end
        end
    end
end


function CBattleScene:initBg()
    self.bg = display.newBackgroundSprite("ui/bg03.png")
    self:addChild(self.bg)
    self.bg:setPosition(self.bg:getContentSize().width/2, display.height/2)

    if (self.battleType == BattleType.Adventure_map) then
        local titleLabel = ui.newTTFLabel({
            text = levels[self.map[1]][self.map[2]].name,
            size = 36,
            align = ui.TEXT_ALIGN_CENTER,
            color = ccc3(0, 0, 255),
            x = display.width / 2,
            y = display.height * (9 / 10)
        })
        self.bg:addChild(titleLabel)
    end

    self:generatorResult()
    self:synResult()
end

function CBattleScene:init2()
    self:showBattleAnim()
end

function CBattleScene:init3()

end

function CBattleScene:loading( ptr)
    game.KZNetWork:UploadBattleResult(ptr, CBattleScene.init2)
end

function CBattleScene:ctor(m, battleType)

    if(display.height > CONFIG_SCREEN_HEIGHT ) then
        local pad = require("CLayerIpad").new()
        self:addChild(pad)
    end
    self.battleType = battleType
	self.map = m
    self:initBg()

    if battleType == nil then
        CCMessageBox("BattleType Is NULL", "ERROR")
    end

    --loading界面
    local loadingLayer = require("ui_common.CLoadingLayer")
    loadingLayer.new(CBattleScene.loading, self)
end

return CBattleScene