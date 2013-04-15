
--[[

 @Author shan 
 @Date:

]]

require ("zlib")


local CGameLoginScene = class("CGameLoginScene", function()
    return display.newScene("CGameLoginScene")
end)


function CGameLoginScene:ctor()
	-- local colorbg = CCLayerColor:create(ccc4(255, 255, 255, 100), display.width, display.height)
	-- colorbg:setPosition(0, 0)
	-- self:addChild(colorbg)

    local skill = require("skills_system.CXiXingDaFa").new()
    self:addChild(skill)
    
	local function ReqServerListCB( data )
		local codeJson  = {}
		local len = 0
		if(data ~= "" and data ~= nil) then
			codeJson  = data
			len = #codeJson["Body"].sList

		end

		local function EnterGame( tag )

			local function ReqEnterGame( data )
				if(data ~= "" and data ~= nil) then
					local playerInfo = data[KEY_CONST["MSG_BODY"]][REQUEST_ID["LOGIN_GET_PLAYER_INFO"]];


					if(string.len(playerInfo[KEY_CONST["NICKNAME"]]) > 0 and string.byte(playerInfo[KEY_CONST["BASE_INFO_LEVEL"]]) > 1) then 
						game.PlayerNetWork:SetDownloadData(playerInfo)

						display.replaceScene(require("CGameMenuScene").new())
					else
						if(GAME_DEBUG.DEBUG_RANDNAME == false) then
							game.Player:setName("playerName")
						end
						print("===========name:"..game.Player:getName())
						if(game.Player:getName() == "") then
							-- self:addChild(require("business_system.CRandNameScene").new(),10)
							display.replaceScene(require("tutorial_system.CTutorialScene").new())
						else
							display.replaceScene(require("CGameMenuScene").new())
						end
					end
				end
			end -- function ReqEnterGame

			if(WRUtility:GetHostStatus()) then
				game.Player:setServerID( tag )
				local msg = game.Player:GetLoginDateSendToServer()
				print("tag:" .. msg[KEY_CONST["SERVER_ID"]] .. ",playerid:" ..msg[KEY_CONST["PLAYER_ID"]])
				gnw = require ("GameNetWork").new()
				gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["LOGIN_GET_PLAYER_INFO"],msg, ReqEnterGame)
			else
				display.replaceScene(require("CGameMenuScene").new())
			end
		end -- function EnterGame

		
		local listButton = {}
		for i=1,len do
			server_id = codeJson["Body"].sList[i].sid
			server_name = codeJson["Body"].sList[i].name
			server_url = codeJson["Body"].sList[i].url
			listButton[i] = ui.newTTFLabelMenuItem({ text = server_name,
													size = 48,
													color = ccc3(100, 100, 255),
													tag = 1,
													listener = EnterGame
	    											})

		end

		-- server list is null
		print("..............." .. len)
		if(len == 0) then
			listButton[1] = ui.newTTFLabelMenuItem({ text = " start Game",
														size = 48,
														color = ccc3(200,200,200),
														tag = 1,
														listener = function ( ... )
														display.replaceScene(require("CGameMenuScene").new())
															
														end})
		end


		local Listmenu =ui.newMenu(listButton)

		Listmenu:setPosition(display.width / 2, display.height / 4)
		Listmenu:alignItemsVertically()
		display.getRunningScene ():addChild(Listmenu)

		if(len > 0) then
			for k,v in pairs(codeJson["Body"].sList) do
				if(type(v) == "table") then
					GameDebug:logToConsole(" = serverList:" .. v.sid .. v.name .. v.url)
				end
			end
			server_id = codeJson["Body"].sList[1].sid
			server_name = codeJson["Body"].sList[1].name
			server_url = codeJson["Body"].sList[1].url	
		end


	    local BubbleButton = require("views.BubbleButton")
	    local NormalButton = require("views.NormalButton")

		self.startButton = BubbleButton.new({
	        image = "huashanerlao.png",
	        x = display.right - 150,
	        y = display.bottom + 300,
	       	
	        prepare = function()
	            print("startButton prepare")
	            self.menu:setEnabled(false)
	        end,
	        listener = function()
	            -- game.enterChooseLevelScene()
	            EnterGame(1)
	            -- display.replaceScene(require("CGameMenuScene").new())
	        end,
	    })
	    self.endButton = NormalButton.new({
	        image = "huashanerlao.png",
	        x = display.left + 150,
	        y = display.bottom + 300,
	       buttonType = NormalButton.TYPE_DARKER,
	        prepare = function()
	            print("startButton prepare")
	            self.menu:setEnabled(false)
	        end,
	        listener = function()
	            -- game.enterChooseLevelScene()
	            display.replaceScene(require ("tutorial_system.CTutorialScene").new())
	        end,
	    })

	    self.menu = ui.newMenu({ self.startButton, self.endButton})
	    self:addChild(self.menu)
	end -- end function ReqServerListCB


	local smallSun1 = CCParticleSystemQuad:create("particle/SmallSun.plist")
	smallSun1:setPosition(display.width/3,display.height/4)
	self:addChild(smallSun1)

	local smallSun2 = CCParticleSystemQuad:create("particle/SmallSun.plist")
	smallSun2:setPosition(display.width*2/3,display.height/4)
	self:addChild(smallSun2,1)

	-- local plistName = "particle/snow.plist"--"particle/SpinningPeas.plist"
	-- local imageName = "particle/snow.png"--"particle/particles.png"
	-- local snow = CCParticleSystemQuad:create(plistName)
	-- snow:setTexture(CCTextureCache:sharedTextureCache():addImage(imageName));
	-- snow:setPosition(display.width/2,display.height*4/5)
	-- self:addChild(snow)

	
	if(WRUtility:GetHostStatus()) then
		jstr = jsonTest()
		-- GameNetWork test
		gnw = require ("GameNetWork").new()
		gnw:SendData(game.Player:getPlayerID(), game.Player:getServerID(),REQUEST_ID["LOGIN_GET_SERVER_LIST_DATA"],jstr, ReqServerListCB)
	else

		local serverButton = ui.newTTFLabelMenuItem({ text = " start Game ",
													size = 48,
													color = ccc3(200,200,200),
													tag = 1,
													listener = function()
                                                        display.replaceScene(require("CGameMenuScene").new())
                                                    end})
		local menu = ui.newMenu({serverButton})

		menu:setPosition(display.width / 2, display.height / 4)
		menu:alignItemsVertically()
		self:addChild(menu)
	end

	
end

function CGameLoginScene:onExit()

    CCTextureCache:sharedTextureCache():removeUnusedTextures()
end



--[[ --
	receive the server list data
]]



-- [[=================================== test code =======================================================]]






local t = { 
		a = 1,
		b = 2,
		c = "c",
		d = {m = 1, n = 2},				
		}
		
function jsonTest()
	local j = require "framework/shared/json/simplejson"
	local str = "a = 10"
	local s = j.encode(t)
	print(s)

	return t
end





return CGameLoginScene