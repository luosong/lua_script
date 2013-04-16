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

function CHeroSprite:init(data, displayType, bFlipX)


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

        self.sprite = display.newSprite("ui/cards/card_bg" .. math.random(1, 2) .. ".png")

        local herosBody = ResourceMgr:getSprite(data:getAnimId())


        if (self.sprite:getTextureRect().size.width < herosBody:getTextureRect().size.width * 0.55) then
            herosBody:setTextureRect(CCRectMake(herosBody:getTextureRect().origin.x +  41,
                herosBody:getTextureRect().origin.y,
                herosBody:getTextureRect().size.width - 42, herosBody:getTextureRect().size.height))

        end

        if (herosBody:getTextureRect().size.height * 0.55 > self.sprite:getTextureRect().size.height - 25) then
            herosBody:setTextureRect(CCRectMake(herosBody:getTextureRect().origin.x,
                herosBody:getTextureRect().origin.y + 27,
                herosBody:getTextureRect().size.width,
                herosBody:getTextureRect().size.height - 27))
        end

        herosBody:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height * (90 / 155))
        herosBody:setScale(0.55)
        self.sprite:addChild(herosBody)

        if (bFlipX) then
            herosBody:setFlipX(true)
        end

        local cardSprite = display.newSprite("ui/cards/card_white.png")
        if(data:getProperty() == 1) then
            cardSprite = display.newSprite("ui/cards/card_white.png")
        elseif(data:getProperty() == 2) then
            --self.sprite = ResourceMgr:getUISprite("card_green")
            cardSprite = display.newSprite("ui/cards/card_blue.png")
        elseif(data:getProperty() == 3) then
            --self.sprite = ResourceMgr:getUISprite("card_blue")
            cardSprite = display.newSprite("ui/cards/card_yellow.png")
        elseif(data:getProperty() == 4) then
            --self.sprite = ResourceMgr:getUISprite("card_yellow")
            cardSprite = display.newSprite("ui/cards/card_green.png")
        elseif(data:getProperty() == 5) then
            --self.sprite = ResourceMgr:getUISprite("card_purple")
            cardSprite = display.newSprite("ui/cards/card_purple.png")
        end

        local lvLabel = ui.newTTFLabel({
            text = tostring(data:getLevel()),
            align = ui.TEXT_ALIGN_LEFT,
            valign = ui.TEXT_VALIGN_TOP,
            x = cardSprite:getContentSize().width * (2 / 15),
            y = cardSprite:getContentSize().height * (14.2 / 15),
            size = 12,
            font = "STHeitiJ-Medium"
        })
        cardSprite:addChild(lvLabel)


        local nameLabel = ui.newTTFLabel({
            text = data:getName(),
            align = ui.TEXT_ALIGN_CENTER,
            x = cardSprite:getContentSize().width / 2,
            y = cardSprite:getContentSize().height * (10 / 155),
            size = 12,
            font = "STHeitiJ-Medium"
        })
        cardSprite:addChild(nameLabel)

        cardSprite:setAnchorPoint(CCPointMake(0, 1))
        cardSprite:setPosition(0, self.sprite:getContentSize().height)

        self.sprite:addChild(cardSprite)

--        local shadowSprite = ResourceMgr:getUISprite("shadow")
--        shadowSprite:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height * (1 / 10))
--        self.sprite:addChild(shadowSprite)


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


function CHeroSprite:ctor(data, head, bFlipX)
	self:init(data, head, bFlipX)
end

return CHeroSprite