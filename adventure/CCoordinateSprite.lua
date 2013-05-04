--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-13
-- Time: 下午5:55
-- To change this template use File | Settings | File Templates.
--

local CCoordinateSprite = class("CCoordinateSprite", function()
    return  display.newNode()
end)

function CCoordinateSprite:ctor(tag, infoButtonListener, challengeListener, stars, bIsLock, bossid)

    local flagSprite = nil
    local function getheroIconBgName( property )
        local iconBgName = "icon_bg_white"
            if(property == 0) then
                iconBgName = "icon_bg_white"
            elseif(property == 1) then
                iconBgName = "icon_bg_white"           
            elseif(property == 2) then
                iconBgName = "icon_bg_green"
            elseif(property == 3) then
                iconBgName = "icon_bg_blue"
            elseif(property == 4) then
                iconBgName = "icon_bg_yellow"
            elseif(property == 5) then
                iconBgName = "icon_bg_purple"
            end
            return iconBgName
    end
    if(bossid > 0) then
        flagSprite = CSingleImageMenuItem:create(ResourceMgr:getUISprite(getheroIconBgName(BaseData_heros[bossid].property)))
        local bossSpriteName = BaseData_heros[bossid].str_icon
        bossSprite = ResourceMgr:getIconSprite(bossSpriteName)
        flagSprite:addChild(bossSprite)
        bossSprite:setPosition(flagSprite:getContentSize().width/2, flagSprite:getContentSize().height/2)
        flagSprite:setScale(0.8)
        if (bIsLock) then            
            flagSprite:registerScriptTapHandler(challengeListener)
        else         
            bossSprite:setColor(ccc3(100,100,100))  
        end
    else    
        if (bIsLock) then
            flagSprite = CSingleImageMenuItem:create(ResourceMgr:getUISprite("icon_road_point_passed"))
            flagSprite:registerScriptTapHandler(challengeListener)
        else
            flagSprite = CSingleImageMenuItem:create(ResourceMgr:getUISprite("icon_road_point"))

        end
    end


    flagSprite:setPosition(0, 0)


    local challengeMenu = ui.newMenu({})
    challengeMenu:addChild(flagSprite, 1, tag)
    self:addChild(challengeMenu)

    local starBg = ResourceMgr:getUISprite("level_star_bg")
    starBg:setPosition(0, flagSprite:getContentSize().height / 2 + starBg:getContentSize().height / 2)
    starBg:setOpacity(100)
    self:addChild(starBg)

    for i = 1, 3 do
        local starSprite = nil
        if (i > stars) then
            starSprite = ResourceMgr:getUISprite("icon_star3")
        else
            starSprite = ResourceMgr:getUISprite("icon_star2")
        end
        starSprite:setPosition(starBg:getContentSize().width * ((2 + (i - 1) * 2) / 8), starBg:getContentSize().height / 2)
        starBg:addChild(starSprite)

    end


    local infoButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("level_info"))
    infoButton:setPosition(flagSprite:getContentSize().width / 2, -flagSprite:getContentSize().height / 2)
    infoButton:registerScriptTapHandler(infoButtonListener)

    local menu = ui.newMenu({})
    menu:addChild(infoButton, 1, tag)
    self:addChild(menu)
end


return CCoordinateSprite