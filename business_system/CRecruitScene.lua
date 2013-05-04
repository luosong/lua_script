
--[[

 招贤纳士
 @Author shan 
 @Date:

]]

require("data.recruit_gs")
require("ResourceMgr")
require("FuncHelper")
local gameText = require("data.GameText")


local CRecruitScene = class("CRecruitScene", function ()
	return display.newScene("CRecruitScene")
end)




-- ctor
function CRecruitScene:ctor()
	-- store the three recruit
	self.m_recruitInfo = {}

	-- root node
	self.RootNode = display.newNode()
	self:addChild(self.RootNode, 0)

    local bg = display.newSprite("ui/bg01.png")
    -- bg:setAnchorPoint(CCPointMake(0, 0))
    bg:setPosition(display.width/2, display.height/2)
    self.RootNode:addChild(bg)

    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.RootNode:addChild(baseLayer)


    local curGoldTextLabel = ui.newTTFLabel({
    							text = game.Player:getGold(),
    							x = display.width*4/5,
    							y = display.height - 50,
    							color = ccc3(255,0,0)
    							})
    self.RootNode:addChild(curGoldTextLabel)

    local leftBarWidth = 88
    local widthSize = display.width - leftBarWidth
    local heightSize = display.height - 72 

    self.freeTimeText = {}
    self.priceLable = {}
        -- title
    local str_titles = {gameText.getText("IDS_JINBANG"), gameText.getText("IDS_YINBANG"), gameText.getText("IDS_TONGBANG")}
    local str_star_texts = {gameText.getText("IDS_JINBANG_STAR"), gameText.getText("IDS_YINBANG_STAR"), gameText.getText("IDS_TONGBANG_STAR")}
    local bgNames = {"bang_jin", "bang_yin", "bang_tong"}


    for i=1,3 do
    	local itemBg = ResourceMgr:getUISprite(bgNames[i])
    	itemBg:setPosition( leftBarWidth + widthSize/6 + (i-1)*widthSize/3, heightSize/2)
    	self.RootNode:addChild(itemBg)

    	-- title
    	local title = ui.newBMFontLabel({text = str_titles[i],
    									font = GAME_FONT.font_zhaoxian,
    									x = itemBg:getContentSize().width/2,
    									y = itemBg:getContentSize().height*4.5/5})
    	title:setScale(1.8)
    	title:setColor(ccc3(0,0,0))
    	itemBg:addChild(title)

    	-- text
    	local text1 = ui.newBMFontLabel({text = gameText.getText("IDS_ZHAOXIAN_DESC"),
    									font = GAME_FONT.font_zhaoxian,
    									x = itemBg:getContentSize().width/2,
    									y = itemBg:getContentSize().height*3.5/5})
    	text1:setColor(ccc3(0,0,0))
    	itemBg:addChild(text1)

    	local text2 = ui.newBMFontLabel({text = str_star_texts[i],
    									font = GAME_FONT.font_zhaoxian,    									
    									x = itemBg:getContentSize().width/2,
    									y = itemBg:getContentSize().height*2.5/5})
    	text2:setColor(ccc3(255, 0, 0))

    	itemBg:addChild(text2)

    	self.freeTimeText[i] = ui.newBMFontLabel({text = str_star_texts[i],
    									font = GAME_FONT.font_zhaoxian,
    									x = itemBg:getContentSize().width/2,
    									y = itemBg:getContentSize().height*1.5/5})
    	self.freeTimeText[i]:setColor(ccc3(0,0,0))
    	itemBg:addChild(self.freeTimeText[i])

    	-- price
    	local goldIcon = ResourceMgr:getUISprite("icon_gold")
    	goldIcon:setPosition(itemBg:getContentSize().width/3, itemBg:getContentSize().height/5)
    	local goldtext = ui.newBMFontLabel({text = BaseData_recruit[i].money,
    									font = GAME_FONT.font_zhaoxian,    									
    									x = itemBg:getContentSize().width/2,
    									y = itemBg:getContentSize().height/5})
    	goldtext:setColor(ccc3(0,0,0))

    	self.priceLable[i] = display.newNode()
    	self.priceLable[i]:addChild(goldIcon)
    	self.priceLable[i]:addChild(goldtext)
    	itemBg:addChild(self.priceLable[i])
    	self.priceLable[i]:setVisible(false)
    	
    end

	-- recruit button
	local recruitButton = {}
	-- press Recruit call back
	local function RecruitButtonCB( tag )
		-- print("tag:" .. tag)
		self.m_cdTime[tag] = BaseData_recruit[tag].cdtime
		self.priceLable[tag] :setVisible(true)

        -- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[50]))
        -- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[51]))

		local r = game.Player:getRecruit()[tag]
		
		local cdtime = r[KEY_CONST["RECRUIT_CD_DURATION"]]
		
		local gold = game.Player:getGold()
		local recruit_gs = BaseData_recruit
		local purchase = recruit_gs[tag].money
		-- print("cdtime:" .. cdtime .. ",playergold:" .. gold .. ",price:" .. purchase)
		local isSuccess = false
		-- 1. in cd time
		if(cdtime > 0) then
			-- 1.1 gold
			if(gold >= purchase) then
				gold = gold - purchase
				game.Player:setGold(gold)

				curGoldTextLabel:setString(gold)
				isSuccess = true
			else
				-- purchase tips
				device.showAlert(""," [fix me] gold is not enough, please purchase!")
			end
		else
		-- 2. out of cd time	
			r[KEY_CONST["RECRUIT_CD_DURATION"]] = recruit_gs[tag].cdtime
			r[KEY_CONST["RECRUIT_IS_IN_CD"]] = true
			-- 2.1 limit times
			local limits = r[KEY_CONST["RECRUIT_TIMES"]]
			print("limits:" .. r[KEY_CONST["RECRUIT_TIMES"]])
			if(r[KEY_CONST["RECRUIT_TIMES"]]  > 0) then
				r[KEY_CONST["RECRUIT_TIMES"]] = r[KEY_CONST["RECRUIT_TIMES"]] - 1
				-- local prefix = gameText.getText("IDS_FREE_TIME_DESC")
				-- self.freeTimeText[tag]:setString(prefix .. r[KEY_CONST["RECRUIT_TIMES"]])
				local dur = CFuncHelper:secondToDate(r[KEY_CONST["RECRUIT_CD_DURATION"]])
				self.freeTimeText[tag]:setString(dur)
				isSuccess = true

			else
				local dur = CFuncHelper:secondToDate(r[KEY_CONST["RECRUIT_CD_DURATION"]])
				self.freeTimeText[tag]:setString(dur)
				device.showAlert("Warning", "0 free times")
			end


		end	

		-- 招聘成功之后，显示动画，并向服务器更新
		if(isSuccess == true) then
			self:showHero(tag)
			game.Player:setRecruit(tag,r)
			self:UploadRecruit()
		end

	end	-- CRecruitScene:RecruitButtonCB( tag )


    local function  c_func(f, ...)
        local args = {...}
        return function() f(unpack(args)) end
    end

