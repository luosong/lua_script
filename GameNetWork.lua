--[[

]]

require ("GameConst")
require ("MsgConst")

local debug = require ("GameDebug")

local CGameNetWork = class("CGameNetWork")
local outStringData = nil
local responseCB = nil
local cb = nil

local network = require("framework/client/network")

--[[--
	@serverID: select server index 
	@requestID: 
	@tableData: the data must be table, it will be encode as json
	@callback: response listener
]]
function CGameNetWork:SendData(playerID, serverID, requestID, tableData , callback )

	-- 1.网络不好
	if(network.isInternetConnectionAvailable() == false) then
		device.showAlert("network", "internet error")
		return
	end
	-- 2.服务器无法连接
	-- if(network.isHostNameReachable(tostring(ServerInfo.SERVER_IP)) == false) then
	-- 	device.showAlert("server","connect server error")
	-- 	return
	-- end

	-- msg
	local msg = {}
	msg.Head = MSG_HEAD;
	msg.Head.DID = WRUtility:GetDeviceID()
	msg.Head.ReqID = requestID
	msg.Head.SNAME = msg.Head.Build .. '_' .. serverID
	msg.Head.PID = playerID
	msg.Body = tableData
	print("========request id =========:" .. msg.Head.ReqID)

	-- encode json
	local jsonOutPut = require("framework/shared/json/simplejson")

	if(msg ~= nil) then
		outStringData = jsonOutPut.encode(msg)
	end
	-- set callback
	cb = callback

	-- send Request
	self.Request()
end




--[[--
	send to server
]]
function CGameNetWork:Request()
	
	local function responseCB( data )
	    local request = data["request"]
		local Rescode = request:getResponseStatusCode()

		local j = require "framework/shared/json/simplejson"
		local zipRes = request:getResponseDataLua()
		GameDebug:logToConsole("zip:" ..zipRes)

		-- uncompress data
		local res,eof,bin,bout = zlib.inflate()(zipRes)

		if(eof) then
			GameDebug:logToConsole("unzip:" .. res)
		else
			GameDebug:logToConsole("=|eof is false|=" .. bin .. "," .. bout)	
		end
		-- json decode
		if(res ~= "") then
			codeJson = j.decode(res)
		else
			codeJson = ""
		end
		-- deliver the data to outside function callback
        if cb ~= nil then
            cb(codeJson)
        end
	end -- end function


   	local serverURL = ServerInfo["SERVER_URL"]
   	--CCHTTPRequest
    httpRequest = network.createHTTPRequest(
    	responseCB , 
    	serverURL, 
    	"POST"
    	)

    --debug.logToConsole(outStringData)
    httpRequest:setPOSTData(outStringData)
    httpRequest:start()

end

function CGameNetWork:disconnect()

end


function CGameNetWork:ctor()
	-- body
end


return CGameNetWork


