
--[[

 @Author shan 
 @Description: 实现游戏中常用的数据上传方法，比如上传金钱，经验，hero，碎片，
 			 减少各处单独实现类似方法
 @Date:

]]

local CKZNetWork = class("CKZNetWork")

local gnwInstance = require ("GameNetWork")


--[[ 上传heros,这些hero的处理方式一致（add，update，delete），适合处理多选
		heros必须为table
]]
function CKZNetWork:UploadHero( heros , opt)

		local heroArray = {} 
		local index = 1
		for k,v in pairs(heros) do
			local temp = v:genUploadHero(opt)
			heroArray[index] = temp		
		end

		local msg = game.PlayerNetWork:UploadHerosData(heroArray)

		local function uploadheroCB( ... )

		end 

	    gnw = gnwInstance.new()
        gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["HERO_UPLOAD"],msg, uploadheroCB)

end

--[[						 id,num
	上传 souls  souls的结构

	soul = {info = {id = 1,
					num = 5},
			opt  = 2}
]]
function CKZNetWork:UploadSouls( souls, opt )

		local soulArray = {} 
		local index = 1
		for k,v in pairs(souls) do

			local temp = {}
			temp.info = v
			temp.opt = opt
			soulArray[index] = temp	
			index = index + 1	
		end

		local msg = game.PlayerNetWork:UploadHeroSoulsData(soulArray)
		dump(msg)
		local function uploadsoulCB( ... )

		end 

	    gnw = gnwInstance.new()
        gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["HERO_SOUL_UPLOAD"],msg, uploadsoulCB)

end

--[[
	上传 上阵hero到服务器
]]
function CKZNetWork:UploadMajorHeros( ... )
	
	local gameNetWork = gnwInstance.new()

	local function uploadCB( ... )
		
	end 

	gameNetWork:SendData(game.Player:getPlayerID(), game.Player:getServerID(),
		REQUEST_ID["HERO_MAJOR_UPLOAD"], game.PlayerNetWork:UploadMajorHerosData(), uploadCB)
end


--[[
	上传阵型数据到服务器
]]
function CKZNetWork:UploadFormation( ... )

	local gameNetWork = gnwInstance.new()

	local function uploadCB( ... )
		-- body
	end
	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
		REQUEST_ID["FORM_UPLOAD"],game.PlayerNetWork:UploadFormData(), uploadCB)

end


function CKZNetWork:UploadBattleResult( ptr, func )
	local gameNetWork = gnwInstance.new()

	local function uploadCB( ... )
		func(ptr)
	end
	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
		REQUEST_ID["BATTLE_RESULT"],game.PlayerNetWork:UploadBattleResultData(), uploadCB)
end



-- 武斗榜
function CKZNetWork:DownloadArenaList( ... )
	local gameNetWork = gnwInstance.new()

		local function uploadCB( ... )
		-- body
	end
	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
		REQUEST_ID.ARENA_LIST,{}, uploadCB)
end



-- admin
function CKZNetWork:AdminGenNPC( ... )
	local gameNetWork = gnwInstance.new()
	local msg = {}
	local ss =  require("AdminMgr").new()
  	msg = ss:genAllNPC()
	local function uploadCB( ... )
		-- body
	end
	dump(msg)
	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
		REQUEST_ID.ADMIN_GEN_NPC,msg, uploadCB)
end


function CKZNetWork:ctor( ... )
	-- body
end





return CKZNetWork