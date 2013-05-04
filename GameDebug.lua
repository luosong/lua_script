--[[--


]]
require ("framework/shared/debug")

local GameDebug = class("GameDebug")
local GAME_DEBUG = true


function GameDebug:ctor( ... )
	io.open("log.txt", "a+")
end

function GameDebug:logToConsole( ... )
	-- body
	if(GAME_DEBUG) then
		print("  = [Game Log]:" .. ...)
	end

end

function GameDebug:WriteLog( ... )
	-- body
	if(GAME_DEBUG) then
		printf(...)
	end
end


return GameDebug
--[[--
function printf(...)
    echo(string.format(...))
end

function echoError(...)
    echo(string.format("[ERR] %s%s", string.format(...), debug.traceback("", 2)))
end

function echoInfo(...)
    echo("[INFO] " .. string.format(...))
end

function echoLog(tag, ...)
    echo(string.format("[%s] %s", string.upper(tostring(tag)), string.format(...)))
end
]]