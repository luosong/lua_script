--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-19
-- Time: 下午1:41
-- To change this template use File | Settings | File Templates.
--

require("data.levels_gs")

local CAdventureScene = class("CAdventureScene", function()
    return display.newScene("CAdventureScene")
end)

function CAdventureScene:init()

    local currentMap =  levels[self.mapID]
--    local bg = display.newSprite("ui/bg01.png")
--    bg:setAnchorPoint(CCPointMake(0, 0))
--    self.layer:addChild(bg)
    self.map = display.newSprite(currentMap.map)
    self.map:setAnchorPoint(CCPointMake(1, 0))
    self.map:setPosition(display.width, CFuncHelper:getTopBarH())
    self.layer:addChild(self.map)

    local headerSprite = ResourceMgr:getUISprite("board01")
    headerSprite:setAnchorPoint(CCPointMake(0, 0.5))
    headerSprite:setPosition(self.leftBorder:getWidth(), display.height - headerSprite:getContentSize().height / 2-CFuncHelper:getTopBarH())
    self.layer:addChild(headerSprite)

    local headerBg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame("board24"))
    headerBg:setPreferredSize(CCSizeMake(display.width - self.leftBorder:getWidth() - headerSprite:getContentSize().width,
        CFuncHelper:getRelativeY(4.2)))
    headerBg:setAnchorPoint(CCPointMake(0, 0.5))
    headerBg:setPosition(self.leftBorder:getWidth() + headerSprite:getContentSize().width, 
        display.height - headerBg:getContentSize().height / 2 - CFuncHelper:getTopBarH())
    self.layer:addChild(headerBg)

    local resetMap = nil
    function initLevelsButton()

        local nodes = {}
        local preClickedButton = nil
        local onMapButton = function(data, index)
            self.mapID =  data.id
            resetMap()

            if (preClickedButton) then
                preClickedButton:setEnable(true)
            end
            preClickedButton = nodes[index]
            nodes[index]:setEnable(false)
        end

        local function c_func(f, ...)
            local args = {... }
            return function()
                f(unpack(args))
            end
        end

        for k, v in ipairs(levels) do
            nodes[k] = require("ui_common.CScrollCell").new(ResourceMgr:getUISprite("board26"))
            nodes[k]:setTouchListener(c_func(onMapButton, v,  k))
            if v.id == self.mapID then
                nodes[k]:setEnable(false)
                preClickedButton = nodes[k]
            end
            local label = ui.newTTFLabel({
                text = v.name,
                align = ui.TEXT_ALIGN_CENTER

            })
            nodes[k]:addChild(label)
        end

        local scrollLayer = require("ui_common.CScrollLayer").new({
            x = self.leftBorder:getWidth() + headerSprite:getContentSize().width + 6,
            y = display.height - headerBg:getContentSize().height - CFuncHelper:getTopBarH(),
            width = headerBg:getContentSize().width - 13,
            height = headerBg:getContentSize().height,
            pageSize = 3,
            rowSize = 3,
            nodes = nodes,
            vertical = false,
            bFreeScroll = true
        })
        scrollLayer:setCurrentNode(20)
        scrollLayer:setPosition(0, 0)
        self.layer:addChild(scrollLayer)
    end

    initLevelsButton()

    --local infoMenu = ui.newMenu({})
    --self.layer:addChild(infoMenu)
    local infoLayer = nil

    local function onInfoButton(tag)
        if (infoLayer ~= nil) then
            infoLayer:removeFromParentAndCleanup(true)
            infoLayer = nil
        end
        local infoLayerY = 0 + CFuncHelper:getTopBarH()
        infoLayer = require("adventure.CMapInfoLayer").new(currentMap[tag])
        infoLayer:setPosition(display.width + infoLayer:getContentSize().width, infoLayerY)
        self.layer:addChild(infoLayer)

        transition.moveTo(infoLayer, {x = display.width, y = infoLayerY, time = 0.3})
    end

    local function onChallenge(tag)

        if (game.Player:getCurrentFormation():isSetForm() == false) then
            local tipBox = require("ui_common.CPromptBox").new({
                title = "提示",
                info = "当前阵法还没有布置任务，现在就去设置吗？",
                ok_text = "确定",
                cancel_text = "取消",
                listener = function()
                    display.replaceScene(require("formation_system.CQueueSettingScene").new(1, 1))
                end
            })
            tipBox:setPosition(0, 0)
            self.layer:addChild(tipBox)
        else
            display.replaceScene(require("battle_system.CBattleScene").new({ currentMap.id, tag }, BattleType.Adventure_map))
        end
    end

    local flagIconNodes = display.newNode()
    flagIconNodes:setPosition(0, 0)
    self.layer:addChild(flagIconNodes)
    local function initSubMap()

        local function getheroID( form )
            for i,v in ipairs(form) do
                if(v > 0) then
                    return v
                end
            end
            return 10
        end
        flagIconNodes:removeAllChildrenWithCleanup(true)
        for k, v in ipairs(currentMap) do
            local bossid = 0
            if(v.bossType > 0) then
                bossid = getheroID(v.form)
            end
            local icon = require("adventure.CCoordinateSprite").new(k, onInfoButton,
                onChallenge, game.Player:getStarsById(self.mapID, v.id), game.Player:isLevelUnlock(self.mapID, v.id), bossid)
            icon:setPosition(display.width * (v.pos.x / 40), display.height * (v.pos.y / 40))
            flagIconNodes:addChild(icon)
        end
    end

    resetMap = function ()
        currentMap = levels[self.mapID]
        self.map:setDisplayFrame(CCSpriteFrame:createWithTexture(display.newSprite(currentMap.map):getTexture(),
            self.map:getTextureRect()))
        initSubMap()
    end

    local function initCtlButton()
        --前进按钮
        local nextMapButton = ui.newTTFLabelMenuItem({
            text     = require("data.GameText").getText("next_map"),
            color    = ccc3(0, 255, 0),
            size     = 22,
            listener = function(tag)
                if self.mapID >= #levels then
                    return
                end
                self.mapID = self.mapID + 1
                resetMap()
            end
        })
        nextMapButton:setPosition(display.width * (35 / 40), display.height * (5 / 40))

        --------------------------------------------
        --后退按钮
        local preMapButton = ui.newTTFLabelMenuItem({
            text     = require("data.GameText").getText("pre_map"),
            color    = ccc3(0, 255, 0),
            size     = 22,
            listener = function(tag)
                if self.mapID <= 1 then
                    return
                end
                self.mapID = self.mapID - 1
                resetMap()
            end
        })
        preMapButton:setPosition(display.width * (5 / 40), display.height * (5 / 40))
        local ctlMenu = ui.newMenu({nextMapButton, preMapButton})
        ctlMenu:setPosition(0, 0)
        self.layer:addChild(ctlMenu)
    end

    self.layer:addTouchEventListener(function()
        if (infoLayer ~= nil) then
            local action = transition.sequence({
                CCMoveTo:create(0.1, CCPointMake(display.width + infoLayer:getContentSize().width, CFuncHelper:getTopBarH())),
                CCCallFunc:create(function()
                    infoLayer:removeFromParentAndCleanup(true)
                    infoLayer = nil
                end)
            })
            infoLayer:runAction(action)
        end

    end)
    self.layer:setTouchEnabled(true)
    initCtlButton()
    initSubMap()
end

function CAdventureScene:test( ptr)

    local gameNetWork = require("GameNetWork").new()


    local function uploadCB( ... )
        ptr:init()
    end
    gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
        REQUEST_ID["LEVEL_DOWNLOAD"], {}, uploadCB)

end

function CAdventureScene:ctor(mapId)

    self.layer = display.newLayer()
    self.layer:setPosition(0, 0)
    self:addChild(self.layer)
    self.mapID = mapId or 1

    self.leftBorder = require("CLeftBorder").new()
    self.leftBorder:setPosition(0, 0)
    self.layer:addChild(self.leftBorder)

    local mapBg = display.newSprite("ui/bg04.png")
    mapBg:setAnchorPoint(CCPointMake(0,0))
    mapBg:setPosition(self.leftBorder:getWidth(), CFuncHelper:getTopBarH())
    self.layer:addChild(mapBg)

    --loading界面
    local loading = require("ui_common.CLoadingLayer")
    loading.new(CAdventureScene.test, self)
    -- self:init()

--    local gridLine = CGridLineLayer:create()
--    gridLine:setPosition(0, 0)
--    self:addChild(gridLine)

end

return CAdventureScene