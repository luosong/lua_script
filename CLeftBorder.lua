--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-13
-- Time: 下午2:17
-- To change this template use File | Settings | File Templates.
--

local CLeftBorder = class("CLeftBorder", function()
    return display.newNode()
end)

function CLeftBorder:ctor()

    local backButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_shouye"))
    backButton:setAnchorPoint(CCPointMake(0, 1))
    backButton:setPosition(0, display.height)
    backButton:registerScriptTapHandler(function()
        display.replaceScene(require("CGameMenuScene").new())
    end)

    self.width = backButton:getContentSize().width

    local buttonsBg = ResourceMgr:getUISprite("board06")
    buttonsBg:setAnchorPoint(CCPointMake(0, 0))
    buttonsBg:setPosition(0, 0)
    self:addChild(buttonsBg)

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
    self:addChild(menu)
end

function CLeftBorder:getWidth()
    return self.width
end

return CLeftBorder