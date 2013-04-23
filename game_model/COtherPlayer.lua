--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-22
-- Time: 下午7:00
-- To change this template use File | Settings | File Templates.
--

local COtherPlayer = class("COtherPlayer")


function COtherPlayer:ctor(data)
    local _name       = data.name or ""   --名字
    local _majorHeros = data.majorHeros --主力成员
    local _level      = data.level or 1 -- 等级
    local _equipments = data.equipments  --装备
    local _skills     = data.skills  --技能
    local _formation  = data.formation      --阵法
    local _ranking    = data.ranking or 1

    local _serverID = 1
    local _thirdID  = ""
    local _uid      = ""
    local _playerID = ""

    --------------------存取方法-------------------------
    self.getName = function(self)
       return _name
    end

    self.setName = function(self, name)
        _name = name
    end

    self.getMajorHeros = function(self)
        return _majorHeros
    end

    self.setMajorHeros = function(self, majorHeros)
        _majorHeros = majorHeros
    end

    self.setLevel = function(self, level)
        _level = level
    end

    self.getLevel = function(self)
        return _level
    end

    self.setEquipments = function(self, equipments)
        _equipments = equipments
    end

    self.setSkills = function(self, skills)
        _skills = skills
    end

    self.setFormation = function(self, formation)
        _formation = formation
    end

    self.getFormation = function(self)
        return _formation
    end

    self.setServerId = function(self, id)
        _serverID = id
    end

    self.getServerId = function(self)
        return _serverID
    end

    self.setThirdId = function(self, id)
        _thirdID = id
    end

    self.getThirdId = function(self)
        return _thirdID;
    end

    self.setUId = function(self, id)
        _uid = id
    end

    self.getUId = function(self)
        return _uid
    end

    self.getPlayerId = function(self)
        return _playerID
    end

    self.setPlayerId = function(self, id)
        _playerID = id
    end

    self.setRanking = function(self, ranking)
        _ranking = ranking
    end

    self.getRanking = function(self)
        return _ranking
    end
end

return COtherPlayer

