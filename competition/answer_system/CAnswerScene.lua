require("data.Questions_gs")

local CAnswerScene = class("CAnswerScene", function() 
	return display.newScene("CAnswerScene")
end)

function CAnswerScene:generatorQuest(param)
	self.questionList = {1, 2, 3}
end

function CAnswerScene:init()
	
	local label = ui.newTTFLabel({
		text = require("data.GameText").getText("are_you_ready"),
		x = display.width / 2,
		y = display.height * (30 / 40),
		align = ui.TEXT_ALIGN_CENTER,
		size = 38
	})
	self.startNode:addChild(label)

	local function answerQuestion()
		if #self.questionList <= 0 then
			CCMessageBox(require("data.GameText").getText("no_question"), require("data.GameText").getText("began_challenge"))
			return
		end

		self.startNode:removeFromParentAndCleanup(true)
		local questionLayer = require("answer_system.CQuestionLayer").new()
		questionLayer:setPosition(0, 0)
		self.layer:addChild(questionLayer)

		local index = 1
		questionLayer:nextQuestion(Questions[self.questionList[index]])
		local nextQuestButton = ui.newTTFLabelMenuItem({
			text = require("data.GameText").getText("next_question"),
			color = ccc3(255, 255, 255),
	    	size = 28,
	    	listener = function()
	    		if (#self.questionList < index) then
	    			printf("-------------> 没有问题了!")
	    			return
	    		end

	    		questionLayer:nextQuestion(Questions[self.questionList[index]])
	    		index = index + 1
	    	end
		})
		nextQuestButton:setPosition(display.width * (35 / 40), display.height * (10 / 40))

		local menu = ui.newMenu({nextQuestButton})
		self.layer:addChild(menu)
	end

	local menu = ui.newMenu({
		ui.newTTFLabelMenuItem({
			text = require("data.GameText").getText("began_challenge"),
	    	color = ccc3(0, 255, 0),
	    	size = 28,
	    	listener = function()
	    		answerQuestion()
	    	end
		}), 
		ui.newTTFLabelMenuItem({
			text = require("data.GameText").getText("next_time"),
			color = ccc3(0, 255, 0),
	    	size = 28,
	    	listener = function()
	    		display.replaceScene(require("CGameMenuScene").new())
	    	end
		})
	})

	menu:alignItemsHorizontally()
	menu:setPosition(display.width / 2, display.height / 2.5)
	self.startNode:addChild(menu)
end

function CAnswerScene:ctor()
	self.questionList = {}
	self.layer = display.newLayer()
	self.layer:setPosition(CCPointMake(0, 0))
	self:addChild(self.layer)

	local gridLine = CGridLineLayer:create()
	gridLine:setPosition(0, 0)
	self.layer:addChild(gridLine)

	self.startNode = display.newNode()
	self.startNode:setPosition(0, 0)
	self.layer:addChild(self.startNode)

	self:generatorQuest()

	self:init()
end

return CAnswerScene