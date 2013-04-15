require ("GameConst")
require ("zlib")
require ("GameDebug")
require("ResourceMgr")
require("FuncHelper")
local CGameMenuScene = class("CGameMenuScene", function()
    return display.newScene("CGameMenuScene")
end)

function CGameMenuScene:init()

    local headIcon =  ResourceMgr:getUISprite("board23")
    headIcon:setAnchorPoint(CCPointMake(0, 0.5))
    headIcon:setPosition(CFuncHelper:getRelativeX(0.5), display.height - headIcon:getContentSize().height / 2 - CFuncHelper:getRelativeY(0.5))
    self.bg:addChild(headIcon)

    local nameLabel = ui.newTTFLabel({
        text = game.Player:getName(),
        size = 26,
        color = ccc3(0,0,0),
        x = headIcon:getContentSize().width * (5 / 13),
        y = headIcon:getContentSize().height * (6 / 7)
    })
    headIcon:addChild(nameLabel)

    local expLabel = ui.newTTFLabel({
        text = "100000/100000",
        size = 16,
        color = ccc3(0,0,0),
        x = headIcon:getContentSize().width * (5 / 13),
        y = headIcon:getContentSize().height * (3 / 7)
    })
    headIcon:addChild(expLabel)

    local vipSprite = ResourceMgr:getUISprite("icon_vip")
    vipSprite:setPosition(CFuncHelper:getRelativeX(14), CFuncHelper:getRelativeY(38.5))
    vipSprite:setAnchorPoint(CCPointMake(0, 0.5))
    self.bg:addChild(vipSprite)
    local vipLabel = ui.newTTFLabel({
        text = "10",
        size = 18,
        color = ccc3(0,0,0),
        x = CFuncHelper:getRelativeX(15.6),
        y = CFuncHelper:getRelativeY(38.5)
    })
    self.bg:addChild(vipLabel)

    local xingSprite = ResourceMgr:getUISprite("sicon17")
    xingSprite:setPosition(CFuncHelper:getRelativeX(14), CFuncHelper:getRelativeY(36.5))
    xingSprite:setAnchorPoint(CCPointMake(0, 0.5))
    self.bg:addChild(xingSprite)
    local xingLabel = ui.newTTFLabel({
        text = "100",
        size = 18,
        color = ccc3(0,0,0),
        x = CFuncHelper:getRelativeX(15.6),
        y = CFuncHelper:getRelativeY(36.5)
    })
    self.bg:addChild(xingLabel)

    local goldenSprite = ResourceMgr:getUISprite("icon_gold")
    goldenSprite:setPosition(CFuncHelper:getRelativeX(18), CFuncHelper:getRelativeY(38.5))
    self.bg:addChild(goldenSprite)
    local goldenLabel = ui.newTTFLabel({
        text = "10000000",
        size = 18,
        color = ccc3(0,0,0),
        x = CFuncHelper:getRelativeX(19),
        y = CFuncHelper:getRelativeY(38.5)
    })
    self.bg:addChild(goldenLabel)

    local sliverSprite = ResourceMgr:getUISprite("icon_silver")
    sliverSprite:setPosition(CFuncHelper:getRelativeX(18), CFuncHelper:getRelativeY(36.5))
    self.bg:addChild(sliverSprite)
    local sliverLabel = ui.newTTFLabel({
        text = "10000000",
        size = 18,
        color = ccc3(0,0,0),
        x = CFuncHelper:getRelativeX(19),
        y = CFuncHelper:getRelativeY(36.5)
    })
    self.bg:addChild(sliverLabel)


    local broadcastSprite = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame("board02"))
    broadcastSprite:setPreferredSize(CCSizeMake(CFuncHelper:getRelativeX(17), CFuncHelper:getRelativeY(3)))
    broadcastSprite:setPosition(CFuncHelper:getRelativeX(22.5), CFuncHelper:getRelativeY(38))
    broadcastSprite:setAnchorPoint(CCPointMake(0, 0.5))
    self.bg:addChild(broadcastSprite)

    ---------------好友----------------------
    local friendButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    friendButton:setPosition(display.width * (3 / 40), display.height * (16 / 40))
    friendButton:registerScriptTapHandler(function()
        display.replaceScene(require("sns_system.CFriendsScene").new())
    end)
    local friendLabel = ResourceMgr:getUISprite("font_hy")
    friendLabel:setPosition(friendButton:getContentSize().width / 2, friendButton:getContentSize().height / 2)
    friendButton:addChild(friendLabel)

    -----------------设置--------------------
    local settingButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    settingButton:setPosition(display.width * (12 / 40), display.height * (16 / 40))
    settingButton:registerScriptTapHandler(function()
        display.replaceScene(require("setting.CSettingScene").new())        
    end)
    local settingLabel = ResourceMgr:getUISprite("font_sz")
    settingLabel:setPosition(settingButton:getContentSize().width / 2, settingButton:getContentSize().height / 2)
    settingButton:addChild(settingLabel)

    -----------------聊天----------------------
    local chatButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    chatButton:setPosition(display.width * (3 / 40), display.height * (26 / 40))
    chatButton:registerScriptTapHandler(function()
        display.replaceScene(require("sns_system.CChatScene").new())
    end)
    local chatLabel = ResourceMgr:getUISprite("font_lt")
    chatLabel:setPosition(chatButton:getContentSize().width / 2, chatButton:getContentSize().height / 2)
    chatButton:addChild(chatLabel)

    ------------------传书---------------------
    local mailButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    mailButton:setPosition(display.width * (7.5 / 40), display.height * (28 / 40))
    mailButton:registerScriptTapHandler(function()
        display.replaceScene(require("sns_system.CEmailScene").new())
    end)
    local mailLabel = ResourceMgr:getUISprite("font_cs")
    mailLabel:setPosition(mailButton:getContentSize().width / 2, mailButton:getContentSize().height / 2)
    mailButton:addChild(mailLabel)

    -------------------图鉴----------------------------------------------
    local herosButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    herosButton:setPosition(display.width * (7.5 / 40), display.height * (14 / 40))
    herosButton:registerScriptTapHandler(function()
        display.replaceScene(require("business_system.CGameCollectionScene").new())
    end)
    local herosLabel = ResourceMgr:getUISprite("font_tj")
    herosLabel:setPosition(herosButton:getContentSize().width / 2, herosButton:getContentSize().height / 2)
    herosButton:addChild(herosLabel)

    ------------------活动--------------------------------------------------
    local activityButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
    activityButton:setPosition(display.width * (12 / 40), display.height * (26 / 40))
    activityButton:registerScriptTapHandler(function()
        display.replaceScene(require("activity_sys.CActivityScene").new())
    end)
    local activityLabel = ResourceMgr:getUISprite("font_hd")
    activityLabel:setPosition(activityButton:getContentSize().width / 2, activityButton:getContentSize().height / 2)
    activityButton:addChild(activityLabel)

    -----------------武林大会--------------------------------------------------
    local wldhButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board03"))
    wldhButton:setPosition(display.width * (19 / 40), display.height * (28 / 40))
    wldhButton:registerScriptTapHandler(function()
        display.replaceScene(require("battle_system.CBattleLoadingScene").new())
    end)
    local wldhLabel = ResourceMgr:getUISprite("font_wldh")
    wldhLabel:setPosition(wldhButton:getContentSize().width / 2, wldhButton:getContentSize().height / 2)
    wldhButton:addChild(wldhLabel)

    ----------------招贤榜------------------------------------------------
    local zxbButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board03"))
    zxbButton:setPosition(display.width * (25 / 40), display.height * (28 / 40))
    zxbButton:registerScriptTapHandler(function()
        display.replaceScene(require("business_system.CRecruitScene").new())
    end)
    local zxbLabel = ResourceMgr:getUISprite("font_zxb")
    zxbLabel:setPosition(zxbButton:getContentSize().width / 2, zxbButton:getContentSize().height / 2)
    zxbButton:addChild(zxbLabel)

    ---------------接镖---------------------------------------------------
    local jbButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board03"))
    jbButton:setPosition(display.width * (31 / 40), display.height * (28 / 40))
    jbButton:registerScriptTapHandler(function()
        display.replaceScene(require("task_system.CChargeDartScene").new())

    end)
    local jbLabel = ResourceMgr:getUISprite("font_jb")
    jbLabel:setPosition(jbButton:getContentSize().width / 2, jbButton:getContentSize().height / 2)
    jbButton:addChild(jbLabel)

    -----------------闯江湖---------------------------------------------------
    local cjhButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board03"))
    cjhButton:setPosition(display.width * (37 / 40), display.height * (28 / 40))
    cjhButton:registerScriptTapHandler(function()
        display.replaceScene(require("adventure.CAdventureScene").new())
    end)
    local cjhLabel = ResourceMgr:getUISprite("font_cjh")
    cjhLabel:setPosition(cjhButton:getContentSize().width / 2, cjhButton:getContentSize().height / 2)
    cjhButton:addChild(cjhLabel)

    ------------------武功-------------------------------------------------
    local wgButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board04"))
    wgButton:setPosition(display.width * (19 / 40), display.height * (16 / 40))
    wgButton:registerScriptTapHandler(function()
        display.replaceScene(require("possessions.CKungFuScene").new())
    end)
    local wgLabel = ResourceMgr:getUISprite("font_wg")
    wgLabel:setPosition(wgButton:getContentSize().width / 2, wgButton:getContentSize().height / 2)
    wgButton:addChild(wgLabel)

    -------------------人员------------------------------------------------
    local membersButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board04"))
    membersButton:setPosition(display.width * (25 / 40), display.height * (16 / 40))
    membersButton:registerScriptTapHandler(function()
        display.replaceScene(require("possessions.CMembersScene").new())
    end)
    local membersLabel = ResourceMgr:getUISprite("font_ry")
    membersLabel:setPosition(membersButton:getContentSize().width / 2, membersButton:getContentSize().height / 2)
    membersButton:addChild(membersLabel)

    -----------------------装备---------------------------------------------
    local equipButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board04"))
    equipButton:setPosition(display.width * (31 / 40), display.height * (16 / 40))
    equipButton:registerScriptTapHandler(function()
        display.replaceScene(require("possessions.CEquipmentsScene").new())
    end)
    local equipLabel = ResourceMgr:getUISprite("font_zb")
    equipLabel:setPosition(equipButton:getContentSize().width / 2, equipButton:getContentSize().height / 2)
    equipButton:addChild(equipLabel)

    ------------------------包裹-------------------------------------------
    local bagButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board04"))
    bagButton:setPosition(display.width * (37 / 40), display.height * (16 / 40))
    bagButton:registerScriptTapHandler(function()
        display.replaceScene(require("possessions.CBagScene").new())
    end)
    local bagLabel = ResourceMgr:getUISprite("font_bg")
    bagLabel:setPosition(bagButton:getContentSize().width / 2, bagButton:getContentSize().height / 2)
    bagButton:addChild(bagLabel)

    ------------------------阵容-------------------------------------------
    local zhenrongButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board04"))
    zhenrongButton:setPosition(display.width * (2 / 40), display.height * (2 / 40))
    zhenrongButton:registerScriptTapHandler(function()
        display.replaceScene(require("formation_system.CQueueSettingScene").new(1, 1))
    end)

    --------------------------------------------------------------------------
    local menu = ui.newMenu({friendButton, settingButton, chatButton, mailButton, herosButton, activityButton,
        wldhButton, zxbButton, jbButton, cjhButton, wgButton, membersButton, equipButton, bagButton, zhenrongButton})
    self.bg:addChild(menu)

    function initHerosIcon()
        local heros = game.Player:getMajorHeros()
        local nodes = {}
        local onTouchHeros = function(sender)
            printf("Hello hello: " .. sender:getData():getName())
        end
        if (#heros > 0) then
            for k, v in ipairs(heros) do

                nodes[k] = require("ui_common.CScrollCell").new(require("battle_system.CHeroSprite").new(v, "head"))
                nodes[k]:setTouchListener(onTouchHeros)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (6 / 40),
                y = display.height * (1 / 40),
                width = display.width * (32 / 40),
                height = display.height * (8 / 40),
                pageSize = 6,
                rowSize = 6,
                nodes = nodes,
                vertical = false
            })
            scrollLayer:setPosition(0, 0)
            self.bg:addChild(scrollLayer)
        end
    end

    initHerosIcon()

