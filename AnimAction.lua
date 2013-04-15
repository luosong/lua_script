local AnimAction = {}

function AnimAction:getEnterGameAction_A()
	
end

function AnimAction:getEnterGameAction_B()
	
end

function AnimAction:getSelectedTarget()
	local action = CCBlink:create(3, 5)
	return action
end

function AnimAction:getOurArmyAtkAction(basePos, destPos)

    local action = transition.sequence({
        CCMoveTo:create(1, destPos),
        CCMoveTo:create(1, basePos)
    })
    return action
end

function AnimAction:onSelectedQueueTypeAction()
	local action = CCBlink:create(1, 2)
	return CCRepeatForever:create(action)
end

function AnimAction:onHitHarmAction(pos)

	function removeFromParent(node)
		node:removeFromParentAndCleanup(true)
	end

	local array = CCArray:create()
	array:addObject(CCMoveTo:create(2, CCPointMake(pos.x, pos.y + 120)))
	array:addObject(CCFadeOut:create(2))

	local seqArray = CCArray:create()
	seqArray:addObject(CCSpawn:create(array))
	seqArray:addObject(CCCallFuncN:create(removeFromParent))

    return CCSequence:create(seqArray)
end



return AnimAction