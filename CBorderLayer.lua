--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-18
-- Time: 下午3:26
-- To change this template use File | Settings | File Templates.
--

local CBorderLayer = class("CBorderLayer", function()
    return display.newNode()
end)


function CBorderLayer:getLeftWidth( ... )
    return self.leftWidth
end

function CBorderLayer:getLeftHeight( ... )
    return self.leftHeight
end

function CBorderLayer:init(bShowTopBorder, title)
    local leftBorder = require("CLeftBorder").new()
    leftBorder:setPosition(0, 0)
    self.leftWidth = leftBorder:getLeftWidth()
    self.leftHeight = leftBorder:getLeftHeight()
    self:addChild(leftBorder)

    local headerSprite = ResourceMgr:getUISprite("board01")
    headerSprite:setAnchorPoint(CCPointMake(0, 0.5))
    headerSprite:setPosition(leftBorder:getWidth(), display.height - headerSprite:getContentSize().height / 2-CFuncHelper:getTopBarH())
    self:addChild(headerSprite)

    local headerLabel = ui.newTTFLabel({
        text = title or "HelloWorld",
        x = headerSprite:getContentSize().width / 2,
        y = headerSprite:getContentSize().height / 2,
        align = ui.TEXT_ALIGN_CENTER,
        size = 28
    })
    headerSprite:addChild(headerLabel)

    local broadcastSprite = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame("board02"))
    broadcastSprite:setPreferredSize(CCSizeMake(CFuncHelper:getRelativeX(17), CFuncHelper:getRelativeY(3)))
    broadcastSprite:setPosition(CFuncHelper:getRelativeX(22.5), CFuncHelper:getRelativeY(38)-CFuncHelper:getTopBarH())
    broadcastSprite:setAnchorPoint(CCPointMake(0, 0.5))
    self:addChild(broadcastSprite)

    local  scrollLabel = require("ui_common.CScrollLabel").new({
        x = display.width - broadcastSprite:getContentSize().width,
        y =  display.height - broadcastSprite:getContentSize().height-CFuncHelper:getTopBarH(),
        width = broadcastSprite:getContentSize().width * (18.6 / 20),
        height = display.height * (2.3 / 40)
    })
    local disMsg = "broadcastSprite broadcastSprite broadcastSprite"
    self:addChild(scrollLabel, 1000)
    scrollLabel:scroll(disMsg)


end

function CBorderLayer:ctor(bShowTopBorder, title)
    self:init(bShowTopBorder, title)
end

return CBorderLayer