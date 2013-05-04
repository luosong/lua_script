--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-20
-- Time: 下午2:21
-- To change this template use File | Settings | File Templates.
--

local AttackStruct = class("AttackStruct")
--
-- atkTargetHeros: 目标英雄数组（heroData，或者 id）
--  round        : 回合
--

function AttackStruct:ctor(atkTargetHeros, round, heroLevel)
    local items = {}
    local atkOrder = {}
    local ourArmy = {}
    local enemyArmy = {}
    local attackSearchList = require("battle_system.AttackSearchList")


    local function getOurHeroByTag(tag)
        local hero = nil
        for k, v in ipairs(ourArmy) do
            if (v.getTag() == tag) then
                hero = v
            end
        end
        return hero
    end

    local function getEnemyHeroByTag(tag)
        local hero = nil
        for k, v in ipairs(enemyArmy) do
            if (v.getTag() == (tag + 100)) then
                hero = v
            end
        end
        return hero
    end

    self.reset = function()
        for k, v in ipairs(atkOrder) do
            v:resetHp()
        end
    end

    self.addItem = function(item)

        local cutHP = GameFormula.GetAttactResult(item.atk_A:getHeroData():getLevel(),
            item.atk_A:getHeroData():getAp(), 1, item.atk_B:getHeroData():getDp())

        local itemData = {}
        local skills = item.atk_A:getHeroData():getKungFus()
        local haveCutHp = false
        local hero_B = {item.atk_B}
        if CFuncHelper:getRandomResults(40) then
            local r = math.random(1, 1000)
            local keys = table.keys(skills)
            itemData.skill = skills[keys[r % #keys + 1]]
            itemData.target = attackSearchList:getEnemysByLocation(itemData.skill:getAttackType(), item.atk_B:getTag())

            local tempHero_B = {}
            if (item.atk_A:isSelf()) then
                for k, v in ipairs(itemData.target) do
                    local hero = getEnemyHeroByTag(v)
                    if hero then
                        hero:addHp(-cutHP)
                        haveCutHp = true
                        tempHero_B[#tempHero_B + 1] = hero
                    end
                end
            else
                for k, v in ipairs(itemData.target) do
                   local hero =  getOurHeroByTag(v)
                    if hero then
                        hero:addHp(-cutHP)
                        haveCutHp = true
                        tempHero_B[#tempHero_B + 1] = hero
                    end
                end
            end
            if #tempHero_B > 0 then
                hero_B = tempHero_B
            end
        end

        itemData.hero_A = item.atk_A
        --itemData.hero_B = item.atk_B
        itemData.hero_B = hero_B
        itemData.delayTime = item.delayTime
        itemData.cutHP = cutHP
        if haveCutHp == false then
            item.atk_B:addHp(-cutHP) --模拟计算减血量
        end

        items[#items + 1] = itemData
    end


    local selfWin = false
    local function _getWinner()
        local ourArmyResult = false
        local enemyArmyResult = false

        local ourHpMp = 0
        for k, v in ipairs(ourArmy) do
             if (v:isDead() == false) then
                 ourArmyResult = true
                 ourHpMp = ourHpMp + v:getHp()
             end
        end

        local enemyHpMp = 0
        for k, v in ipairs(enemyArmy) do
            if (v:isDead() == false) then
                enemyArmyResult = true
                enemyHpMp = enemyHpMp + v:getHp()
            end
        end

        if ourArmyResult and (enemyArmyResult == false) then
            selfWin = true
        elseif (ourArmyResult == false) and (enemyArmyResult) then
            selfWin = false
        elseif enemyArmyResult and ourArmyResult then
            if (ourHpMp > enemyHpMp) then
                selfWin = true
            end
        end

    end

    -----------------------------------------------------
    self.getResult = function()
        return items
    end

    self.getWinner = function()
        return selfWin
    end

    self.getOurArmy = function()
        return ourArmy
    end

    self.getEnemyArmy = function()
        return enemyArmy
    end

    self.printResult = function()
        printf("-------------------------Result----------------------------")
        for k, v in ipairs(items) do
            printf(v.hero_A:getHeroData():getName() .. " ---->  " .. v.hero_B:getHeroData():getName() .. "   " .. v.cutHP)
        end
        printf("-------------------------Result----------------------------")
    end


    self.generateAtkList = function()

        local function initOursHeroData()
            local form = game.Player:getCurrentFormation()
            local ourPosition = getOutPositon()
            local counter = 1
            for k, v in ipairs(form:getHeros()) do
                if (v ~= 0) then

                    local heroData = require("battle_system.CBattleHeroData").new({
                        data = v,
                        pos  = ourPosition[k],
                        tag  = k,
                        hp   = v:getHp(),
                        sf   = true
                    })
                    ourArmy[counter] = heroData
                    counter = counter + 1
                end
            end
        end

        local function initEnemyHeroData()

            local enemyQueue = atkTargetHeros
            local enemyPosition = getArmyPosition()
            local count = 1

            dump(enemyArmy)
            for k, v in ipairs(enemyQueue) do
                if v ~= 0 then
                    local heroData = nil
                    if type(v) == "number" then
                        heroData = require("game_model.HeroData").new(BaseData_heros[v])
                        heroData:setLevel(heroLevel)
                        heroData:updataProperty()
                    else
                        heroData = v
                    end
                    battleHeroData = require("battle_system.CBattleHeroData").new({
                        data = heroData,
                        pos  = enemyPosition[k],
                        tag  = k + 100,
                        hp   = heroData:getHp(),
                        sf   = false
                    })
                    enemyArmy[count] = battleHeroData
                    count = count + 1
                end
            end
        end

        local function initAtkOrder()
            local maxHeros = math.max(#ourArmy, #enemyArmy)
            local index, m, n = 1, 1, 1
            for i = 1, maxHeros do
                if (ourArmy[n]) then
                    atkOrder[index] = ourArmy[n]
                    n = n + 1
                    index = index + 1
                end

                if (enemyArmy[m]) then
                    atkOrder[index] = enemyArmy[m]
                    m = m + 1
                    index = index + 1
                end
            end
        end


        local function getTarget(tag)
            local child = nil
            if (tag > 100) then
                tag = tag - 100
                child = attackSearchList:getHitTarget(tag, atkOrder)
            else
                tag = tag + 100
                child = attackSearchList:getHitTarget(tag, atkOrder)
            end
            return child
        end

        local function calculateResult()
            local flag = true
            for i = 1, round do
                flag = true
                for k, v in ipairs(atkOrder) do
                    if (v:isDead() == false) then
                        flag = false
                        local attackedMember = getTarget(v:getTag())
                        if (attackedMember) then
                            self.addItem({
                                atk_A = v,
                                atk_B = attackedMember,
                                delayTime = 2
                            })
                        else
                            flag = true
                            break
                        end
                    end
                end
                if (flag) then
                    break
                end
            end

        end


      ----------------------------------------------------
        initOursHeroData()
        initEnemyHeroData()
        initAtkOrder()
        calculateResult()
        _getWinner()
    end
end


return AttackStruct