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

function CEquip:setOwner(owner)
    self.m_owner = owner
end

function CEquip:getOwner()
    return self.m_owner
end

function CEquip:getStatus()
    local status = "未装备"
    local bIsEquip = false
    if self.m_owner then
        status = "装备于 " .. self.m_owner:getName()
        bIsEquip = true
    end

    return status, bIsEquip
end

function CEquip:ctor(data)
    self.m_id           = data.id
    self.m_icon         = data.str_icon
	self.m_name         = data.str_name
    self.m_des          = data.str_des
	self.m_equip_type   = data.equip_type
    self.m_effect_type  = data.effect_type
	self.m_value        = data.value
	self.m_matchid      = data.matchid
    self.m_property     = data.property

    self.m_owner        = nil

end


return CEquip