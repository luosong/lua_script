

local CPromptBox = class("CPromptBox", function()
	return display.newLayer()
end)

function CPromptBox:init()
	local background = display.newBackgroundSprite("bg_land.png")
	self:addChild(background)

	local function initTitle()
		local titleLabel = ui.newTTFLabel({
			text = self.title_text,
			color = ccc3(0, 0, 0),
			align = ui.TEXT_ALIGN_LEFT,
			x    = background:getContentSize().width / 10,
			y    = background:getContentSize().height * (9 / 10)
		})
		background:addChild(titleLabel)
	end

	local function initInfo()
		local infoLabel = ui.newTTFLabel({
			text = self.info_text,
			color = ccc3(0, 0, 0),
			align = ui.TEXT_ALIGN_LEFT,
			x    = background:getContentSize().width / 10,
			y    = background:getContentSize().height / 2
		})
		background:addChild(infoLabel)
	end

	local function initButton()
		local menu = ui.newMenu({})
		menu:setPosition(0, 0)
		background:addChild(menu)
		if self.ok_text ~= nil then
			local okButton = CSingleImageMenuItem:create("btn.png")
			if self.listener then
				okButton:registerScriptTapHandler(self.listener)
			end
			if self.cancel_text ~= nil then
				okButton:setPosition(background:getContentSize().width * 0.3, background:getContentSize().height * 0.25)
			else
				okButton:setPosition(background:getContentSize().width / 2, background:getContentSize().height * 0.25)
			end

			menu:addChild(okButton)

			local okLabel = ui.newTTFLabel({
				text = self.ok_text,
				align = ui.TEXT_ALIGN_CENTER,
				size = 28,
				color = ccc3(0, 0, 255),
				x = okButton:getContentSize().width / 2, 
				y = okButton:getContentSize().height / 2
			})
			okButton:addChild(okLabel)
		end

		
		if self.cancel_text ~= nil then
			local cancelButton = CSingleImageMenuItem:create("btn.png")
			cancelButton:registerScriptTapHandler(function()
				self:removeFromParentAndCleanup(true)
			end)
			cancelButton:setPosition(background:getContentSize().width * 0.7, background:getContentSize().height * 0.25)
			menu:addChild(cancelButton)

			local cancelLabel = ui.newTTFLabel({
				text = self.cancel_text,
				align = ui.TEXT_ALIGN_CENTER,
				size = 28,
				color = ccc3(0, 0, 255),
				x = cancelButton:getContentSize().width / 2, 
				y = cancelButton:getContentSize().height / 2
			})
			cancelButton:addChild(cancelLabel)
		end
	end
	

	initTitle()
	initInfo()
	initButton()

end

function CPromptBox:ctor(params)
	self.title_text  = params.title
	self.info_text   = params.info
	self.ok_text     = params.ok_text
	self.cancel_text = params.cancel_text
	self.listener    = params.listener
	self:init()
end

return CPromptBox