
--[[

 @Author shan 
 @Date:

]]

local CLayerIpad = class("CLayerIpad",function ( type )
	return display.newLayer()
end)



function CLayerIpad:ctor( type )
	local topBoard = display.newSprite("ipad_board.png")

	local offY = 64
	local ScaleW = display.width/topBoard:getContentSize().width
	local ScaleH = offY/topBoard:getContentSize().height
	topBoard:setPosition(display.width/2, display.top - offY/2)
	topBoard:setScaleX(ScaleW)
	topBoard:setScaleY(ScaleH)
	self:addChild(topBoard)

	local bottomBoard = display.newSprite("ipad_board.png")
	bottomBoard:setFlipY(true)
	bottomBoard:setPosition(display.width/2, display.bottom + offY/2)
	self:addChild(bottomBoard)
	bottomBoard:setScaleX(ScaleW)
	bottomBoard:setScaleY(ScaleH)

end



return CLayerIpad