--    -- player name
--    local nameLabel = ui.newTTFLabel({
--        text = game.Player:getName(),
--        size = 26,
--        color = ccc3(0,0,0),
--        x = 170,
--        y = display.height - 30
--        })
--    self:addChild(nameLabel)

 --   echoInfo(string.format("==========MEMORY USED: %0.2f KB, UPTIME: %04.2fs", collectgarbage("count"), 1))
end

function CGameMenuScene:onEnter( ... )
    -- body
end
function CGameMenuScene:ctor()
	self.bg = display.newBackgroundSprite("ui/bg02.png")
    self.bg:setPosition(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2)

--    local baseLayer = require("CBaseLayer").new(true)
--    self.bg:addChild(baseLayer)
	self:addChild(self.bg)

--    local gridLine = CGridLineLayer:create()
--    gridLine:setPosition(0, 0)
--    self:addChild(gridLine)

    self:init()


--	local anAnimFileFullPath = CCFileUtils:sharedFileUtils():fullPathForFilename("fish_150/fish.sam")
--	printf(anAnimFileFullPath)
--	local mAnim = SuperAnimNode:create(anAnimFileFullPath, 0, nil);
--
--	self:addChild(mAnim, 1000);
--	mAnim:setPosition(680, 420);
--	mAnim:PlaySection("idle");
--	mAnim:registerScriptHandlerOnAnimSectionEnd(function()
--		mAnim:PlaySection("active")
--	end)

    -- systemMsgTest(self)

    -- json test
