
require "GameFormula"
require("data.heros_gs")
require("data.ExpTable_gs")

local CHeroData = class("CHeroData")

function CHeroData:getName()
	return self.m_name
end

function CHeroData:getAnimId()
	return self.m_anim_id
end

function CHeroData:getIconID( )
    return self.m_icon_id
end

function CHeroData:upgrade()
    self.m_level = require("FuncHelper"):addForChaosNum(self.m_level, 1)

    ---混淆数据
    local baseHp = require("FuncHelper"):decryptNum(self.m_hp.base)
    local lv    = require("FuncHelper"):decryptNum(self.m_level)

    self.m_hp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeHP(baseHp, lv))

    self.m_ap.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeAP(
        require("FuncHelper"):decryptNum(self.m_ap.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_mp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeMP(
        require("FuncHelper"):decryptNum(self.m_mp.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_dp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeDP(
        require("FuncHelper"):decryptNum(self.m_dp.base),
        require("FuncHelper"):decryptNum(self.m_level)))
end

function CHeroData:updataProperty()
    ---混淆数据
    local baseHp = require("FuncHelper"):decryptNum(self.m_hp.base)
    local lv    = require("FuncHelper"):decryptNum(self.m_level)

    self.m_hp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeHP(baseHp, lv))

    self.m_ap.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeAP(
        require("FuncHelper"):decryptNum(self.m_ap.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_mp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeMP(
        require("FuncHelper"):decryptNum(self.m_mp.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_dp.real = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeDP(
        require("FuncHelper"):decryptNum(self.m_dp.base),
        require("FuncHelper"):decryptNum(self.m_level)))

end

function CHeroData:setLevel(level)
    self.m_level = require("FuncHelper"):encryptNum( level )
end

function CHeroData:getLevel()
	return require("FuncHelper"):decryptNum(self.m_level)
end

function CHeroData:addExp( exp )
    if self.m_exp < 0 or exp < 0 then
        CCMessageBox("Exp is  < 0", "ERROR")
    end
    self.m_exp = self.m_exp + exp

    while(BaseData_ExpTable[self:getLevel()][self.m_growType] < self.m_exp) do
        printf("成长类型: " .. self.m_growType .. " 当前级别: " .. self:getLevel() .. " 需要经验：" .. BaseData_ExpTable[self:getLevel()][self.m_growType] .. " 共得到的经验: " .. exp)
        self.m_exp = self.m_exp - BaseData_ExpTable[self:getLevel()][self.m_growType]
        self:upgrade()
    end

end

function CHeroData:getExp( ... )
    return self.m_exp
end



function CHeroData:addHp(hp)

    local hpReal = require("FuncHelper"):decryptNum(self.m_hp.real)
--    if (hpReal + hp) > require("FuncHelper"):decryptNum(self.m_hp.base) then
--       self.m_hp.real = self.m_hp.base
--    else
        self.m_hp.real = require("FuncHelper"):encryptNum(hpReal + hp)
--    end
end

function CHeroData:getHp(key)
    local hp = require("FuncHelper"):decryptNum(self.m_hp[key] or self.m_hp.real)
    for k, v in ipairs(self.m_equipment) do
        if v > 0 then
            local equipment = game.Player:getEquipmentById(v)
            if equipment:getEffectType() == EquipmentEffectType.HP then
                hp = hp + equipment:getValue()
                break
            elseif equipment:getEffectType() == EquipmentEffectType.HP_PER then
                hp = hp + hp * (equipment:getValue() / 100)
                break
            end

        end
    end
    return  hp
end

function CHeroData:isDead()
    if (require("FuncHelper"):decryptNum(self.m_hp.real) < 1) then
        return true
    end

    return false
end

function CHeroData:setHp(hp)
    local hpReal = require("FuncHelper"):decryptNum(self.m_hp.real)
    self.m_hp.real = require("FuncHelper"):encryptNum(hp)
end


function CHeroData:addMp(mp)
    local mpReal = require("FuncHelper"):decryptNum(self.m_mp.real)
    if (mpReal + mp) > require("FuncHelper"):decryptNum(self.m_mp.base) then
        self.m_mp.real = self.m_mp.base
    else
        self.m_mp.real = require("FuncHelper"):encryptNum(mpReal + mp)
    end
end

function CHeroData:getMp(key)
    local mp = require("FuncHelper"):decryptNum(self.m_mp[key] or self.m_mp.real)
    for k, v in ipairs(self.m_equipment) do
        if v > 0 then
            local equipment = game.Player:getEquipmentById(v)
            if equipment:getEffectType() == EquipmentEffectType.MAGIC then
                mp = mp + equipment:getValue()
                break
            elseif equipment:getEffectType() == EquipmentEffectType.MAGIC_PER then
                mp = mp + mp * (equipment:getValue() / 100)
                break
            end

        end
    end
    return  mp
end

function CHeroData:addDp(dp)
    local dpReal = require("FuncHelper"):decryptNum(self.m_dp.real)
    if (dpReal + dp) > require("FuncHelper"):decryptNum(self.m_dp.base) then
        self.m_dp.real = self.m_mp.base
    else
        self.m_dp.real = require("FuncHelper"):encryptNum(dpReal + dp)
    end
end

function CHeroData:getDp(key)
	local dp =  require("FuncHelper"):decryptNum(self.m_dp[key] or self.m_dp.real)
    for k, v in ipairs(self.m_equipment) do
        if v > 0 then
            local equipment = game.Player:getEquipmentById(v)
            if equipment:getEffectType() == EquipmentEffectType.DEFENSE then
                dp = dp + equipment:getValue()
                break
            elseif equipment:getEffectType() == EquipmentEffectType.DEFENSE_PER then
                dp = dp + dp * (equipment:getValue() / 100)
                break
            end

        end
    end
    return  dp
end

function CHeroData:addAp(ap)
    local apReal = require("FuncHelper"):decryptNum(self.m_ap.real)
    if (apReal + ap) > require("FuncHelper"):decryptNum(self.m_ap.base) then
        self.m_ap.real = self.m_ap.base
    else
        self.m_ap.real = require("FuncHelper"):encryptNum(apReal + ap)
    end
end

function CHeroData:getAp(key)
    local ap =  require("FuncHelper"):decryptNum(self.m_ap[key] or self.m_ap.real)

    for k, v in ipairs(self.m_equipment) do
        if v > 0 then
            local equipment = game.Player:getEquipmentById(v)
            if equipment:getEffectType() == EquipmentEffectType.ATTACK then
                ap = ap + equipment:getValue()
                break
            elseif equipment:getEffectType() == EquipmentEffectType.ATTACK_PER then
                ap = ap + ap * (equipment:getValue() / 100)
                break
            end

        end
    end
    return ap
end

function CHeroData:getId()
   return self.m_id
end

function CHeroData:getProperty()
    if(self.m_property > 5) then
        -- FIXME
        device.showAlert("", "property ERROR!" .. self.m_id..","..self.m_property)
    end
    return self.m_property
end

function CHeroData:getEquipments()
    local equips = {}
    for k, v in ipairs(self.m_equipment) do
        if v > 0 then
            local equipment = game.Player:getEquipmentById(v)
            if (equipment == nil) then
                CCMessageBox("CHeroData:getEquipments", "ERROR")
            end
            equips[k]  = equipment
        end
    end
    return equips
end

function CHeroData:addEquipment(equipId, index)
    local i = index or #self.m_equipment + 1
    self.m_equipment[i] = equipId
    if (equipId > 0) then
        game.Player:getEquipmentById(equipId):setOwner(self.m_id)
    end
end

function CHeroData:getKungFus()
    local kungFus = {}
    for k, v in ipairs(self.m_skills) do
        if v > 0 then
            local skill = game.Player:getSkillById(v)
            if skill == nil then
                CCMessageBox("CHeroData:getKungFus", "ERROR")
            end
            kungFus[k] = skill
        end
    end

    kungFus[1] = self.m_baseSkill

   return kungFus
end

function CHeroData:addKungFu(kungFuId, index)
    local i = index or #self.m_skills + 1
    self.m_skills[i] = kungFuId
    if kungFuId > 0 then
        game.Player:getSkillById(kungFuId):setOwner(self.m_id)
    end
end

function CHeroData:haveEquipment(eqipId)
    local equipments = self:getEquipments()
    for i = 1, 4 do
        if equipments[i] and equipments[i]:getId() == eqipId then
            return true
        end
    end
    return false
end

function CHeroData:reset()

    local equipments = self:getEquipments()
    for k, v in pairs(equipments) do
        v:setOwner(nil)
    end
    self.m_equipment = {0, 0, 0, 0 }

    local skills = self:getKungFus()
    for k, v in pairs(skills) do
         if (k > 1 and v ~= nil) then
            v:setOwner(nil)
         end
    end
    self.m_skills   = {0, 0, 0, 0}
end

function CHeroData:haveKungFu(kungFuId)
    local kungFus = self:getKungFus()
    for i = 1, 4 do
         if kungFus[i] and kungFus[i]:getId() == kungFuId then
            return true
         end
    end
    return false


end

function CHeroData:init(data)
    --[[
      data = {
          id    = ?,
          exp   = ?,
          level = ?,
          skills= {0, 1, 2, 3},
          extra_ap = ?
          extra_dp = ?
          extra_hp = ?
          extra_mp = ?
          base_skill = {value = ?, level = ?}
      }
    ]]

    self.m_id       = data.id
    self.m_exp      = data.exp or 0
    self.m_skills   = {0, 0, 0, 0}
    self.m_level    = require("FuncHelper"):encryptNum(data.level or 1)
    self.m_equipment= {0, 0, 0, 0}
    self.m_base_skill = data.base_skill or {value = 1, level = 1}
    self.m_bIsMajor     = data.isMajorfalse
    if data.skills then
        for k, v in ipairs(data.skills) do
            self:addKungFu(v, k)
        end
    end

    self.m_extra_ap = data.extra_ap or 0
    self.m_extra_dp = data.extra_dp or 0
    self.m_extra_hp = data.extra_hp or 0
    self.m_extra_mp = data.extra_mp or 0

    self.m_baseSkill = require("game_model.CSkill").new(
        {
            id    = BaseData_heros[self.m_id].skill,
            value = self.m_base_skill,
            level = self.m_base_skill

        })
    --------------------------------------------------------------------------------------


	self.m_name     = BaseData_heros[self.m_id].str_name
	self.m_anim_id  = BaseData_heros[self.m_id].str_anim_id
    self.m_icon_id  = BaseData_heros[self.m_id].str_icon

    --攻
    self.m_ap       = {
        base = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].ap),
        real = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].ap)
    }
	--防
    self.m_dp       = {
        base = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].dp),
        real = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].dp)
    }
    --血
    self.m_hp       = {
        base = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].hp),
        real = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].hp)
    }
    --内
    self.m_mp       = {
        base = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].mp),
        real = require("FuncHelper"):encryptNum(BaseData_heros[self.m_id].mp)
    }

	self.m_growType     = BaseData_heros[self.m_id].str_growType
	self.m_matchid      = BaseData_heros[self.m_id].matchid
	self.m_property     = BaseData_heros[self.m_id].property

end


function CHeroData:setIsMajor(b)
    self.m_bIsMajor = b
end

function CHeroData:getState()
     if self.m_bIsMajor then
        return "已上场", true
     else
        return "", false
     end
end

function CHeroData:ctor(data)
	self:init(data)
end


--[[
    将hero的基本数值，转换成服务器存贮需求数据结构
]]
function CHeroData:genUploadHero( opt )
    local hero = {}

    hero.opt = opt

    hero.id = self:getId()
    hero.lv = self:getLevel()
    hero.extra = {ap = self.m_extra_ap, dp = self.m_extra_dp,
                  hp = self.m_extra_hp, mp = self.m_extra_mp}
    hero.exp = self.exp or 0
    hero.equip = {}   -- equip
    hero.skill = {} -- skill
    hero.baseSkill = self.m_base_skill or {}
    return hero
end



return CHeroData