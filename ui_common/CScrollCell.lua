--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 下午3:19
-- To change this template use File | Settings | File Templates.
--

local CScrollCell = class("CScrollCell", function()
    return display.newNode()
end)

function CScrollCell:onTouch(obj)
     if (self.bIsEnable) then
         if (type(self.touchListener) == "function") then
             self:touchListener(obj)
         end
     end
end

function CScrollCell:setEnable(b)
    if b then
        self.sprite:setColor(ccc3(255, 255, 255))
    else
        self.sprite:setColor(ccc3(100, 100, 100))
    end
    self.bIsEnable = b
end

function CScrollCell:getData()
    return self.sprite:getHeroData()
end

function CScrollCell:getContentSize()
    return self.sprite:getContentSize()
end

function CScrollCell:setTouchListener(listener)
    self.touchListener = listener
end

function CScrollCell:boundingBox()
    return self.sprite:boundingBox()
end

function CScrollCell:setColor(color)
    if (self.bIsEnable) then
        self.sprite:setColor(color)
    end
end


function CScrollCell:ctor(sprite)
    self.sprite = sprite
    sprite:setPosition(0, 0)
    self:addChild(self.sprite)

    self.bIsEnable = true
end

return CScrollCell