--    jstr = jsonTest()
--    -- GameNetWork test
--    gnw = require ("GameNetWork").new()
--    gnw:SendData(game.Player:getPlayerID(), game.Player:getServerID(),REQUEST_ID["LOGIN_GET_SERVER_LIST_DATA"],jstr, ReqServerListCB)



end



--[[ ==================================test============================================================]]
--[[ --
	receive the server list data
]]
function ReqServerListCB( data )
	-- body

	-- GameDebug:logToConsole(" = result: " .. data["name"])

	-- request = data["request"]
	-- code1 = request:getResponseStatusCode()

	--local j = require "framework/shared/json/simplejson"
	-- local zipRes = request:getResponseString()
	-- GameDebug:logToConsole(" = zipRes =: " .. zipRes )
	-- local res,eof,bin,bout = zlib.inflate()(zipRes, 'finish')
	local  codeJson  = data
	local len = #codeJson["Body"].sList
	
	local listButton = {}
	for i=1,len do
		server_id = codeJson["Body"].sList[i].sid
		server_name = codeJson["Body"].sList[i].name
		server_url = codeJson["Body"].sList[i].url
		listButton[i] = ui.newTTFLabelMenuItem({
												text = server_name,
												size = 48,
												color = ccc3(100, 100, 255),
												tag = i,
												listener = EnterGame	
    											})


		-- Listmenu:addChild(listButton[i])
	end
	local Listmenu =ui.newMenu(listButton)

	Listmenu:setPosition(display.width / 4, display.height / 4)
	Listmenu:alignItemsVertically()
	display.getRunningScene ():addChild(Listmenu)

	for k,v in pairs(codeJson["Body"].sList) do
		if(type(v) == "table") then
			GameDebug:logToConsole(" = serverList:" .. v.sid .. v.name .. v.url)
		end
	end
	server_id = codeJson["Body"].sList[1].sid
	server_name = codeJson["Body"].sList[1].name
	server_url = codeJson["Body"].sList[1].url





	-- print(" = code =: " .. code1 )
	-- print (" = content =: " .. server_id .. "," .. server_name .. "," .. server_url)
