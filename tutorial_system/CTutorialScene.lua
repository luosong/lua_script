
--[[

 @Author shan 
 @Date:

 @说明：教学场景
 		1.所有教学在这个场景中进行
 		2.
]]
require("ResourceMgr")

local CTutorialScene = class("CTutorialScene", function ( ... )
	return display.newScene("CTutorialScene")
end)

CTutorialScene.steps = {
	step_regist_name = 1,
	step_select_hero = 2,
}

function CTutorialScene:ctor( ... )
	self.RootNode = display.newNode()
	self:addChild(self.RootNode)

	local title = ui.newTTFLabel({
                text = "简单教学",
                size = 38,
                x    = display.width/2,
                y    = display.top-20,
                align = ui.TEXT_ALIGN_CENTER
            })
	self.RootNode:addChild(title)

	function createSelectPlayer( ... )
		local selectLayer = require("tutorial_system.CSelectHeroLayer").new()
		self:addChild(selectLayer)

		local norButtonFactory = require("views.NormalButton")
		local closeButton = norButtonFactory.new({
											image = ResourceMgr:getUISpriteFrameName("button_close"),
											x	= display.width - 60,
											y	= display.height - 60,
											listener = function ()
												display.replaceScene(require("CGameLoginScene").new())
											end
									})
		local menu = ui.newMenu({closeButton})
		self.RootNode:addChild(menu)
	end

	local nameLayer = require("business_system.CRandNameScene").new(createSelectPlayer)

	self:addChild(nameLayer)



end


function CTutorialScene:onEnter( ... )
	-- body
end

function CTutorialScene:onExit( ... )
	-- body
end



return CTutorialScene

