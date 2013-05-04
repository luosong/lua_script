--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 下午7:05
-- To change this template use File | Settings | File Templates.
--
require("FuncHelper")
require("GameConst")

local CDetailItemSprite = class("CItemShowSprite", function()
     return display.newNode()
end)

function CDetailItemSprite:init()

    self.bg = ResourceMgr:getUISprite("board11")
    if (self.bIsBig == false) then
        self.bg:setScale(0.8)
    end
    self:setPosition(0, 0)
    self:addChild(self.bg)

    local function showMemberHeros()

        self.sprite = ResourceMgr:getSprite(self.info:getAnimId())
        self.sprite:setPosition(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2)
        self.bg:addChild(self.sprite)

        local labelSize = 0
        local nameSize  = 0

        local scaleW = 0
        local scaleH = 0
        if self.bIsBig then
            labelSize = 18
            nameSize  = 26
            scaleW    = 14.8
            scaleH    = 34.2
        else
            labelSize = 22
            nameSize  = 32
            scaleW    = 10
            scaleH    = 26
        end

        --血
        local w = 0
        local h = 0
        local flag = 0
        if self.bIsBig then
            w = 5
            h = 6
        else
            w = 4
            h = 3.8
        end

        self.hpLabel = ui.newTTFLabel({
            text = tostring(self.info:getHp()),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.hpLabel)

        --攻
        if self.bIsBig then
            w = 9.5
            h = 6
        else
            w = 7
            h = 3.8
        end
        self.apLabel = ui.newTTFLabel({
            text = tostring(self.info:getAp()),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.apLabel)

        --防
        if self.bIsBig then
            w = 5
            h = 3.8
        else
            w = 4
            h = 2.0
        end
        self.dpLabel = ui.newTTFLabel({
            text = tostring(self.info:getDp()),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.dpLabel)

        --内
        if self.bIsBig then
            w = 9.5
            h = 3.8
        else
            w = 7
            h = 2.0
        end
        self.mpLabel = ui.newTTFLabel({
            text = tostring(self.info:getMp()),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0, 255, 0)
        })
        self.bg:addChild(self.mpLabel)

        if self.bIsBig then
            w = 3
            h = 26
        else
            w = 2
            h = 20
        end
        self.nameLabel = ui.newBMFontLabel({
            font  = GAME_FONT.font_youyuan,
            text = self.info:getName(),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            width = 26
            -- size = 26,
            -- color = ccc3(0, 255, 0),
            -- dimensions = CCSizeMake(CFuncHelper:getRelativeX(0.5), CFuncHelper:getRelativeX(6))
        })
        self.nameLabel:setColor(ccc3(0,0,0))
        self.nameLabel:setLineBreakWithoutSpace(true)
        self.bg:addChild(self.nameLabel)
    end

    local function  showBaseHeros()
        self.sprite = ResourceMgr:getSprite(self.info.str_anim_id)
        self.sprite:setPosition(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2)
        self.bg:addChild(self.sprite)

        local labelSize = 0
        local nameSize  = 0

        local scaleW = 0
        local scaleH = 0
        if self.bIsBig then
            labelSize = 18
            nameSize  = 26
            scaleW    = 14.8
            scaleH    = 34.2
        else
            labelSize = 22
            nameSize  = 32
            scaleW    = 10
            scaleH    = 26
        end

        --血
        local w = 0
        local h = 0
        local flag = 0
        if self.bIsBig then
            w = 5
            h = 6
        else
            w = 4
            h = 3.8
        end

        self.hpLabel = ui.newTTFLabel({
            text = tostring(self.info.hp),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.hpLabel)

        --攻
        if self.bIsBig then
            w = 9.5
            h = 6
        else
            w = 7
            h = 3.8
        end
        self.apLabel = ui.newTTFLabel({
            text = tostring(self.info.ap),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.apLabel)

        --防
        if self.bIsBig then
            w = 5
            h = 3.8
        else
            w = 4
            h = 2.0
        end
        self.dpLabel = ui.newTTFLabel({
            text = tostring(self.info.dp),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0,255, 0)
        })
        self.bg:addChild(self.dpLabel)

        --内
        if self.bIsBig then
            w = 9.5
            h = 3.8
        else
            w = 7
            h = 2.0
        end
        self.mpLabel = ui.newTTFLabel({
            text = tostring(self.info.mp),
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_CENTER,
            size = 18,
            color = ccc3(0, 255, 0)
        })
        self.bg:addChild(self.mpLabel)

        if self.bIsBig then
            w = 2
            h = 26
        else
            w = 2
            h = 20
        end
        self.nameLabel = ui.newBMFontLabel({
            font  = GAME_FONT.font_youyuan,
            text = self.info.str_name,
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_LEFT,
            width = 26
            -- size = 26,
            -- color = ccc3(0, 255, 0),
            -- dimensions = CCSizeMake(CFuncHelper:getRelativeX(1.5), CFuncHelper:getRelativeX(6))
        })
        self.nameLabel:setColor(ccc3(0,0,0))
        self.nameLabel:setLineBreakWithoutSpace(true);
        self.bg:addChild(self.nameLabel)

    end

    local function showEquip()

    end

    local function showBaseEquip()
        self.sprite = ResourceMgr:getSprite(self.info.str_anim_id)
        self.sprite:setPosition(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2)
        self.bg:addChild(self.sprite)

        local labelSize = 0
        local nameSize  = 0

        local scaleW = 0
        local scaleH = 0
        if self.bIsBig then
            labelSize = 18
            nameSize  = 26
            scaleW    = 14.8
            scaleH    = 34.2
        else
            labelSize = 22
            nameSize  = 32
            scaleW    = 10
            scaleH    = 26
        end

        --血
        local w = 0
        local h = 0
        local flag = 0
        if self.bIsBig then
            w = 5
            h = 6
        else
            w = 4
            h = 3.8
        end



        if self.bIsBig then
            w = 3
            h = 26
        else
            w = 2
            h = 20
        end
        self.nameLabel = ui.newTTFLabel({
            text = self.info.str_name,
            x = self.bg:getContentSize().width * (w / scaleW),
            y = self.bg:getContentSize().height * (h / scaleH),
            align = ui.TEXT_ALIGN_RIGHT,
            size = 26,
            color = ccc3(0, 255, 0),
            dimensions = CCSizeMake(CFuncHelper:getRelativeX(1.5), CFuncHelper:getRelativeX(6))
        })
        self.nameLabel:setColor(ccc3(0,0,0))
        self.bg:addChild(self.nameLabel)
    end

    if ItemShowType.MEMBER_HEROS_INFO == self.itemType then
        printf("---------------ItemShowType.MEMBER_HEROS_INFO-------------------------" .. self.itemType)
        showMemberHeros()
    elseif ItemShowType.BASE_HEROS_INFO == self.itemType then
        printf("-----------------ItemShowType.BASE_HEROS_INFO----------------------- " .. self.itemType)
        showBaseHeros()
    elseif ItemShowType.MEMBER_EQUIP_INFO == self.itemType then
        printf("-------------------ItemShowType.MEMBER_EQUIP_INFO---------------------" .. self.itemType)
        showEquip()
    elseif ItemShowType.BASE_EQUIP_INFO == self.itemType then
        printf("------------------ItemShowType.BASE_EQUIP_INFO----------------------" .. self.itemType)
        showBaseEquip()
    end

end

function CDetailItemSprite:setAnchorPoint(pos)
    self.bg:setAnchorPoint(pos)
end

function CDetailItemSprite:refreshWithData(data)

    local function refreshMemberHeros()
        self.sprite:setDisplayFrame(ResourceMgr:getBodySpriteFrame(data:getAnimId()))
        self.hpLabel:setString(tostring(data:getHp()))
        self.apLabel:setString(tostring(data:getAp()))
        self.dpLabel:setString(tostring(data:getDp()))
        self.mpLabel:setString(tostring(data:getMp()))
        self.nameLabel:setString(data:getName())
    end

    local function refreshBaseHeros()

    end

    local function refreshEquip()


    end

    local function refreshBaseEquip()


    end

    if ItemShowType.MEMBER_HEROS_INFO == self.itemType then
        refreshMemberHeros()
    elseif ItemShowType.BASE_HEROS_INFO == self.itemType then
        refreshBaseHeros()
    elseif ItemShowType.MEMBER_EQUIP_INFO == self.itemType then
        refreshEquip()
    elseif ItemShowType.BASE_EQUIP_INFO == self.itemType then
        refreshBaseEquip()
    end


end

function CDetailItemSprite:ctor(bIsBig, info, itemType)
    self.bIsBig = bIsBig
    self.info = info
    self.itemType = itemType

    self:init()

end

return CDetailItemSprite

