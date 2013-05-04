--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-23
-- Time: 上午11:41
-- To change this template use File | Settings | File Templates.
--

local CBattleHeroData = class("CBattleHeroData")

function CBattleHeroData:ctor(params)

    local _heroData = params.data
    local _pos      = params.pos
    local _tag      = params.tag or -1
    local _hp       = params.hp or 0
    local _bSelf    = params.sf
    local _level    = params.data:getLevel()
    local _tempHp   = params.data:getHp() or 0
    local _exp      = params.data:getExp()
    local _cacheHp  = params.data:getHp() or 0

    self.getExp = function()
        return _exp
    end

    self.getLevel = function()
        return _level
    end

    self.resetHp = function()
        _tempHp = _cacheHp
    end

    self.getTempHp = function()
        return _tempHp
    end

    self.getFullHp = function()
        return _cacheHp
    end

    self.addTempHp = function(self, hp)
        _tempHp = _tempHp + hp
        if (_tempHp < 0) then
            _tempHp = 0
        end
    end

    self.tempIsDead = function()
        if _tempHp < 0.5 then
            return true
        end
        return false
    end

    self.isSelf = function(self)
        return _bSelf
    end

    local _heroSprite = nil

    self.setHeroSprite = function(self, sprite)
        _heroSprite = sprite
    end

    self.getHeroSprite = function()
        return _heroSprite
    end

    ----------------------------------------------
    self.getHeroData = function()
        return _heroData
    end

    self.getPosition = function()
        return _pos
    end

    self.getPositionX = function ( ... )
        return _pos.x
    end

    self.getPositionY = function ( ... )
        return _pos.y
    end

    self.getTag = function()
        return _tag
    end

    self.getHp = function()
        return _hp
    end

    self.addHp = function(self, hp)
        _hp = _hp + hp
        if (_hp < 0) then
            _hp = 0
        end
    end

    self.isDead = function()
        if _hp < 0.5 then
            return true
        end
        return false
    end

end

return CBattleHeroData