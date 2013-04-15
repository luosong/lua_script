require "Animation"

local CHeroSprite = class("CHeroSprite", function()
	return display.newNode()
end)

--次攻击力为各种加成效果总和
function CHeroSprite:getAtk()
	local atk = self.heroData:getAp()
	return -atk
end

function CHeroSprite:hurt(h)

	if (h * -1) > self.heroData:getHp() then
		self.heroData:setHp(0)
		self.bDead = true
	else
		self.heroData:addHp(-h)
	end

	return self.bDead
	
end

function CHeroSprite:isDead()
	return self.bDead
end

function CHeroSprite:setOpacity(opacity)
	self.sprite:setOpacity(opacity)
end

function CHeroSprite:setScale(s)
	self.sprite:setScale(s)
end

function CHeroSprite:getContentSize()
    return self.sprite:getContentSize()
end

function CHeroSprite:setHeroData(data)
	self.heroData = data
end

function CHeroSprite:getHeroData()
	return self.heroData
end

--function CHeroSprite:getTexture()
--   return self.sprite:getTexture()
--end

function CHeroSprite:setFlipX(b)
   self.sprite:setFlipX(b)
end

function CHeroSprite:boundingBox()
    return self.sprite:boundingBox()
end

function CHeroSprite:init(data, displayType)


    if displayType == "head" then

        if(data:getProperty() == 0) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_white")
        elseif(data:getProperty() == 1) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_white")
        elseif(data:getProperty() == 2) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_green")
        elseif(data:getProperty() == 3) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_blue")
        elseif(data:getProperty() == 4) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_yellow")
        elseif(data:getProperty() == 5) then
            self.sprite = ResourceMgr:getUISprite("icon_bg_purple")
        end

        local herosIcon = ResourceMgr:getIconSprite(data:getIconID())
        self.sprite:addChild(herosIcon)
        herosIcon:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height / 2)
    elseif displayType == "card" then

        if(data:getProperty() == 0) then
            self.sprite = ResourceMgr:getUISprite("card_green")
        elseif(data:getProperty() == 1) then
            self.sprite = ResourceMgr:getUISprite("card_green")
        elseif(data:getProperty() == 2) then
            self.sprite = ResourceMgr:getUISprite("card_green")
        elseif(data:getProperty() == 3) then
            self.sprite = ResourceMgr:getUISprite("card_blue")
        elseif(data:getProperty() == 4) then
            self.sprite = ResourceMgr:getUISprite("card_yellow")
        elseif(data:getProperty() == 5) then
            self.sprite = ResourceMgr:getUISprite("card_purple")
        end

        local shadowSprite = ResourceMgr:getUISprite("shadow")
        shadowSprite:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height * (1 / 10))
        self.sprite:addChild(shadowSprite)

        local herosBody = ResourceMgr:getSprite(data:getAnimId())
        self.sprite:addChild(herosBody)
        herosBody:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height / 2)
        herosBody:setScale(0.6)
    else
        self.sprite = ResourceMgr:getSprite(data:getAnimId())
    end

	self.bDead = false


	self.sprite:setPosition(0, 0)
	self:addChild(self.sprite)
	self.heroData = data
end

function CHeroSprite:setColor(color)
	self.sprite:setColor(color)
end


function CHeroSprite:ctor(data, head)
	self:init(data, head)
end

return CHeroSprite