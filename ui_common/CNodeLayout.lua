--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-1
-- Time: 上午11:08
-- To change this template use File | Settings | File Templates.
--

local CNodeLayout = class("CNodeLayout", function()
    return display.newNode()
end)

function CNodeLayout:ctor(params)

    local nodes = params.nodes
    local width = params.width
    local height = params.height
    local rowSize = params.rowSize

    local rowNum = math.ceil(#nodes / rowSize)
    local cellWidth = width / rowSize
    local cellHeight = height / rowNum

    local cellCX = cellWidth / 2
    local cellCY = height - cellHeight / 2
    if (height == 0) then
        cellCY = cellHeight / 2
    end


    -------------------------------------------------

    local function displayNodes()
        local tmpX = cellCX
        local tmpY = cellCY
        for k, v in ipairs(nodes) do
            tmpX = cellCX + cellWidth * math.floor((k - 1) % rowSize)
            tmpY = cellCY - cellHeight * math.floor((k - 1) / rowSize)
            --v:setAnchorPoint(CCPointMake(0, 0))
            v:setPosition(tmpX, tmpY)
            self:addChild(v);
        end
    end

    displayNodes()

end

return CNodeLayout

