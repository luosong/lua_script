
--[[

 @Author shan 
 @Date:

]]

require("data/names_1_gs")
require("data/names_2_gs")
require("data/names_3_gs")
require("ResourceMgr")

local CRandNameScene = class("CRandNameScene", function ()
	 return display.newLayer()
end)

function CRandNameScene:ctor( fun )
	local rtNode = display.newNode()
	self:addChild(rtNode)
	-- input box
    local boxSize = CCSize(display.width/2, 60)
    local inputBox = CCEditBox:create(boxSize, CCScale9Sprite:create"ui/board02.png")
    inputBox:setPosition(display.width/2, inputBox:getContentSize().height+10)
    inputBox:setPlaceHolder("Please input here")
 
    rtNode:addChild(inputBox)

    local function uploadName(  )
        local function ReqEnterGame( data )
            if(data ~= "" and data ~= nil) then
                local playerInfo = nil
                if(data[KEY_CONST["MSG_BODY"]] ~= nil) then
                    playerInfo = data[KEY_CONST["MSG_BODY"]][REQUEST_ID["LOGIN_GET_PLAYER_INFO"]]
                    if(playerInfo ~= nil and playerInfo[KEY_CONST["NICKNAME"]]~= nil and 
                        string.len(playerInfo[KEY_CONST["NICKNAME"]]) > 0 and 
                        string.byte(playerInfo[KEY_CONST["BASE_INFO_LEVEL"]]) > 1) then 
                        game.PlayerNetWork:SetDownloadData(playerInfo)
                     end
                end

                
            end
        end -- function ReqEnterGame

        
        local msg = game.Player:GetLoginDateSendToServer()
        gnw = require ("GameNetWork").new()
        gnw:SendData( game.Player:getPlayerID(), game.Player:getServerID(), REQUEST_ID["LOGIN_GET_PLAYER_INFO"],msg, ReqEnterGame)

    end -- function uploadName

    local comfirmButton = CSingleImageMenuItem:create("ui/chatButton.png")
    comfirmButton:setPosition(display.width * (30 / 40), display.height * (5 / 40))
    comfirmButton:registerScriptTapHandler(function()
    	if(inputBox:getText() ~= "") then
	        game.Player:setName(inputBox:getText())
            uploadName()
	        self:removeFromParentAndCleanup(true)
            fun()

	    end

    end)

    local randButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("bagua1"))
    randButton:setPosition(display.width * (20 / 40), display.height * (15 / 40))
    randButton:registerScriptTapHandler(function()
    	inputBox:setText(self.genName())
        -- local text = inputBox:getText()
        -- if(text ~= "") then
        --     textLable:setString(text)
        --     inputBox:setText("")
        -- end
    end)

    local menu = ui.newMenu({ comfirmButton,randButton})
    rtNode:addChild(menu)

end


function CRandNameScene:genName( ... )
	local middleName = BaseData_names_2[math.random(1,BaseData_names_2.ArrayCount())].str_name
	local prefixName = ""
	local postfixName = ""
	if(math.random(0,1) == 0) then
		prefixName = BaseData_names_1[math.random(1,BaseData_names_1.ArrayCount())].str_name
	end

	-- if(math.random(0,1) == 1) then
	-- 	postfixName = BaseData_names_3[math.random(1,BaseData_names_3.ArrayCount())].str_name
	-- end

	if(string.find(middleName,"镖") == nil) then
		postfixName = BaseData_names_3[math.random(1,BaseData_names_3.ArrayCount())].str_name
	end


	print(prefixName .. middleName .. postfixName)

	return (prefixName .. middleName .. postfixName)
end



return CRandNameScene