--
-- Created by shan
-- Date: 13-3-20
-- Time: 下午6:38
--
local CSkill = class ("CSkill")

function CSkill:getId()
    return self.m_id
end

function CSkill:getName()
    return self.m_name
end

function CSkill:getType()
   return self.m_type
end

function CSkill:getValue()
    return self.m_value
end

function CSkill:getAttackType()
    return self.m_attackType
end

function CSkill:getProperty()
    return self.m_property
end

function CSkill:getMatchId()
    return self.self.m_matchid
end

function CSkill:getIcon()
    return self.m_icon
end

function CSkill:setOwner(id)
    self.m_ownerId = id
end


function CSkill:getOwner()
    return game.Player:getMajorHeroById(self.m_ownerId)
end

function CSkill:getStatus()
    local status = "未装备"
    local bIsEquip = false

    if self.m_ownerId then
        status = "装备于 " .. self:getOwner():getName()
        bIsEquip = true
    end

    return status, bIsEquip
end

function CSkill:setBaseSkill(b)
    self.m_bIsBaseSkill = b
end

function CSkill:isBaseSkill()
    return self.m_bIsBaseSkill
end

function CSkill:getLevel()
    return self.m_level
end

function CSkill:getAnimId()
    return self.m_anim_id
end

function CSkill:getProbability()
    return self.m_probability
end

function CSkill:ctor(data)
	-- body
        --[[{   上传服务器数据
                id = ?,
             value = ?
             level = ?
        --}]]
    self.m_id   = data.id
    self.m_value = data.value or 1
    self.m_level = data.level or 1

	self.m_name = BaseData_skills[self.m_id].str_name
	self.m_type = BaseData_skills[self.m_id].skill_type

	self.m_attackType = BaseData_skills[self.m_id].attackType
	self.m_property   = BaseData_skills[self.m_id].property
	self.m_matchid    = BaseData_skills[self.m_id].matchid
    self.m_icon       = BaseData_skills[self.m_id].str_icon
    self.m_anim_id    = BaseData_skills[self.m_id].str_anim_id

    self.m_probability = nil
    self.m_ownerId = nil
    self.m_bIsBaseSkill = false
end


--[[
    生成可以上传的数据类型，根据opt类型
]]
function CSkill:genUploadSkill( opt )
    local skill = {}
    skill.opt = opt
    skill.id = self:getId()
    skill.ev = self:getValue()
    skill.lv = self:getLevel();

    return skill
end


--[[ class end ]]
return CSkill