end


-- [[=================================== test code =======================================================]]

function EnterGame( tag )
	game.Player:setServerID( tag )
	local msg = {}

	msg[KEY_CONST["SERVER_ID"]] = game.Player:getServerID()
	msg[KEY_CONST["PLAYER_ID"]] = game.Player:getPlayerID()
	msg[KEY_CONST["THIRD_ID"]] = game.Player:getThirdID()
	print("tag:" .. msg[KEY_CONST["SERVER_ID"]] .. ",playerid:" ..msg[KEY_CONST["PLAYER_ID"]])
	gnw = require ("GameNetWork").new()
	gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["LOGIN_GET_PLAYER_INFO"],msg, ReqEnterGame)
end

function ReqEnterGame( data )
	-- body
	local playerInfo = data[KEY_CONST["MSG_BODY"]][REQUEST_ID["LOGIN_GET_PLAYER_INFO"]];


	game.Player:setUID(playerInfo[KEY_CONST["UID"]])
	game.Player:setPlayerID(playerInfo[KEY_CONST["PLAYER_ID"]])
	game.Player:setName(playerInfo[KEY_CONST["NICKNAME"]])
	game.Player:setLevel(playerInfo[KEY_CONST["BASE_INFO_LEVEL"]])
	game.Player:setGold(playerInfo[KEY_CONST["BASE_INFO_GOLD"]])
	game.Player:setMoney(playerInfo[KEY_CONST["BASE_INFO_DIAMOND"]])
	game.Player:setExp(playerInfo[KEY_CONST["BASE_INFO_EXP"]])
	game.Player:setEnergy(playerInfo[KEY_CONST["BASE_INFO_ENERGY"]])


