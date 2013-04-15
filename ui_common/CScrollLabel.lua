--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-30
-- Time: 下午5:46
-- To change this template use File | Settings | File Templates.
--

local CScrollLabel = class("CScrollLabel", function(param)
    return display.newClippingRegionNode(CCRectMake(param.x, param.y, param.width, param.height))
end
)

function CScrollLabel:scroll(text)
    self.label:setString(text)
    self.label:setPosition(self.x, self.y)

    local function onComplete()
        self.label:stopAllActions()
        self.label:removeAllChildrenWithCleanup(true)
        self:scroll(text)
    end

    action = transition.sequence({
        CCMoveTo:create(7, CCPointMake(self.x - self.label:getContentSize().width - self.width, self.y)),
        CCCallFunc:create(onComplete),
    })
    self.label:runAction(action)
end

function CScrollLabel:init(param)
   self.x = param.x + param.width
   self.y = param.y + param.height / 2
   self.width = param.width
   self.height = param.height


   self.label = ui.newTTFLabel({
       text = "",
       size = 28,
       color = ccc3(255, 255, 255)
   })
   self.label:setAnchorPoint(CCPointMake(0, 0.5))
   self.label:setPosition(self.x, self.y)

    self:addChild(self.label)
end

function CScrollLabel:ctor(param)

    self:init(param)
end

return CScrollLabel

