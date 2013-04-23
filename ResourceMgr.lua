
--[[

 @Author shan 
 @Date:

]]
require("imageMapping")
ResourceMgr = {
		

}

AllTextureName = {}

function HasAdd( textureName , plistname)
	-- local t1 = os.time()
	for i,v in ipairs(AllTextureName) do
		if(v == textureName) then
			return true
		end
	end
	-- local t2 = os.time()
	
	AllTextureName[#AllTextureName+1] = textureName

	display.addSpriteFramesWithFile(plistname, textureName)
	-- local t3 = os.time()

	-- print("==========" .. (t2-t1) .. "," .. (t3-t2).. "," .. textureName)
	return false
end


function ResourceMgr:getSprite( imageName )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "azi"
	end
	local plistname = "heros/" .. imageMapping[imageName][2]
	local textureName = "heros/" .. imageMapping[imageName][3]

	HasAdd(textureName, plistname)

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

	-- display.addSpriteFramesWithFile(plistname, textureName)
	HasAdd(textureName, plistname)

	return display.newSprite(imageMapping[imageName][1], x, y)
end

function ResourceMgr:getIconSpriteFrame( imageName)
    -- body
    if(imageMapping[imageName] == nil) then
        imageName = "icon_azi"
    end

    local plistname = "heros/icons/" .. imageMapping[imageName][2]
    local textureName = "heros/icons/" .. imageMapping[imageName][3]

    -- display.addSpriteFramesWithFile(plistname, textureName)
    HasAdd(textureName, plistname)

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

	-- display.addSpriteFramesWithFile(plistname, textureName)
	HasAdd(textureName, plistname)

	return display.newSprite(imageMapping[imageName][1], x, y)
end

function ResourceMgr:getUISpriteFrameName( imageName )
	-- body
	if(imageMapping[imageName] == nil) then
		imageName = "icon_azi"
	end
	
	local plistname = "ui/" .. imageMapping[imageName][2]
	local textureName = "ui/" .. imageMapping[imageName][3]

	-- display.addSpriteFramesWithFile(plistname, textureName)
	HasAdd(textureName, plistname)

	return imageMapping[imageName][1]

end

function ResourceMgr:getUISpriteFrame( imageName)
    -- body
    if(imageMapping[imageName] == nil) then
        imageName = "icon_azi"
    end

	local plistname = "ui/" .. imageMapping[imageName][2]
	local textureName = "ui/" .. imageMapping[imageName][3]

    -- display.addSpriteFramesWithFile(plistname, textureName)
    HasAdd(textureName, plistname)

    if string.byte(imageMapping[imageName][1]) == 35 then -- first char is #
        return display.newSpriteFrame(string.sub(imageMapping[imageName][1], 2))
    else
        return display.newSpriteFrame(imageMapping[imageName][1])
    end
end







