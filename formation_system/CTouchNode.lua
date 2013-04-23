

require("Animation")


local CTouchNode = class("CTouchNode", function()
	return display.newLayer()
    --return CCLayerColor:create(ccc4(0, 0, 100, 256), display.width / 10 - 3, display.height / 8 - 8)
end)

function CTouchNode:init(heroSprite)

	local contentSize = CCSizeMake(display.width / 10 - 3, display.height / 8 - 8)
	self:setContentSize(CCSizeMake(contentSize.width, contentSize.height))
    self:setAnchorPoint(CCPointMake(0.5, 0.5))
	self.sprite = heroSprite
	self.sprite:setPosition(CCPointMake(contentSize.width / 2, contentSize.height / 2))
	self:addChild(self.sprite)


	--触摸消息处理
	local function onTouch(eventType, x, y)

		if eventType == "began" then
			if CCRectMake(0, 0, contentSize.width, contentSize.height):containsPoint(self:convertToNodeSpace(CCPointMake(x, y))) then
				if (self.touchTarget ~= nil) then
					self:touchTarget(eventType, x, y, self.sprite:getData())
				end
				return true
			else
				return false
			end
        end
    end
    self:setTouchEnabled(true)
	self:registerScriptTouchHandler(onTouch, false, -129)

    self:registerScriptHandler(function(action)

        if action == "exit" or action == "cleanup" then

            self:unregisterScriptTouchHandler()
            self.touchTarget = nil
            self:removeAllChildrenWithCleanup(true)
        end
    end)
end

function CTouchNode:getHeroData()
	return self.sprite:getData()
end

function CTouchNode:setTouchTarget(target)
	self.touchTarget = target
end

function CTouchNode:setColor(color)
	self.sprite:setColor(color)
end

function CTouchNode:setSelect(b)
	self.select = b
end

function CTouchNode:getSelect()
	return self.select
end

function CTouchNode:setOpacity(opacity)
	self.sprite:setOpacity(opacity)
end


function CTouchNode:ctor(heroSprite)
	self.select = false
	self:init(heroSprite)
end

return CTouchNode