require "GlobalVariable"
require "GameConst"


--local QueueTypes = require("data.QueueType")
require("data.formations_gs")

local CQueueSelectedLayer = class("CQueueSelectedLayer", function()
	return display.newLayer()
end)

function CQueueSelectedLayer:init()

    local bgPosX = display.width * (1/ 4)
    local bgPosY = display.height * (18 / 40) + CFuncHelper:getTopBarH()
    local bg = ResourceMgr:getUISprite("board15")
    bg:setPosition(bgPosX, bgPosY)
    self:addChild(bg)

    local discBg = ResourceMgr:getUISprite("board14")
    discBg:setPosition(display.width * (1/ 4), display.height * (34 / 40) )
    self:addChild(discBg)

    local discLabel = ui.newTTFLabel({
        text = BaseData_formations[game.Player:getQueueType()]["str_des"],
        x    = discBg:getContentSize().width * (2 / 18),
        y    = discBg:getContentSize().height / 2 ,
        color = ccc3(0, 0, 0),
        dimensions = CCSizeMake(discBg:getContentSize().width * (14 / 18), discBg:getContentSize().height * (6 / 8))
    })
    discBg:addChild(discLabel)

	local function loadQueuesData()

        local nodes = {}
        local function onButton(tag, sender)
            for k, v in ipairs(nodes) do
                v:setSelect(false)
            end

            discLabel:setString(BaseData_formations[tag]["str_des"])
            self:dispatchEvent({
                name = GlobalVariable["NotificationTag"]["CHANGE_QUEUE"],
                info = tag
            })
            sender:setSelect(true, tag)
        end

        local function  c_func(f, ...)
            local args = {...}
            return function() f(unpack(args)) end
        end

        local formations = game.Player:getFormations()
		for k, v in pairs(formations) do
			if type(v) == "table" then
                nodes[k] = require("formation_system.CFormButton").new(v:getIcon(), v:getName())
                nodes[k]:setTouchListener(c_func(onButton, v:getId(), nodes[k]))

                if (game.Player:getCurrentFormationId() == v:getId()) then
                    nodes[k]:setSelect(true, v:getId())
                end
			end
        end

        local scrollLayer = require("ui_common.CScrollLayer").new({
            x = bgPosX -bg:getContentSize().width / 2,
            y = bgPosY - bg:getContentSize().height / 2,
            width = bg:getContentSize().width,
            height = bg:getContentSize().height,
            pageSize = 5,
            rowSize = 1,
            nodes = nodes,
            vertical = true,
            bFreeScroll = true
        })
        scrollLayer:setPosition(0, 0)
        self:addChild(scrollLayer)
	end

	loadQueuesData()

--    local gridLine = CGridLineLayer:create()
--    gridLine:setPosition(0, 0)
--    self:addChild(gridLine)
end

function CQueueSelectedLayer:ctor()
	self:init()
end


return CQueueSelectedLayer
