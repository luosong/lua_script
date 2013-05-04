--
-- Created by shan
-- Date: 13-3-20
-- Time: 下午6:38
--
local CEquip = class("CEquip")

function CEquip:getName()
    return self.m_name
end

function CEquip:getId()

    return self.m_id
end

function CEquip:getLevel( ... )
    return self.m_level
end

function CEquip:upgrade(value)
    self.m_level = self.m_level + 1
    self.m_value = self.m_value + value
end

function CEquip:getDesc()
    return self.m_des
end

function CEquip:getType()
    return self.m_equip_type
end

function CEquip:getValue()

    return self.m_value
end

function CEquip:setValue(v)
    self.m_value = v
end

function CEquip:addValue(v)
    self.m_value = self.m_value + v
end

function CEquip:getProperty()

    return self.m_property
end

function CEquip:getIcon()
    return self.m_icon
end

function CEquip:getEffectType()
    return self.m_effect_type
end

function CEquip:getEffect()
    local name = ""
    if EquipmentEffectType.ATTACK == self.m_effect_type then
        name = "攻 " .. tostring(self.m_value)
    elseif  EquipmentEffectType.ATTACK_PER == self.m_effect_type then
        name = "攻 %" .. tostring(self.m_value)
    elseif EquipmentEffectType.DEFENSE == self.m_effect_type then
        name = "防".. tostring(self.m_value)
    elseif  EquipmentEffectType.DEFENSE_PER == self.m_effect_type then
        name = "防 %".. tostring(self.m_value)
    elseif EquipmentEffectType.HP == self.m_effect_type then
        name = "血" .. tostring(self.m_value)
    elseif EquipmentEffectType.HP_PER == self.m_effect_type then
        name = "血 %" .. tostring(self.m_value)
    elseif EquipmentEffectType.MAGIC == self.m_effect_type then
        name = "内" .. tostring(self.m_value)
    elseif  EquipmentEffectType.MAGIC_PER == self.m_effect_type then
        name = "内 %" .. tostring(self.m_value)
    end

    return name
end

function CEquip:setOwner(id)
    self.m_ownerId = id
end

function CEquip:getOwner()
    return game.Player:getMajorHeroById(self.m_ownerId)
end

function CEquip:getStatus()
    local status = "未装备"
    local bIsEquip = false
    if self.m_ownerId then
        status = "装备于 " .. self:getOwner():getName()
        bIsEquip = true
    end

    return status, bIsEquip
end

function CEquip:getAnimId()
    return self.m_anim_id
end

function CEquip:ctor(data)
    self.m_id           = data.id
    self.m_value        = data.value
    self.m_level        = 1


    self.m_icon         = data.str_icon
    self.m_anim_id      = data.str_anim_id
	self.m_name         = data.str_name
    self.m_des          = data.str_des
	self.m_equip_type   = data.equip_type
    self.m_effect_type  = data.effect_type

	self.m_matchid      = data.matchid
    self.m_property     = data.property

    self.m_ownerId        = nil

end


--[[
    生成可以上传的数据类型，根据opt类型
]]
function CEquip:genUploadEquip( opt )
    local equip = {}
    equip.opt = opt
    equip.id = self:getId()    
    equip.ev = self:getEffect()
    equip.lv = self:getLevel()

    return equip
end

return CEquip