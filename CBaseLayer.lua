--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-18
-- Time: 上午10:43
-- To change this template use File | Settings | File Templates.
--

local CBaseLayer = class("CBaseLayer", function()
    return display.newLayer()
end)

function CBaseLayer:setScrollString(str)
    self.scrollLabel:start(str)
end

function CBaseLayer:init(bIsHomePage)
    self.bg = display.newNode()
    self:addChild(self.bg, 0)

    local NormalButton = require("views.NormalButton")
    local backButton = NormalButton.new({
            image = ResourceMgr:getUISpriteFrameName("button_shouye"),
            x = 0,
            y = display.height,
            buttonType = NormalButton.TYPE_DARKER,

            listener = function()
                display.replaceScene(require("CGameMenuScene").new())
            end,
        })

    backButton:setPosition(backButton:getContentSize().width/2, display.height-backButton:getContentSize().height/2)



    if (bIsHomePage) then

        local topBg = CCScale9Sprite:createWithSpriteFrameName("board20.png")
        topBg:setPreferredSize(CCSizeMake(display.width - backButton:getContentSize().width , display.height * (5.5 / 40)))

        --local topBg = ResourceMgr:getUISprite("board20")
        topBg:setAnchorPoint(CCPointMake(0, 0.5))
        topBg:setPosition(backButton:getContentSize().width, display.height - topBg:getContentSize().height / 2)
        self.bg:addChild(topBg)

    else
        local topBg = ResourceMgr:getUISprite("board01")
        topBg:setAnchorPoint(CCPointMake(0, 1))
        topBg:setPosition(backButton:getContentSize().width, display.height)
        self.bg:addChild(topBg)
    end

    local broadcast = ResourceMgr:getUISprite("board02")
    broadcast:setAnchorPoint(CCPointMake(1, 1))
    broadcast:setPosition(display.width, display.height)
    self.bg:addChild(broadcast)

    self.scrollLabel = require("ui_common.CScrollLabel").new({
        x = display.width - broadcast:getContentSize().width * 0.87,
        y =  display.height - broadcast:getContentSize().height,
        width = broadcast:getContentSize().width * (15.5 / 18.5),
        height = display.height * (2.3 / 40)
    })
    local disMsg = "Welcome to 大保镖"
    self.bg:addChild(self.scrollLabel, 1000)
    self.scrollLabel:scroll(disMsg)

--
--    local titleLabel = ui.newTTFLabel({
--        text = game.Player:getName(),
--        size = 38,
--        x = titleBg:getContentSize().width / 2,
--        y = titleBg:getContentSize().height / 2,
--        align = ui.TEXT_ALIGN_CENTER
--    })
--    titleBg:addChild(titleLabel)


    function RecvSysMsgCB(data)
        local msg = ""
        codeJson = data
        msgList = codeJson["Body"]["syssend"];
        for k, v in pairs(msgList) do            
            msg = msg .. v .. "  "
        end
        self.scrollLabel:scroll(msg)
    end

    local gnw = require ("GameNetWork").new()
    function UpdateMsgText( dt )
        local msg = {msg = "recv"}
        gnw:SendData(game.Player:getPlayerID(), game.Player:getServerID(), 
            REQUEST_ID["MSG_SYS_SERVER_TO_CLIENT"],msg, RecvSysMsgCB)
    end
    self.scheduler = require("framework.client.scheduler")
    self.scheduleUpdate = self.scheduler.scheduleGlobal( UpdateMsgText, 60, false)

    local buttonsBg = ResourceMgr:getUISprite("board06")
    buttonsBg:setAnchorPoint(CCPointMake(0, 0))
    buttonsBg:setPosition(0, 0)
    self.bg:addChild(buttonsBg)
    --buttonsBg:setOpacity(150)

    -------------------比武-------------------------------
    local biWuButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_biwu"))
    biWuButton:setPosition(buttonsBg:getContentSize().width / 2, buttonsBg:getContentSize().height * (30 / 34))
    biWuButton:registerScriptTapHandler(function()
        display.replaceScene(require("competition.CCompetitionScene").new())
    end)

    --------------------闯江湖----------------------------------
    local adventureButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_jianghu"))
    adventureButton:setPosition(buttonsBg:getContentSize().width / 2, buttonsBg:getContentSize().height * (24 / 34))
    adventureButton:registerScriptTapHandler(function()
        display.replaceScene(require("adventure.CAdventureScene").new())
    end)

    -------------------活动---------------------------------
    local activityButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_huodong"))
    activityButton:setPosition(buttonsBg:getContentSize().width / 2, buttonsBg:getContentSize().height * (18 / 34))
    activityButton:registerScriptTapHandler(function()
        display.replaceScene(require("activity_sys.CActivityScene").new())
    end)

    ----------------招贤----------------------------------
    local zxButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_zhaoxian"))
    zxButton:setPosition(buttonsBg:getContentSize().width / 2, buttonsBg:getContentSize().height * (12 / 34))
    zxButton:registerScriptTapHandler(function()
        display.replaceScene(require("business_system.CRecruitScene").new())
    end)

    ----------------阵型--------------------------
    local queueButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_zhenrong"))
    queueButton:setPosition(buttonsBg:getContentSize().width / 2, buttonsBg:getContentSize().height * (6 / 34))
    queueButton:registerScriptTapHandler(function()
        display.replaceScene(require("formation_system.CQueueSettingScene").new(1, 1))
    end)

    local menu = ui.newMenu({backButton, biWuButton, adventureButton, activityButton, zxButton, queueButton})
    self.bg:addChild(menu)

    if(GAME_DEBUG.ENABLE_GRID) then
        local gridLine = CGridLineLayer:create()
        gridLine:setPosition(0, 0)
        self:addChild(gridLine)
    end
    self:registerScriptHandler(function(action)

        if action == "exit" then
            gnw:disconnect()
            self.scheduler.unscheduleGlobal(self.scheduleUpdate)

            self.bg:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)

end

function CBaseLayer:ctor(bIsHomePage)
    self.scrollLabel = nil
    self:init(bIsHomePage)
end

function CBaseLayer:onExit( ... )
    -- body
end

return CBaseLayer