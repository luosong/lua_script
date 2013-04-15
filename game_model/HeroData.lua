
require "GameFormula"
require("data.heros_gs")

local CHeroData = class("CHeroData")

--function CHeroData:setLocation(x)
--	self.m_location = x
--end
--
--function CHeroData:getLocation()
--	return self.m_location
--end

function CHeroData:getName()
	return self.m_name
end

function CHeroData:getAnimId()
	return self.m_anim_id
end

function CHeroData:getIconID( )
    return self.m_icon_id
end

function CHeroData:setLevel(level)
    self.m_level = require("FuncHelper"):encryptNum( level )
end

function CHeroData:getLevel()
	return require("FuncHelper"):decryptNum(self.m_level)
end

function CHeroData:upgrade()
    self.m_level = require("FuncHelper"):addForChaosNum(self.m_level, 1)

    ---混淆数据
    self.m_hp.base = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeHP(
        require("FuncHelper"):decryptNum(self.m_hp.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_ap.base = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeAP(
        require("FuncHelper"):decryptNum(self.m_ap.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_mp.base = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeMP(
        require("FuncHelper"):decryptNum(self.m_mp.base),
        require("FuncHelper"):decryptNum(self.m_level)))

    self.m_dp.base = require("FuncHelper"):encryptNum(GameFormula.GetUpgradeDP(
        require("FuncHelper"):decryptNum(self.m_dp.base),
        require("FuncHelper"):decryptNum(self.m_level)))
end

function CHeroData:addHp(hp)
    local hpReal = require("FuncHelper"):decryptNum(self.m_hp.real)
    if (hpReal + hp) > require("FuncHelper"):decryptNum(self.m_hp.base) then
       self.m_hp.real = self.m_hp.base
    else
        self.m_hp.real = require("FuncHelper"):encryptNum(hpReal + hp)
    end
end

function CHeroData:getHp(key)
    return require("FuncHelper"):decryptNum(self.m_hp[key] or self.m_hp.real)
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
	return require("FuncHelper"):decryptNum(self.m_mp[key] or self.m_mp.real)
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
	return require("FuncHelper"):decryptNum(self.m_dp[key] or self.m_dp.real)
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
    local a =  require("FuncHelper"):decryptNum(self.m_ap[key] or self.m_ap.real)
    return require("FuncHelper"):decryptNum(self.m_ap[key] or self.m_ap.real)
end

function CHeroData:getId()
   return self.m_id
end

function CHeroData:getProperty()
    return self.m_property
end

function CHeroData:getEquipments()
    return self.m_equipment
end

function CHeroData:addEquipment(equip, index)
    local i = index or #self.m_equipment + 1
    self.m_equipment[i] = equip
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
    self.m_exp      = data.exp
    self.m_skills   = {0, 0, 0, 0}
    self.m_level    = require("FuncHelper"):encryptNum(data.level or 1)
    self.m_equipment= {}
    self.m_base_skill = data.base_skill or {value = 1, level = 1}

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

function CHeroData:ctor(data)
	self:init(data)
end


--[[

]]
function CHeroData:genUploadHero( opt )
    local hero = {}

    hero.opt = opt

    hero.id = self:getId()
    hero.lv = self:getLevel()
    hero.extra = {ap = self.m_extra_ap, dp = self.m_extra_dp,
                  hp = self.m_extra_hp, mp = self.m_extra_mp}
    hero.exp = self.exp
    hero.equip = {}   -- equip
    hero.skill = {} -- skill

    return hero
end

return CHeroData