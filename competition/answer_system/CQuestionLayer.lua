

local CQuestionLayer = class("CQuestionLayer", function()
	return display.newLayer()
end)

function CQuestionLayer:nextQuestion(data)
	self.questionNode:removeAllChildrenWithCleanup(true)

	self.questionData = data
	local questLabel = ui.newTTFLabel({
			text = self.questionData["str_Ques"],
			size = 30,
			color = ccc3(0, 255, 0),
			x = display.width / 2,
			y = display.height * (30 / 40),
			align = ui.TEXT_ALIGN_CENTER
		})
	self.questionNode:addChild(questLabel)

	local index = {"str_A", "str_B", "str_C", "str_D"}
	function onQnswerQuestion(sender)
		if index[sender] == self.questionData["str_result"] then
			printf("-------------------------> 回答正确")
		end
	end

	local buttons = {}
	for k, v in ipairs(index) do
		local button = ui.newTTFLabelMenuItem({
			text = string.char(string.byte("A") + k - 1) .. " . ".. self.questionData[v],
			size = 18,
			color = ccc3(0, 255, 0),
			tag = k,
			listener = onQnswerQuestion
		})
		button:setPosition(display.width / 2, display.height * ((30 - 5 * k) / 40))
		buttons[k] = button
	end
	local menu = ui.newMenu(buttons)
	menu:setPosition(0, 0)
	self.questionNode:addChild(menu)

end

function CQuestionLayer:ctor()
	self.questionNode = display.newNode()
	self.questionNode:setPosition(0, 0)
	self:addChild(self.questionNode)
end

return CQuestionLayer