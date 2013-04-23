require("data.formations_gs")

local CPlayer = class("CPlayer")

function CPlayer:addSoul(id, num)
    if (self.m_heroSouls[id] == nil) then
        self.m_heroSouls[id] = {}
        self.m_heroSouls[id].num = 0
    end
    self.m_heroSouls[id].num = self.m_heroSouls[id].num + num
end

function CPlayer:getSouls()
    return self.m_heroSouls
end

function CPlayer:getSoulNum( id )
    if(self.m_heroSouls[id] ~= nil) then
        return self.m_heroSouls[id].num
    end

    return 0
end

function CPlayer:getSoulData( id )
    if(self.m_heroSouls[id] ~= nil) then
        return {id=id,num=self.m_heroSouls[id].num}
    end
    return {}
end

function CPlayer:setLevelStar(level, subLevel, star)
    self.m_unlock_levels[level][subLevel] = star

    if star > 0 then
        if (self.m_unlock_levels[level][subLevel + 1]) == nil then

            if (#levels[level] >= subLevel + 1) then
                self:addUnLockLevel(level, subLevel + 1)
            else
                if (#levels >= level + 1) then
                    self:addUnLockLevel(level + 1, 1)
                else
                    CCMessageBox("游戏尽头", "ERROR")
                end
            end
        end
    end
end

function CPlayer:addUnLockLevel(level, subLevel)

    if (self.m_unlock_levels[level] == nil) then
        self.m_unlock_levels[level] = {}
    end

    self.m_unlock_levels[level][subLevel] = 0
end



function CPlayer:getStarsById(level, subLevel)
    if self.m_unlock_levels[level] then
        return self.m_unlock_levels[level][subLevel] or 0
    end

    return 0
end

function CPlayer:isLevelUnlock(level, subLevel)
    if self.m_unlock_levels[level] and self.m_unlock_levels[level][subLevel] ~= nil then
        return true
    end
    return false
end

function CPlayer:setCurrentLevel(level, subLevel)
    self.m_currentLevel.level    = level
    self.m_unlock_levels[level][subLevel] = subLevel
end

function CPlayer:ctor()
    self.m_name  = "" --
    self.m_title = "" -- 头衔

    self.m_heros      = {} --所有成员
    self.m_heroSouls  = {}
    self.m_majorHeros = {0, 0, 0, 0, 0, 0} --主力成员

    self.m_level  = 0 -- 等级
    self.m_exp    = 0 -- 玩家经验
    self.m_gold   = 0 -- 金元宝
    self.m_silver = 0 -- 银子
    self.m_energy = 0 -- 体力

    self.m_unlock_levels = {}
    self.m_equipments    = {}
    self.m_skills        = {}

    self.m_package = {} -- 背包
    self.m_mails   = {} -- 邮件
    self.m_friends = {} -- 好友

    self.m_formation = {}
    self.m_currentFormationId = 1
    self.m_queueType = 1

    self.m_arena    = {} -- 武林大会

    self.m_serverID = 1 --
    self.m_thirdID  = ""
    self.m_uid      = ""
    self.m_playerID = ""
    self.m_recruit  = {}
    self.m_collections = { { 1, 3, 8, 9 }, { 2, 5, 6 }, { 3, 4, 8 } }

    self:addUnLockLevel(1, 1)
    self.m_currentLevel = {1, 1}
end

function CPlayer:getCurrentFormationId()
    return self.m_currentFormationId
end

function CPlayer:setCurrentFormationId(id)
    self.m_currentFormationId = id or 1
end

--[[
    进入游戏，向服务器发送基本信息，服务器验证
]]
function CPlayer:GetLoginDateSendToServer()
    local msg = {}
    msg[KEY_CONST["SERVER_ID"]] = game.Player:getServerID()
    msg[KEY_CONST["PLAYER_ID"]] = game.Player:getPlayerID()
    msg[KEY_CONST["THIRD_ID"]] = game.Player:getThirdID()
    msg[KEY_CONST["NICKNAME"]] = game.Player:getName()

    return msg
end

function CPlayer:getFriends()
    return self.m_friends
end

function CPlayer:addFriend(friend)
    self.m_friends = self.m_friends[#self.m_friends]
end

function CPlayer:getPackage()
    return self.m_package
end

function CPlayer:addToPackage(p)
    self.m_package[#self.m_package + 1] = p
end

function CPlayer:getSkills()
    return self.m_skills
end

function CPlayer:getSkillById(id)
    local skill = nil
    for k, v in ipairs(self.m_skills) do
         if (id == v:getId()) then
            skill = v
         end
    end
    return skill
end

function CPlayer:addSkill(skill)
    self.m_skills[#self.m_skills + 1] = skill
end

function CPlayer:addEquipment(equip)
    self.m_equipments[#self.m_equipments + 1] = equip
end

function CPlayer:getEquipments()
    return self.m_equipments
end

function CPlayer:getEquipmentById(id)
    local equip = nil
    for k, v in ipairs(self.m_equipments) do
        if (id == v:getId()) then
            equip = v
        end
    end
    return equip
end

function CPlayer:setQueueType(id)
    self.m_queueType = id
end

function CPlayer:getQueueType()
    return self.m_queueType
end


function CPlayer:getMajorHerosId()
    return self.m_majorHeros
end

function CPlayer:getHeroById(id)
    local hero = nil
    for k, v in ipairs(self.m_heros) do
        if id == v:getId() then
            hero = v
            break
        end
    end
    return hero
end

function CPlayer:getMajorHeros()
    local majorHeros = {}
    for k, v in ipairs(self.m_majorHeros) do
        local hero = self:getHeroById(v)
        if (v > 0 and hero == nil) then
            CCMessageBox("CPlayer:getMajorHeros", "ERROR")
        end
        if (hero) then
            majorHeros[#majorHeros + 1] = hero
        end
    end

    return majorHeros
end

function CPlayer:addMajorHero(d, index)
    if (d > 0) then
        local hero = self:getHeroById(d)
        if hero then
            if (index > 6) then
                CCMessageBox("addMajorHero.index > 6", "ERROR")
            end
            local majorHero = self:getMajorHeroById(self.m_majorHeros[index])
            if ( majorHero) then
                majorHero:setIsMajor(false)
            end
            self.m_majorHeros[index] = d
            hero:setIsMajor(true)
        else
            CCMessageBox("addMajorHero>id error", "ERROR")
        end
    end
end

function CPlayer:removeMagorHeros(id)

    for k, v in ipairs(self.m_majorHeros) do
        if (v == id) then
            local hero = self:getHeroById(d)
            if hero then
                table.remove(self.m_majorHeros, k)
                hero:setIsMajor(false)
            else
                CCMessageBox("removeMagorHeros>id error", "ERROR")
            end
            break
        end
    end
end

function CPlayer:addFormation(form)
    self.m_formation[form:getId()] = form
end

function CPlayer:getFormationById(id)
    return self.m_formation[id]
end

function CPlayer:getCurrentFormation()

    return self.m_formation[self.m_currentFormationId]
end

function CPlayer:getFormations()
    return self.m_formation
end

function CPlayer:setTitle(title)
    self.m_title = title
end

function CPlayer:getTitle()
    return self.m_title
end

function CPlayer:setName(name)
    self.m_name = name
end

function CPlayer:getName()
    return self.m_name
end

function CPlayer:setSilver(money)
    self.m_silver = require("FuncHelper"):encryptNum(money)
end

function CPlayer:getSilver()
    return require("FuncHelper"):decryptNum(self.m_silver)
end

function CPlayer:addHero(data)
    self.m_heros[#(self.m_heros) + 1] = data
end

function CPlayer:getHeros()
    return self.m_heros
end

-- 是否已经添加过该英雄，如果有，则添加碎片
function CPlayer:HasAddHero( heroid )

    local hero = self:getHeroById(heroid)

    if(hero ~= nil) then
        return true
    end

    
    return false
end


function CPlayer:getMajorHeroById(id)
    local heroId = nil
    for k, v in ipairs(self.m_majorHeros) do
        if (v == id) then
            heroId = v
            break
        end
    end

    for k, v in ipairs(self.m_heros) do
        if (heroId == v:getId()) then
             return v
        end
    end

    return nil
end


function CPlayer:setRecruit(id, data)
    self.m_recruit[id] = data
end

function CPlayer:getRecruit()
    return self.m_recruit
end

function CPlayer:save()
end

function CPlayer:setLevel(level)
    self.m_level = require("FuncHelper"):encryptNum(level)
end

function CPlayer:getLevel()
    return require("FuncHelper"):decryptNum(self.m_level)
end

--升级
function CPlayer:upgrade()
    self.m_level = require("FuncHelper"):addForChaosNum(self.m_level, 1)
end

function CPlayer:setExp(exp)
    self.m_exp = require("FuncHelper"):encryptNum(exp)
end

function CPlayer:getExp()
    return require("FuncHelper"):decryptNum(self.m_exp)
end

function CPlayer:setGold(gold)
    self.m_gold = require("FuncHelper"):encryptNum(gold)
end

function CPlayer:getGold()
    return require("FuncHelper"):decryptNum(self.m_gold)
end

function CPlayer:getServerID()
    return self.m_serverID
end

function CPlayer:setServerID(serverID)
    self.m_serverID = serverID
end

function CPlayer:getPlayerID()
    return self.m_playerID
end

function CPlayer:setPlayerID(playerID)
    -- body
    self.m_playerID = playerID
end

function CPlayer:setThirdID(thirdID)
    self.m_thirdID = thirdID
end

function CPlayer:getThirdID()
    return self.m_thirdID
end


function CPlayer:setUID(uid)
    self.m_uid = uid
end

function CPlayer:getUID()
    return self.m_uid
end

function CPlayer:setEnergy(energy)
    self.m_energy = energy
end

function CPlayer:getEnerty()
    return self.m_energy
end

function CPlayer:getCollections(itemType)
    return self.m_collections[itemType]
end

--[[ class end ]]
return CPlayer
