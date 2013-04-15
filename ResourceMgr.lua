
--[[

 @Author shan 
 @Date:

]]
require("imageMapping")
ResourceMgr = {
		

}




function ResourceMgr:getSprite( imageName )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "azi"
	end
	local plistname = "heros/" .. imageMapping[imageName][2]
	local textureName = "heros/" .. imageMapping[imageName][3]

	display.addSpriteFramesWithFile(plistname, textureName)

	return display.newSprite(imageMapping[imageName][1])
end

function ResourceMgr:getSpriteFrameName( imageName )
		if(imageMapping[imageName] == nil) then
		imageName = "azi"
	end
	local plistname = "heros/" .. imageMapping[imageName][2]
	local textureName = "heros/" .. imageMapping[imageName][3]

	display.addSpriteFramesWithFile(plistname, textureName)

	return imageMapping[imageName][1]
end

function ResourceMgr:getBodySpriteFrame(imageName)

    if(imageMapping[imageName] == nil) then
        imageName = "azi"
    end

    local plistname = "heros/" .. imageMapping[imageName][2]
    local textureName = "heros/" .. imageMapping[imageName][3]
    display.addSpriteFramesWithFile(plistname, textureName)

    if string.byte(imageMapping[imageName][1]) == 35 then -- first char is #
        return display.newSpriteFrame(string.sub(imageMapping[imageName][1], 2))
    else
        return display.newSpriteFrame(imageMapping[imageName][1])
    end

end

function ResourceMgr:getIconSprite( imageName , x, y )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "icon_azi"
	end

	local plistname = "heros/icons/" .. imageMapping[imageName][2]
	local textureName = "heros/icons/" .. imageMapping[imageName][3]

	display.addSpriteFramesWithFile(plistname, textureName)

	return display.newSprite(imageMapping[imageName][1], x, y)
end

function ResourceMgr:getIconSpriteFrame( imageName)
    -- body
    if(imageMapping[imageName] == nil) then
        imageName = "icon_azi"
    end

    local plistname = "heros/icons/" .. imageMapping[imageName][2]
    local textureName = "heros/icons/" .. imageMapping[imageName][3]

    display.addSpriteFramesWithFile(plistname, textureName)

    if string.byte(imageMapping[imageName][1]) == 35 then -- first char is #
        return display.newSpriteFrame(string.sub(imageMapping[imageName][1], 2))
    else
        return display.newSpriteFrame(imageMapping[imageName][1])
    end
end

function ResourceMgr:getUISprite( imageName, x, y )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "icon_azi"
	end
	
	local plistname = "ui/" .. imageMapping[imageName][2]
	local textureName = "ui/" .. imageMapping[imageName][3]

	display.addSpriteFramesWithFile(plistname, textureName)

	return display.newSprite(imageMapping[imageName][1], x, y)
end

function ResourceMgr:getUISpriteFrameName( imageName )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "icon_azi"
	end
	
	local plistname = "ui/" .. imageMapping[imageName][2]
	local textureName = "ui/" .. imageMapping[imageName][3]

	display.addSpriteFramesWithFile(plistname, textureName)

	return imageMapping[imageName][1]

end

function ResourceMgr:getUISpriteFrame( imageName)
    -- body
    if(imageMapping[imageName] == nil) then
        imageName = "icon_azi"
    end

	local plistname = "ui/" .. imageMapping[imageName][2]
	local textureName = "ui/" .. imageMapping[imageName][3]

    display.addSpriteFramesWithFile(plistname, textureName)

    if string.byte(imageMapping[imageName][1]) == 35 then -- first char is #
        return display.newSpriteFrame(string.sub(imageMapping[imageName][1], 2))
    else
        return display.newSpriteFrame(imageMapping[imageName][1])
    end
end







