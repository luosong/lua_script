--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-20
-- Time: 下午2:21
-- To change this template use File | Settings | File Templates.
--

local AttackStruct = class("AttackStruct")

function AttackStruct:ctor()

    local items = {}
    self.addItem = function(item)
        local itemData = {}
        itemData.id_A      = item.atk_A
        itemData.id_B      = item.atk_B
        itemData.delayTime = item.delayTime
        itemData.cutHP     = item.cutHP
        items[#items + 1] = itemData
    end

    -----------------------------------------------------
    self.getResult = function()
        return items
    end

    self.generateAtkList = function()

        local ourArmy = {}
        local enemyArmy = {}
        local enemyPosition = getArmyPosition()

        local function initOursHeroData()
            local form = game.Player:getCurrentFormation()
            local ourPosition = getOutPositon()
            local counter = 1
            for k, v in ipairs(form:getHeros()) do
                if (v ~= 0) then
                    local heroData = {
                        data = v,
                        pos  = ourPosition[k],
                        tag  = k
                    }
                    ourArmy[counter] = heroData
                    counter = counter + 1
                end
            end
        end

        local function initEnemyHeroData()

        end

--        local function loadEnemyArmy()
--            math.randomseed(os.time())
--            local count = 1
--
--            local enemyQueue = levels[1][1].form
--            for k, v in ipairs(enemyQueue) do
--                if v >= 1 then
--                    enemys[k] = require("game_model.HeroData").new(BaseData_heros[v])
--                    self.enemyArmySprite[count] = require("battle_system.CHeroSprite").new( enemys[k], "card")
--                    self.enemyArmySprite[count]:setPosition(enemyArmyPosition[k])
--                    self.enemyArmySprite[count]:setTag(k + 100)
--                    self.enemyMembersNode:addChild(self.enemyArmySprite[count])
--
--                    local n = ui.newTTFLabel({
--                        text = (k + 100),
--                        size = 20,
--                        color = ccc3(0, 255, 0),
--                        align = ui.TEXT_ALIGN_CENTER
--                    })
--                    self.enemyArmySprite[count]:addChild(n)
--                    count = count + 1
--                end
--            end
--            if (self.enemyArmySprite[1]) then
--                cardOffset = self.enemyArmySprite[1]:getContentSize().width
--            end
--            self.atkTotalCount = (ourArmyCount + #self.enemyArmySprite) * maxRound
--        end

    end
end

return AttackStruct