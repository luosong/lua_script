--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-26
-- Time: 上午9:54
-- To change this template use File | Settings | File Templates.
--

local CBattleHeroSprite = class("CBattleHeroSprite", function()
    return display.newNode()
end)
function CBattleHeroSprite:refreshHp(hp, fullHp)
    if self.bloodSprite then
        self.bloodSprite:setPercentage((hp / fullHp) * 100)
        self.nameLabel:setString(self.name .. "   " .. string.format("%d", hp))
    end
end

function CBattleHeroSprite:ctor(battleHeroData, bFlix)
    local function initSprite()
        self.name = battleHeroData:getHeroData():getName()
        self.sprite = ResourceMgr:getUISprite("card_bg" .. math.random(1, 2))
        local herosBody = ResourceMgr:getSprite(battleHeroData:getHeroData():getAnimId())
        herosBody:setPosition(self.sprite:getContentSize().width / 2, self.sprite:getContentSize().height * (90 / 155))
        herosBody:setScale(0.51)
        self.sprite:addChild(herosBody)

        if (bFlipX) then
            herosBody:setFlipX(true)
        end

        local cardSprite = ResourceMgr:getUISprite("card_white")
        if(battleHeroData:getHeroData():getProperty() == 1) then
            cardSprite = ResourceMgr:getUISprite("card_white")
        elseif(battleHeroData:getHeroData():getProperty() == 2) then
            cardSprite = ResourceMgr:getUISprite("card_blue")
        elseif(battleHeroData:getHeroData():getProperty() == 3) then
            cardSprite = ResourceMgr:getUISprite("card_yellow")
        elseif(battleHeroData:getHeroData():getProperty() == 4) then
            cardSprite = ResourceMgr:getUISprite("card_green")
        elseif(battleHeroData:getHeroData():getProperty() == 5) then
            cardSprite = ResourceMgr:getUISprite("card_purple")
        end

        local lvLabel = ui.newTTFLabel({
            text = tostring(battleHeroData:getLevel()),
            align = ui.TEXT_ALIGN_LEFT,
            valign = ui.TEXT_VALIGN_TOP,
            x = cardSprite:getContentSize().width * (2 / 15),
            y = cardSprite:getContentSize().height * (14.2 / 15),
            size = FONT_SIZE.HeroSpriteFont.NAME_LABEL_SIZE,
            color = ccc3(0,0,0),
            font = "STHeitiJ-Medium"
        })
        cardSprite:addChild(lvLabel)

        local hp = battleHeroData:getFullHp()
        self.nameLabel = ui.newBMFontLabel({
            text = self.name .. "   " .. string.format("%d", hp),
            align = ui.TEXT_ALIGN_CENTER,
            x = cardSprite:getContentSize().width / 2,
            y = cardSprite:getContentSize().height * (10 / 155),
            font = GAME_FONT.font_youyuan
        })
        self.nameLabel:setScale(0.5)
        cardSprite:addChild(self.nameLabel)

        cardSprite:setAnchorPoint(CCPointMake(0, 1))
        cardSprite:setPosition(0, self.sprite:getContentSize().height)
        self.sprite:addChild(cardSprite)

        self.bloodSprite = CCProgressTimer:create(display.newSprite("ui/cards/blood03.png"))
        self.bloodSprite:setMidpoint(CCPointMake(1, 0.5))
        self.bloodSprite:setPosition(cardSprite:getContentSize().width /2, cardSprite:getContentSize().height * (25 / 155))
        self.bloodSprite:setType(kCCProgressTimerTypeBar)
        self.bloodSprite:setPercentage(100)

        cardSprite:addChild(self.bloodSprite)
        local posX, posY = self.sprite:getPosition()
        local rd = math.random(2, 5)
        local rdTime = math.random(0.5, 1.5)
        self.sprite:runAction(CCRepeatForever:create(
            transition.sequence({
                CCMoveBy:create(rdTime, CCPointMake(0, rd)),
                CCMoveBy:create(rdTime, CCPointMake(0, -rd))
            })) )

        self.sprite:setPosition(0, 0)
        self:addChild(self.sprite)
    end

    initSprite()

end

return CBattleHeroSprite