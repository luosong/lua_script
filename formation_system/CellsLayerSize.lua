

local CCellsLayerSize = {
	layerWidth        = 0,        
	layerHeight       = 0,
	cellWidth         = 0,
	cellHeight        = 0,
	baseX             = 0,
	baseY             = 0
}

function CCellsLayerSize:init()
	self.layerWidth = display.width / 2
    self.layerHeight = display.height / 2
    self.cellWidth = self.layerWidth / 3
    self.cellHeight = self.layerHeight / 3
    self.baseX = display.width * (3 / 4) + self.layerWidth / 2 - self.cellWidth / 2
	self.baseY = display.height * (18 / 40) + self.layerHeight / 2 - self.cellHeight / 2
end

function CCellsLayerSize:getMidPos()
	return display.width * (3 / 4) - self.layerWidth / 2, display.height * (18 / 40) - self.layerHeight / 2
end

function CCellsLayerSize:getCellsPos()
    local pos = {}
    for i = 1, 9 do
        pos[i] = CCPointMake(self.baseX - self.cellWidth * math.floor((i - 1) / 3) - ((i - 1) % 3) * (self.layerWidth * (1 / 16)),
            self.baseY - self.cellHeight * ((i - 1) % 3))
    end
    return pos
end


CCellsLayerSize:init()
return CCellsLayerSize