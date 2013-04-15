
require "GlobalVariable"
CFuncHelper = {}

function CFuncHelper:ccSub(pos1, pos2)
	local x = pos1.x - pos2.x
	local y = pos1.y - pos2.y

	return CCPointMake(x, y)
end

--[[]
--给数字加密(只支持数字类型)
param:  num为普通数字
return: 返回加密数据
--]]
function CFuncHelper:encryptNum(num)
	local a = CChaosNumberForLua:getInstance()
	return a:encryptNum(num)end


--[[
--给数字解密
param:  num为已经被加密过的数字
return: 返回原始数据
--]]
function CFuncHelper:decryptNum(num)
	local a = CChaosNumberForLua:getInstance()
	return a:decryptNum(num)
end


--[[
chaosNum: 一个加密的数字
num     :未加密的数字
return  :返回经过相加得到的加密数字
--]]
function CFuncHelper:addForChaosNum(chaosNum, num)
	local temp = self:decryptNum(chaosNum) + num
	return self:encryptNum(temp)
end

function CFuncHelper:getRelativeX(x)
    return display.width * (x / 40)
end

function CFuncHelper:getRelativeY(x)
    return display.height * (x / 40)
end

function CFuncHelper:secondToDate( second )
	local d = math.floor(second/3600/24)
	local h = math.floor(second/3600) - (d * 24)
	local m = math.floor(math.fmod(math.fmod(second,3600*24),3600) / 60)
	local s = math.floor(math.fmod(math.fmod(math.fmod(second,3600*24),3600),60))

	return d .. "天\n" .. h .. "小时" .. m .. "分" .. s .. "秒"
end

return CFuncHelper