end


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


function zibTest(  )
	-- body
		-- test zlib
	print (zlib:version())
	local source = [[{"Head":{"Flag":"0"},"Body":{"gpinfo":{"UID":"14","NickName":"random name","PID":"5147ff262eb4d"},"BaDt":[]}}]]

	-- local len = zlib:inflate(source)
	local zipdata,eof,bin,bout = zlib.deflate()(source, 'finish')
	print ("zip:" .. zipdata .. "," .. bout)

	local unzipdata,eof,bin,bout = zlib.inflate()(zipdata, 'finish')
	print ("unzip:" .. unzipdata .. "," .. bout)
end


function crc32Test(  )
	-- body
	    -- crc32 test
    local CRC = require 'digest.crc32lua'
    local s = CRC.crc32("ZHANG")
    print ("DM = " .. s)
end


function httpCallBack( data )
	-- body

	print(" = ==== Test result: " .. data["name"])

	request = data["request"]
	code1 = request:getResponseStatusCode()
	code2 = request:getResponseString()

	local name = WRUtility:GetDeviceID()
	print(" = code =: " .. code1 .. "name:" .. name )
	print (" = ==== Test End content =: " .. code2)
end

function networkTest( data )
	local n = require("framework/client/network")

   local serverURL = "http://192.168.1.198/games/kezhan/test.php"
   --CCHTTPRequest
    httpRequest = n.createHTTPRequest(
    	httpCallBack , 
    	 serverURL, 
    	 "POST"
    	)

    local postData = "visitor=cocos2d&TestSuite=Extensions Test/NetworkTest"

    httpRequest:setPOSTData("cool")
    httpRequest:start()
end


function systemMsgTest(scene)
	local startButton = ui.newTTFLabelMenuItem({
		text = "send",
		size = 48,
		color = ccc3(0, 255, 255),
		listener = function()
			msg = {msg = "hello, Sir"}
			gnw = require ("GameNetWork").new()
    		gnw:SendData(game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["MSG_SYS_CLIENT_TO_SERVER"],msg, ReqSendSysMsgCB)
		end
	})

	local startAnswer = ui.newTTFLabelMenuItem({
		text = "receive",
		size = 48,
		color = ccc3(0, 255, 255),
		listener = function()
			msg = {msg = "recv"}
			gnw = require ("GameNetWork").new()
    		gnw:SendData(game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["MSG_SYS_SERVER_TO_CLIENT"],msg, ReqRecvSysMsgCB)
		end
	})


	local menu = ui.newMenu({startButton, startAnswer})
	menu:alignItemsVertically()
	menu:setPosition(display.width / 4, display.height / 2)
    scene:addChild(menu)

    -- send sys msg
    function ReqSendSysMsgCB( ... )
    	-- body
    end

    function ReqRecvSysMsgCB(data)
    	-- body
		codeJson = data

		msgList = codeJson["Body"]["syssend"];

		for k, v in pairs(msgList) do
			print(" ReqRecvSysMsgCB:" ..v)
		end

    end
end

return CGameMenuScene