local NormalButton = require("views.NormalButton")
	for i=1,3 do
		recruitButton[i] = NormalButton.new({
	        image = "#button_zhaoxian_red.png",
	        x = leftBarWidth + widthSize/6 + widthSize/3 * (i-1),
	        y = heightSize/9 + CFuncHelper:getTopBarH(),
	       
	        prepare = function()
	            -- self.menu:setEnabled(false)
	        end,
	        listener = function()
	            RecruitButtonCB(i)
	        end,
	    })
		-- recruitButton[i] = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_zhaoxian_red"))
		-- recruitButton[i]:registerScriptTapHandler(c_func(RecruitButtonCB,i))
		-- recruitButton[i]:setPosition(leftBarWidth + widthSize/6 + widthSize/3 * (i-1), heightSize/9)
	end


    self.menu = ui.newMenu(recruitButton)
    self.RootNode:addChild(self.menu)

    -- update recruit
    self.m_cdTime = {}
    self:DownloadRecruit()
	local function UpdateCDText( dt )
		-- body
		for i=1,3 do
			local r = game.Player:getRecruit()[i]
			if(r[KEY_CONST["RECRUIT_IS_IN_CD"]]) then
				-- print(self.m_cdTime[i] .. ",".. dt)
				self.m_cdTime[i] = self.m_cdTime[i] - dt

				local str = CFuncHelper:secondToDate(self.m_cdTime[i]) 
				self.freeTimeText[i]:setString(str)
			end
		end
	end

    self.scheduler = require("framework.client.scheduler")
    self.schedulerNextScene = self.scheduler.scheduleGlobal( UpdateCDText, 1, false )
