

local CBattleLoadingScene = class("CBattleLoadingScene", function()
	return display.newScene("CBattleLoadingScene")
end)


function CBattleLoadingScene:init()

	local label = ui.newTTFLabelWithShadow({
		text = "准备战斗",
		size = 48,
		align = ui.TEXT_ALIGN_CENTER,
		color = ccc3(255, 255, 255),
		shadowColor = ccc3(255, 255, 0),
		x = display.width / 2,
		y = display.height / 2
	})
	self.layer:addChild(label)
	require("framework.client.scheduler").performWithDelayGlobal(function()
		display.replaceScene(require("battle_system.CBattleScene").new({1, 1}))
	end, 2)

end

function CBattleLoadingScene:ctor()
	self.layer = display.newLayer()
	self:addChild(self.layer)

	self:init()
end

return CBattleLoadingScene