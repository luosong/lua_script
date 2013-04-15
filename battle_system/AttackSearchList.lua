

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

function AttackSearchList:getAtkModel(model)
    local m = {
        ROW_1 = {1, 4, 7},
        ROW_2 = {2, 5, 8},
        ROW_3 = {3, 6, 9},
        COL_1 = {1, 2, 3},
        COL_2 = {4, 5, 6},
        COL_3 = {7, 8, 9},
        CROSS = {2, 4, 5, 6, 8},
        CIRCLE = {1, 2, 3, 6, 9, 8, 7, 4}
    }
end


return AttackSearchList