end

--[[
	招贤成功后动画
]]
function CRecruitScene:showHero( tag )
	local function uploadhero( hero )

		local temp = hero:genUploadHero(OPTIONS_TYPE.OPT_ADD)
		local msg = game.PlayerNetWork:UploadHerosData({temp})

		local function uploadheroCB( ... )

		end 
	    gnw = require ("GameNetWork").new()
        gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["HERO_UPLOAD"],msg, uploadheroCB)
       
	end

	local hid = self:GenHeroCard(tag)


	local herocard = require("game_model.HeroData").new(BaseData_heros[hid])
	-- 英雄不能重复，已添加，则该为碎片

	if(game.Player:HasAddHero(hid)) then
		print("==== has added" .. hid)
		game.Player:addSoul(hid, BaseData_heros[hid].fragment)
		local soul = game.Player:getSoulData(hid)

		game.KZNetWork:UploadSouls({soul}, OPTIONS_TYPE.OPT_UPDATE)
	else
		game.Player:addHero(herocard)
		-- uploadhero(herocard)
		game.KZNetWork:UploadHero({herocard},OPTIONS_TYPE.OPT_ADD)
	end


	local bg = CCLayerColor:create(ccc4(0, 0, 0, 155), display.width, display.height)
	local hero = ResourceMgr:getSprite(herocard:getAnimId())
	local heroNode = display.newNode()
	self:addChild(heroNode)
	hero:setScale(0.1)
	hero:setPosition(display.width/2, display.height/2)

	local action = CCRotateTo:create(1, 3600)
	local args = {
        delay = 0.0,                        -- before moving, delay 3.0 seconds
        easing = "CCEaseIn",         		-- use CCEaseBackInOut for easing
        onComplete = function()             -- call function after moving completed
            echo("MOVING COMPLETED")

        end,
    }
	transition.execute(hero, action, args)
	transition.scaleTo(hero, {
                scaleX     = 1.0,
                scaleY     = 1.0,
                time       = 1,
                onComplete = function ( ... )
                	-- body
               	transition.moveTo(hero, {
               		x = hero:getPositionX(),
               		y = display.height,
               		time = 1,
               		onComplete = function ( ... )
               			heroNode:removeSelf()
               			self.menu:setEnabled(true)
               		end
               		})	
                end,
            })
	self.menu:setEnabled(false)
	heroNode:addChild(bg)
	heroNode:addChild(hero)
end



	--[[	
		enter this scene, download the recruitinfo from server
	]]--
	
function CRecruitScene:DownloadRecruit()
	local gameNetWork = require("GameNetWork").new()
	local msg = game.Player:getRecruit()

