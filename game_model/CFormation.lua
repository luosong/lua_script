--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-10
-- Time: 下午5:28
-- To change this template use File | Settings | File Templates.
--
require("data.formations_gs")
local CFormation = class("CFormation")

function CFormation:ctor(data)
    self.m_id          = data[1] or 1
    self.m_level       = data[2] or 1
    self.m_herosID     = data[3] or {0, 0, 0, 0, 0, 0, 0, 0, 0}



    self.m_str_name    = BaseData_formations[self.m_id].str_name
    self.m_unlockLevel = BaseData_formations[self.m_id].unlockLevel
    self.m_effectType1 = BaseData_formations[self.m_id].effectType1
    self.m_value1      = BaseData_formations[self.m_id].value1
    self.m_effectType2 = BaseData_formations[self.m_id].effectType2
    self.m_value2      = BaseData_formations[self.m_id].value2
    self.m_str_icon    = BaseData_formations[self.m_id].str_icon
    self.m_form        = BaseData_formations[self.m_id].form

    self.m_heros       = {0, 0, 0, 0, 0, 0, 0, 0, 0}
end

function CFormation:getHerosId()
    return self.m_herosID
end


function CFormation:getId()
    return self.m_id
end

function CFormation:resetForm()
    for k, v in ipairs(self.m_heros) do
         self.m_heros[k] = 0
    end
end

function CFormation:getName()
    return self.m_str_name
end

function CFormation:getIcon()
    return self.m_str_icon
end

function CFormation:getForm()
     return self.m_form
end

function CFormation:getHerosOnForm()
    local ret = {}
    for k, v in ipairs(self.m_heros) do
        if v ~= 0 then
            ret[#ret + 1] = v
        end
    end

    return ret
end

function CFormation:isSetForm()
    local ret = false
    for k, v in ipairs(self.m_heros) do
         if v ~= 0 then
            ret = true
             break
         end
    end
    return ret
end

function CFormation:getHeroByIndex(index)
    return self.m_heros[index]
end

function CFormation:setHero(index, hero)
    self.m_heros[index] = hero
end

function CFormation:getHeros()
    return self.m_heros
end




return CFormation