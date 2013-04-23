--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-19
-- Time: 下午4:08
-- To change this template use File | Settings | File Templates.
--

local CChooseMajorHeroLayer = class("CChooseMajorHeroLayer", function()

    return CCLayerColor:create(ccc4(100, 100, 100, 155), display.width, display.height)
end)

function CChooseMajorHeroLayer:init(index)
    self:setTouchEnabled(true)

    self:registerScriptTouchHandler(function(eventType, x, y)
        if eventType == "began" then
            return true
        end
    end, false, -128, true)


    local bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame(GAME_RES.HUAWEN_BG))
    bg:setPreferredSize(CCSizeMake(display.width * (31 / 40), display.height * (36 / 40)))
    bg:setPosition(display.cx, display.cy)
    self:addChild(bg)

    local closeButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_close"))
    closeButton:registerScriptTapHandler(function()
        self:dispatchEvent({
            name = GlobalVariable["NotificationTag"]["UPDATA_MAINMENUSCENE_ICON"],
            info = "Hello"
        })
        self:removeAllEventListenersForEvent(GlobalVariable["NotificationTag"]["UPDATA_MAINMENUSCENE_ICON"])
        self:removeAllChildrenWithCleanup(true)
        self:removeFromParentAndCleanup(true)
    end)
    closeButton:setPosition(bg:getContentSize().width, bg:getContentSize().height)
    local menu = ui.newMenu({closeButton})
    bg:addChild(menu)

    local function initItem()
        local heros = game.Player:getHeros()
        local nodes = {}
        for k, v in ipairs(heros) do
            nodes[k] = require("possessions.CMemberItemSprite").new(v, 2, index)
        end

        local scrollLayer = require("ui_common.CScrollLayer").new({
            x = display.width * (2 / 40),
            y = display.height * (2.6 / 40),
            width = display.width * (35.8 / 40),
            height = display.height * (35 / 40),
            pageSize = 4,
            rowSize = 1,
            nodes = nodes,
            vertical = true
        })
        scrollLayer:setPosition(0, 0)
        self:addChild(scrollLayer)
    end
    initItem()

end



function CChooseMajorHeroLayer:ctor(index)

    self:init(index)
end

return CChooseMajorHeroLayer