-- download call back
	function ReqDownloadRecruitCB( data )
		-- body
		local msgBody = data[KEY_CONST["MSG_BODY"]]
		local recr = msgBody[REQUEST_ID["RECRUIT_DOWNLOAD"]]


		for i,v in ipairs(recr) do
			v[KEY_CONST["RECRUIT_ID"]]          = tonumber(v[KEY_CONST["RECRUIT_ID"]])
			v[KEY_CONST["RECRUIT_CD_DURATION"]] = tonumber(v[KEY_CONST["RECRUIT_CD_DURATION"]])
			v[KEY_CONST["RECRUIT_TIMES"]]       = tonumber(v[KEY_CONST["RECRUIT_TIMES"]])
			game.Player:setRecruit(i,v)
			self.m_cdTime[i] = v[KEY_CONST["RECRUIT_CD_DURATION"]] 
			print("============================:" .. self.m_cdTime[i])
			if(v[KEY_CONST["RECRUIT_TIMES"]] > 0) then
				local prefix = gameText.getText("IDS_FREE_TIME_DESC")
				self.freeTimeText[i]:setString(prefix .. v[KEY_CONST["RECRUIT_TIMES"]])
			end
		end

	end -- ReqDownloadRecruitCB
	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), REQUEST_ID["RECRUIT_DOWNLOAD"],msg, ReqDownloadRecruitCB)
end -- CRecruitScene:DownloadRecruit( )



--[[ 
	if the press any recruit,must update	
]]--
function CRecruitScene:UploadRecruit()
	local gameNetWork = require("GameNetWork").new()
	local msg = game.Player:getRecruit()


	 	-- download call back
	function ReqUpdateRecruitCB( data )
		-- body
		-- local msgBody = data[KEY_CONST["MSG_BODY"]]
		-- local len = msgBody[REQUEST_ID["RECRUIT_UPDATE"]][KEY_CONST["ARRAY_COUNT"]]

		-- -- len = 0, it means new user, init the recruit from client, not server
		-- local recruitInfo = game.Player:getRecruit()
		-- if(len == 3) then
		-- 	-- recruitInfo = msgBody[]
		-- end
		print("======ReqUpdateRecruitCB=======:")
	end

	gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), REQUEST_ID["RECRUIT_UPDATE"],msg, ReqUpdateRecruitCB)

end



--[[
	5星：1-26
	4星：27-80
	3星：81-143
	2星：144-179
]]
function CRecruitScene:GenHeroCard( tag )

	local heroID = 170
	
	local star_5_start = 1
	local star_5_end = 35
	local star_4_start = 36
	local star_4_end = 92
	local star_3_start = 93
	local star_3_end = 150
	local star_2_start = 151
	local star_2_end = 185

	local function get5star( ... )
		return math.random(star_5_start, star_5_end)
	end 

	local function get4star( ... )
		return math.random(star_4_start, star_4_end)
	end

	local function get3star( ... )
		return math.random(star_3_start, star_3_end)
	end

	local function get2star( ... )
		return math.random(star_2_start, star_2_end)
	end

	-- 金榜 5,4
	if(tag == 1) then
		local jinbang_5star = 85
		if(math.random(1,100) < jinbang_5star) then
			heroID = get5star()
		else
			heroID = get4star()
		end
	
	-- 银榜 5,4,3
	elseif(tag == 2) then
		local yinbang_5star = 1
		local yinbang_4star = 30
		local rn = math.random(1,100)
		if(rn == yinbang_5star) then
			heroID = get5star
		elseif(rn < yinbang_4star) then
			heroID = get4star()
		else	
			heroID = get3star()
		end	
	-- 铜榜 4,3,2
	elseif(tag == 3) then
		local tongbang_4star = 10
		local tongbang_3star = 30
		local rn = math.random(1,100)
		if(rn < tongbang_4star) then
			heroID = get4star()
		elseif(rn < tongbang_3star) then
			heroID = get3star()
		else	
			heroID = get2star()
		end
	end

	return heroID
end

function CRecruitScene:onExit()
	self.scheduler.unscheduleGlobal(self.schedulerNextScene)
	CCTextureCache:sharedTextureCache():removeUnusedTextures()
end

--[[ end class]]
return CRecruitScene