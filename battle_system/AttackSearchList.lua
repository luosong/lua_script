

--攻击搜索列表
local AttackSearchList = {
	[1] = {1, 4, 7, 2, 5, 8, 3, 6, 9},
	[2] = {2, 5, 8, 1, 4, 7, 3, 6, 9},
	[3] = {3, 6, 9, 2, 5, 8, 1, 4, 7},

	[4] = {1, 4, 7, 2, 5, 8, 3, 6, 9},
	[5] = {2, 5, 8, 1, 4, 7, 3, 6, 9},
	[6] = {3, 6, 9, 2, 5, 8, 1, 4, 7},

	[7] = {1, 4, 7, 2, 5, 8, 3, 6, 9},
	[8] = {2, 5, 8, 1, 4, 7, 3, 6, 9},
	[9] = {3, 6, 9, 2, 5, 8, 1, 4, 7},
}

function AttackSearchList:getHitTarget(tag, atkOrder)

    function getBattleHeroByTag(battleHeroTag)
        local hero = nil
        for _, v in ipairs(atkOrder) do
            if battleHeroTag == v:getTag() then
                hero = v
                break;
            end
        end
        return hero
    end

    local targetHero = nil
    local tagOffset  = 0
    local startTag   = tag

    if tag > 100 then
        tagOffset = 100
        startTag = tag - 100
    end

    for _, v in ipairs(AttackSearchList[startTag]) do
        targetHero = getBattleHeroByTag(v + tagOffset)
        if targetHero then
            if targetHero:isDead() == false then
                break
            end
        end
    end

    return targetHero
end

function AttackSearchList:getMemberByTag(tag, parentNode, atkOrderList)
	--有的敌人可能死亡，只为找出一个没有死亡的敌人
	function getHeroFromOrderListByTag(sub)
		if sub ~= nil then
			for _, v in ipairs(atkOrderList) do
				if v:getTag() == sub:getTag() then
					sub = v
					break;
				end
			end
		end
		return sub
	end
	
	local child = nil
	local tagOffset = 0
	local tagTmp = tag

	if tag > 100 then
		tagOffset = 100
		tagTmp = tag - 100
	end

	for _, v in ipairs(AttackSearchList[tagTmp]) do
		child  = parentNode:getChildByTag(v + tagOffset)
		if child ~= nil then
			child = getHeroFromOrderListByTag(child)
			if child:isDead() == false then
				break
			end
		end
	end

	return child
end

--SkillAtkType.SINGLE_PERSON = 1
--SkillAtkType.SINGLE_ROW    = 2
--SkillAtkType.SINGLE_COL    = 3
--SkillAtkType.CROSS         = 4
--SkillAtkType.All           = 5

function AttackSearchList:getAtkModel(model)
    printf(model)
    local m = {
        ROW_1 = {1, 4, 7},
        ROW_2 = {2, 5, 8},
        ROW_3 = {3, 6, 9},
        COL_1 = {1, 2, 3},
        COL_2 = {4, 5, 6},
        COL_3 = {7, 8, 9},
        CROSS = {2, 4, 5, 6, 8},
        CIRCLE = {1, 2, 3, 6, 9, 8, 7, 4},
        ALL    = {1, 2, 3, 4, 5, 6, 7, 8, 9}
    }
    return m[model]
end

function AttackSearchList:getEnemysByLocation(skillAtkType, targetPos)

    printf("---------- skillAtkType ---------" .. skillAtkType)
    local enemys = nil
    targetPos = targetPos % 100
    if skillAtkType == SkillAtkType.SINGLE_ROW then
        local rowNum = targetPos % 3
        if rowNum == 1 then
            enemys = self:getAtkModel("ROW_1")
        elseif rowNum == 2 then
            enemys = self:getAtkModel("ROW_2")
        else
            enemys = self:getAtkModel("ROW_3")
        end
    elseif skillAtkType == SkillAtkType.SINGLE_COL then
        if targetPos < 4 then
           enemys = self:getAtkModel("COL_1")
        elseif targetPos < 7 then
            enemys = self:getAtkModel("COL_2")
        else
            enemys = self:getAtkModel("COL_3")
        end
    elseif skillAtkType == SkillAtkType.CROSS then
         enemys = self:getAtkModel("CROSS")
    elseif skillAtkType == SkillAtkType.CIRCLE then
        enemys = self:getAtkModel("CIRCLE")
    elseif skillAtkType == SkillAtkType.ALL then
         enemys = self:getAtkModel("ALL")
    else
        enemys = {targetPos}
    end
    return enemys
end




return AttackSearchList