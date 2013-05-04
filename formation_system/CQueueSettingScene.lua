
local CQueueSettingScene = class("CQueueSettingScene", function()
	return display.newScene("CQueueSettingScene")
end)

--初始化
function CQueueSettingScene:init()
	--local battleScene = require("battle_system.CBattleScene").new(self.map)
	--battleScene:retain()

    local bg  =	display.newSprite("ui/bg03.png")
    bg:setPosition(display.cx, display.cy)
    self.node:addChild(bg)

	--加载可用的阵法列表{}
	local function initQueueLayer()
		local queueSelectLayer = require("formation_system.CQueueSelectedLayer").new()
		queueSelectLayer:setPosition(0, 0)
		self.node:addChild(queueSelectLayer, 1)
		return queueSelectLayer
	end

	--加载阵法显示的Layer
	local function initQueueShowLayer()
		local showLayer = require("formation_system.CQueueShowLayer").new()
		showLayer:setPosition(0, 0)
		self.node:addChild(showLayer, 0)
		return showLayer
    end

    local queueLayer = initQueueLayer()
    local showLayer =  initQueueShowLayer()

	local confirmButton = ui.newTTFLabelMenuItem({
		text = require("data.GameText").getText("confirm"),
		color = ccc3(0, 0, 0),
		listener = function()
            --game.Player:setMagorHeros(showLayer:getMagorHeros())
            
            -- self.UploadMajorHeros()
            game.KZNetWork:UploadFormation()
            display.replaceScene(require("CGameMenuScene").new())
        end
	})

    confirmButton:setPosition(display.width - confirmButton:getContentSize().width, 50)

    local cancleButton = ui.newTTFLabelMenuItem({
        text = require("data.GameText").getText("concel"),
        color = ccc3(0, 0, 0),
        listener = function()
            display.replaceScene(require("CGameMenuScene").new())
        end
    })
    cancleButton:setPosition(confirmButton:getContentSize().width, 50)
	local menu = ui.newMenu({confirmButton, cancleButton})
	self.node:addChild(menu)

	--注册改变阵法事件
    local eventListener = nil
	local function registerNotification()
		eventListener = require("framework.client.api.EventProtocol").extend(queueLayer)
		queueLayer:addEventListener(GlobalVariable["NotificationTag"]["CHANGE_QUEUE"], showLayer.onNotification)
	end
	registerNotification()

    self:registerScriptHandler(function(action)
        if action == "exit" then
            eventListener:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["CHANGE_QUEUE"])
            self.node:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)
end

function CQueueSettingScene:ctor(mainMapId, subMapId)
    if(display.height > CONFIG_SCREEN_HEIGHT ) then
        local pad = require("CLayerIpad").new()
        self:addChild(pad)
    end
	self.map = {mainMapId, subMapId }
	self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)


	self:init()
end






return CQueueSettingScene
