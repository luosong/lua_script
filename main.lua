
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
    -- avoid memory leak
    -- collectgarbage("setpause", 300)
    -- collectgarbage("setstepmul", 5000)

	
	require("game")
    game.startup()
end


xpcall(main, __G__TRACKBACK__)
