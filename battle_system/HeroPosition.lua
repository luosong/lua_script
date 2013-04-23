--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-20
-- Time: 下午3:19
-- To change this template use File | Settings | File Templates.
--
local ourArmyPosition = {}
local enemyArmyPosition = {}

local function initPos()
    local battleArea = CCSizeMake(display.width / 2, display.height * (3 / 4))
    local cellWidth = battleArea.width / 3
    local cellHeight = battleArea.height / 3

    local baseX = display.width * (1.0 / 4) + battleArea.width / 2 - cellWidth / 2
    local baseY = display.height / 2 + battleArea.height / 2 - cellHeight / 2

    local function initOursPos()
        for i = 1, 9 do
            ourArmyPosition[i] = CCPointMake(baseX - cellWidth * (math.floor( (i - 1) / 3)), baseY - cellHeight * ((i - 1) % 3))
        end
    end

    local function initEnemyPos()
        baseX = display.width * (3.0 / 4) - battleArea.width / 2 + cellWidth / 2
        baseY = display.height / 2 + battleArea.height / 2 - cellHeight / 2
        for i = 1, 9 do
            enemyArmyPosition[i] = CCPointMake(baseX + cellWidth * (math.floor( (i - 1) / 3)), baseY - cellHeight * ((i - 1) % 3))
        end
    end

    initOursPos()
    initEnemyPos()
end
initPos()

function getOutPositon()
    return ourArmyPosition
end

function getArmyPosition()
    return enemyArmyPosition
end