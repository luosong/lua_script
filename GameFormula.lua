
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
function GameFormula.GetUpgradeHP( baseHP, Level)
	-- body
	local hp = 0
	hp = (baseHP*2)*Level/100+10+Level;
	return hp
end


--[[
	baseAP:侠客AP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeAP( baseAP, Level )
	-- body
	local ap = 0
	ap = (baseAP*2)*Level/100 + 5
	return ap
end

--[[
	baseDP:侠客DP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeDP( baseDP, Level )
	-- body
	local dp = 0
	dp = (baseDP*2)*Level/100 + 5
	return dp
end

--[[
	baseMP:侠客MP原始数值
	Level: 侠客等级
]]
function GameFormula.GetUpgradeMP( baseMP, Level )
	-- body
	local mp = 0
	mp = (baseMP*2)*Level/100 + 5
	return mp
end