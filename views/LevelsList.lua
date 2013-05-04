
local LevelsListCell = require("views.LevelsListCell")

local PageControl = require("ui.PageControl")
local LevelsList = class("LevelsList", PageControl)

LevelsList.INDICATOR_MARGIN = 46

function LevelsList:ctor(rect,inData, visiableArray, itemType ,startY)
    self.super.ctor(self, rect, PageControl.DIRECTION_HORIZONTAL)

    -- add cells
    local rows, cols = 3, 5
    if display.width > 1024 then cols = cols + 1 end

    local Levels = inData --require("data.Levels")
    local numPages = math.ceil(Levels.ArrayCount() / (rows * cols))
    local levelIndex = 1

    for pageIndex = 1, numPages do
        local endLevelIndex = levelIndex + (rows * cols) - 1
        if endLevelIndex > Levels.ArrayCount() then
            endLevelIndex = Levels.ArrayCount()
        end
        local cell = LevelsListCell.new(CCSize(rect.size.width, rect.size.height-60), levelIndex, 
            endLevelIndex, rows, cols, inData, rect, visiableArray, itemType, startY)
        cell:addEventListener("onTapLevelIcon", function(event) return self:onTapLevelIcon(event) end)
        self:addCell(cell)
        levelIndex = endLevelIndex + 1
    end

    -- add indicators
    local x = (self:getClippingRect().size.width - LevelsList.INDICATOR_MARGIN * (numPages - 1)) / 2 + 50
    local y = self:getClippingRect().origin.y + 10

    self.indicator_ = display.newSprite("#LevelListsCellSelected.png")
    self.indicator_:setPosition(x, y)
    self.indicator_.firstX_ = x

    for pageIndex = 1, numPages do
        local icon = display.newSprite("#LevelListsCellIndicator.png")
        icon:setPosition(x, y)
        self:addChild(icon)
        x = x + LevelsList.INDICATOR_MARGIN
    end

    self:addChild(self.indicator_)
end

function LevelsList:scrollToCell(index, animated, time)
    LevelsList.super.scrollToCell(self, index, animated, time)

    transition.stopTarget(self.indicator_)
    local x = self.indicator_.firstX_ + (self:getCurrentIndex() - 1) * LevelsList.INDICATOR_MARGIN
    if animated then
        time = time or self.defaultAnimateTime
        transition.moveTo(self.indicator_, {x = x, time = time / 2})
    else
        self.indicator_:setPositionX(x)
    end
end

function LevelsList:onTapLevelIcon(event)
    self:dispatchEvent({name = "onTapLevelIcon", levelIndex = event.levelIndex})
end

return LevelsList
