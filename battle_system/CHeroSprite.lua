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

function CHeroSprite:resetHp()
    if self.bloodSprite then
       self.bloodSprite:setPercentage((self.heroData:getHp("real") / self.heroData:getHp("base")) * 100)
    end
end

function CHeroSprite:setFlipX(b)
   self.sprite:setFlipX(b)
end

function CHeroSprite:boundingBox()
    return self.sprite:boundingBox()
end

function CHeroSprite:init(data, displayType, bFlipX)

      if displayType == "card" then

        self.sprite = ResourceMgr:getUISprite("card_bg" .. math.random(1, 2))
        local herosBody = ResourceMgr:getSprite(data:getAnimId())
        if (self.sprite:getTextureRect().size.width < herosBody:getTextureRect().size.width * 0.55) then
            herosBody:setTextureRect(CCRectMake(herosBody:getTextureRect().origin.x +  41,
                herosBody:getTextureRect().origin.y,
                herosBody:getTextureRect().size.width - 42, herosBody:getTextureRect().size.height))

        end

--        printf("****************" .. herosBody:getTextureRect().size.height * 0.55 .. "   " .. self.sprite:getTextureRect().size.height - 25)
--        if (herosBody:getTextureRect().size.height * 0.55 > self.sprite:getTextureRect().size.height - 25) then
--            herosBody:setTextureRect(CCRectMake(herosBody:getTextureRect().origin.x,
--                herosBody:getTextureRect().origin.y + 27,
--                herosBody:getTextureRect().size.width,
--                herosBody:getTextureRect().size.height - 27))
--            printf("****************^^^^^^^^^^^^^^")
--        end

        herosBody:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height * (90 / 155))
        herosBody:setScale(0.55)
        self.sprite:addChild(herosBody)

        if (bFlipX) then
            herosBody:setFlipX(true)
        end

        local cardSprite = ResourceMgr:getUISprite("card_white")
        if(data:getProperty() == 1) then
            cardSprite = ResourceMgr:getUISprite("card_white")
        elseif(data:getProperty() == 2) then
            --self.sprite = ResourceMgr:getUISprite("card_green")
            cardSprite = ResourceMgr:getUISprite("card_blue")
        elseif(data:getProperty() == 3) then
            --self.sprite = ResourceMgr:getUISprite("card_blue")
            cardSprite = ResourceMgr:getUISprite("card_yellow")
        elseif(data:getProperty() == 4) then
            --self.sprite = ResourceMgr:getUISprite("card_yellow")
            cardSprite = ResourceMgr:getUISprite("card_green")
        elseif(data:getProperty() == 5) then
            --self.sprite = ResourceMgr:getUISprite("card_purple")
            cardSprite = ResourceMgr:getUISprite("card_purple")
        end

        local lvLabel = ui.newTTFLabel({
            text = tostring(data:getLevel()),
            align = ui.TEXT_ALIGN_LEFT,
            valign = ui.TEXT_VALIGN_TOP,
            x = cardSprite:getContentSize().width * (2 / 15),
            y = cardSprite:getContentSize().height * (14.2 / 15),
            size = FONT_SIZE.HeroSpriteFont.NAME_LABEL_SIZE,
            font = "STHeitiJ-Medium"
        })
        cardSprite:addChild(lvLabel)


        local nameLabel = ui.newTTFLabel({
            text = data:getName(),
            align = ui.TEXT_ALIGN_CENTER,
            x = cardSprite:getContentSize().width / 2,
            y = cardSprite:getContentSize().height * (10 / 155),
            size = FONT_SIZE.HeroSpriteFont.LV_LABEL_SIZE,
            font = "STHeitiJ-Medium"
        })
        cardSprite:addChild(nameLabel)

        cardSprite:setAnchorPoint(CCPointMake(0, 1))
        cardSprite:setPosition(0, self.sprite:getContentSize().height)
        self.sprite:addChild(cardSprite)

        self.bloodSprite = CCProgressTimer:create(display.newSprite("ui/cards/blood03.png"))
        self.bloodSprite:setMidpoint(CCPointMake(1, 0.5))
        self.bloodSprite:setPosition(cardSprite:getContentSize().width /2, cardSprite:getContentSize().height * (25 / 155))
        self.bloodSprite:setType(1)
        self.bloodSprite:setPercentage(100)

        cardSprite:addChild(self.bloodSprite)
        local posX, posY = self.sprite:getPosition()
        local rd = math.random(2, 5)
        local rdTime = math.random(0.5, 1.5)
        self.sprite:runAction(CCRepeatForever:create(
            transition.sequence({
                --CCSpawn:createWithTwoActions( CCMoveBy:create(0.5, CCPointMake(0, rd)), CCRotateBy:create(0.5, rd)),
                --CCSpawn:createWithTwoActions( CCMoveBy:create(0.5, CCPointMake(0, -rd)), CCRotateBy:create(0.5, -rd))
                CCMoveBy:create(rdTime, CCPointMake(0, rd)),
                CCMoveBy:create(rdTime, CCPointMake(0, -rd))
            })) )
        --self.bloodSprite:runAction(action)



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