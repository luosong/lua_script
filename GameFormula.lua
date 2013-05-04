
GameFormula = {
}

--[[
	GetAttactResult: 得到最后伤害值，即目标血量减少值

	sourceLV: 攻击方等级
	sourceAP: 攻击方攻击力
	sourceSkillAP: 攻击方技能攻击力(默认为1)
	targetDP: 目标防御值
--]]
function GameFormula.GetAttactResult(sourceLV, sourceAP, sourceSkillAP, targetDP)
	local res  = 0
	if(sourceSkillAP == 0) then
		sourceSkillAP = 1
	end
	res = (((sourceLV * 2 / 5 + 2) * sourceSkillAP * sourceAP) / targetDP/1) + 2
	return res

end

--[[
	GetUpgradeHP:级别 Level 的血值

	baseHP:侠客HP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeHP( baseHP, level)
	-- body

	if(level == 1) then
		return baseHP
	end
	local hp = 0
	hp = (baseHP*2)*level/100+10+level  + baseHP;
	return hp
end


--[[
	baseAP:侠客AP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeAP( baseAP, level )
	-- body
	if(level == 1) then
		return baseAP
	end
	local ap = 0
	ap = (baseAP*2)*level/100 + 5 + baseAP
	return ap
end

--[[
	baseDP:侠客DP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeDP( baseDP, level )
	-- body
	if(level == 1) then
		return baseDP
	end
	local dp = 0
	dp = (baseDP*2)*level/100 + 5 + baseDP
	return dp
end

--[[
	baseMP:侠客MP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeMP( baseMP, level )
	-- body
	if(level == 1) then
		return baseMP
	end
	local mp = 0
	mp = (baseMP*2)*level/100 + 5 + baseMP
	return mp
end



--[[=========================装备打造公式=======================================]]

--[[
	basePrice:基础打造价格,根据每个等级
	property:物品的属性，5星
	level:当前级别
]]
function GameFormula.GetUpGradeEquipSilver( basePrice, property, level )
	local gold = ( basePrice + property * 8) * level * (level + 1)
	return gold
end



--[[
	hero 升级吃卡，每级需要的碎片数
]]
function GameFormula.GetHeroRefiningCount( property, Level )
	
	local num = (15 * property) * level

	return num
end


--[[
	装备 精炼需要素材，每级需要的素材换算的碎片数
]]
function GameFormula.GetEquipRefiningCount( property, Level )
	
	local num = (14 * property) * level

	return num
end

--[[
	skill 精炼需要其他skill，每级需要的skill换算的碎片数
]]
function GameFormula.GetSkillRefiningCount( property, Level )
	
	local num = (13 * property) * level

	return num
end