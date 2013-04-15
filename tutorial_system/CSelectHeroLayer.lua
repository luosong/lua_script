
--[[

 @Author shan 
 @Date:

]]
require("ResourceMgr")
require("data/heros_gs")


local CSelectHeroLayer = class("CSelectHeroLayer", function ( ... )
	return display.newLayer("CSelectHeroLayer")
end)


--[[

]]
function CSelectHeroLayer:ctor(...)

	local heros = {9,16,23}
	local title = ui.newTTFLabel({
									text  = "请选择镖师",
									size  = 24,
									color = ccc3(0,255,0),
									x     = display.width / 2,
									y     = display.height * 4/5,
									align = ui.TEXT_ALIGN_CENTER
							})

	self:addChild(title)

	-- 上传选择的hero
	local function uploadhero( hero )

		local temp = hero:genUploadHero(OPTIONS_TYPE.OPT_ADD)
		local msg = game.PlayerNetWork:UploadHerosData({temp})

		local function uploadheroCB( ... )

		end 
	    gnw = require ("GameNetWork").new()
        gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["HERO_UPLOAD"],msg, uploadheroCB)
       
	end 

	-- 选择完，应该是进入游戏，暂时返回到login界面 fixme
	local function selectButtonCB( id )
		
		local herodata = require("game_model.HeroData")
		local heroId = heros[id]
		local hero = herodata.new(BaseData_heros[heroId])

		uploadhero(hero)
		game.Player:addHero(hero)
		game.Player:addMajorHero(hero:getId())

		display.replaceScene(require("CGameLoginScene").new())
	end 

	local norButtonFactory = require("views.NormalButton")
	local buttonSelect = {}
	local menu = {}
	for i=1,3 do
		local icon = ResourceMgr:getSprite(BaseData_heros[heros[i]].str_anim_id)
		icon:setPosition(display.width/6 + (display.width/3)*(i-1), display.height/2)

	 	buttonSelect[i] = norButtonFactory.new({
									image      = ResourceMgr:getUISpriteFrameName("button_bg"),
									x          = display.width/6 + (display.width/3)*(i-1),
									y          = display.height/8,
									buttonType = norButtonFactory.TYPE_NORMAL,
									prepare    = function()
													print("startButton prepare")
													menu:setEnabled(false)
												end,
									listener   = function()
													selectButtonCB(i)
												end,
									})
	 	self:addChild(icon)

	end

	menu = ui.newMenu(buttonSelect)
	self:addChild(menu)

end


function CSelectHeroLayer:onExit( ... )
	CCTextureCache:sharedTextureCache():removeUnusedTextures()
end

function CSelectHeroLayer:onEnter( ... )
	-- body
end


return CSelectHeroLayer


