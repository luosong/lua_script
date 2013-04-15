--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-15
-- Time: 下午2:24
-- To change this template use File | Settings | File Templates.
--

require("data.levels_gs")

local CLevel = class("CLevel")

function CLevel:getStarsById(id)
    return self.m_subLevelId[id] or 0
end

function CLevel:getId()
    return self.m_id
end

function CLevel:ctor(data)
    self.m_id         = data.id or 1
    self.m_subLevelId = {}

    for k, v in ipairs(data.subLevel) do
        m_subLevelId[k] = v
    end

end

return CLevel