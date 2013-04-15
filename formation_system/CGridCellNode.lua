
local cellLayerSize = require("formation_system.CellsLayerSize")

-- local CGridCellSprite = {
-- 	layer   = nil,
-- 	isEmpty = true
-- }

local CGridCellNode = class("CGridCellNode", function()
	return display.newNode()
end)

function CGridCellNode:init()
	self.layer = ResourceMgr:getUISprite("bagua2")
    --self.layer:setOpacity(170)
    --CCLayerColor:create(ccc4(0, 100, 0, 255), cellLayerSize.cellWidth - 2, cellLayerSize.cellHeight - 2)
	self.isEmpty = true
end

function CGridCellNode:setDisplayFrame(frame)
    self.layer:setDisplayFrame(frame)
end

function CGridCellNode:setEmpty(b)
	self.isEmpty = b
end

function CGridCellNode:runAction(action)
    self.layer:runAction(action)
end

function CGridCellNode:stopAllActions()

    self.layer:stopAllActions()
end

function CGridCellNode:setAnchorPoint(pos)
    self.layer:setAnchorPoint(pos)
end

function CGridCellNode:getContentSize()
    return self.layer:getContentSize()
end

function CGridCellNode:getEmpty()
	return self.isEmpty
end

function CGridCellNode:setPosition(x, y)
	self.layer:setPosition(x, y)
end

function CGridCellNode:boundingBox()

	return self.layer:boundingBox()
end

function CGridCellNode:setColor(color)
	self.layer:setColor(color)
end

function CGridCellNode:getPosition()
	return self.layer:getPosition()
end

function CGridCellNode:getLayer()
	return self.layer
end

function CGridCellNode:ctor()
	self:init()
end

return CGridCellNode