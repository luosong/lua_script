
--[[

 @Author shan 
 @Date:

]]
require("data.heros_gs")
require("data.equipments_gs")
require("data.skills_gs")

local CGameCollectionScene = class("CGameCollectionScene", function ( )	
	return display.newScene("CGameCollectionScene")
end)



function CGameCollectionScene:ctor()
	-- local bg = display.newSprite("u10.PNG");
 --    bg:setScaleX(display.width/bg:getContentSize().width)
	-- bg:setPosition(display.width/2, display.height/2)
	-- self:addChild(bg)
        -- CONFIG_SCREEN_HEIGHT = 640,ipad，上下加板


    local baseLayer = require("CBorderLayer").new()
    self:addChild(baseLayer)
    

     -- 背景
    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    -- self.bg:setPreferredSize(CCSizeMake(display.width * ( rightX / 40), baseLayer:getLeftHeight()))
    -- self.bg:setPosition(baseLayer:getLeftWidth() + self.bg:getContentSize().width/2, baseLayer:getLeftHeight()/2 + CFuncHelper:getTopBarH())
    self:addChild(self.bg)


    -- initialize the values
    self.index = 1
    self.indata = BaseData_heros
    self.visiableArray = game.Player:getCollections(1)
    self.itemType = 1

    function LoadUpdate( dt )

        if(self.index == 1) then
            device.showActivityIndicator()
        elseif(self.index == 2) then
                -- create levels list
            local rect = CCRect(display.left+baseLayer:getLeftWidth()+12, display.bottom + 30+CFuncHelper:getTopBarH(), display.width - baseLayer:getLeftWidth()-20 - CFuncHelper:getRightBarW() , baseLayer:getLeftHeight())

            if(self.visiableArray == nil) then
                print("====================================nil====")
            end
            local startY =  CFuncHelper:getTopBarH() + baseLayer:getLeftHeight()
            self.levelsList = require("views.LevelsList").new(rect, self.indata, self.visiableArray, self.itemType, startY)
            self.levelsList:addEventListener("onTapLevelIcon", function(event)
                return self:onTapLevelIcon(event)
            end)

            self:addChild(self.levelsList, 1, 100)
            self.levelsList:setTouchEnabled(true)
        elseif(self.index == 3) then
            self.index = 0
            device.hideActivityIndicator()   
            self.scheduler.unscheduleGlobal(self.schedulerNextScene)
            -- display.replaceScene(require("CGameMenuScene").new())
            
        end
        self.index = self.index + 1               
    end

    self.scheduler = require("framework.client.scheduler")
    self.schedulerNextScene = self.scheduler.scheduleGlobal( LoadUpdate, 0.1, false)




    -- right buttons

    local buttonNames = {"font_rw","font_zbei","font_wug"}    
    local collectButtons = {}
    local offY = 180
    local offSize = baseLayer:getLeftHeight()/3
    for i=1,3 do
        collectButtons[i] = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
          --  listener = c_func(onButton),
        })--CSingleImageMenuItem:create(ResourceMgr:getUISprite("board31"))
        collectButtons[i]:setPosition(display.width -  collectButtons[i]:getContentSize().width/2, 
                    baseLayer:getLeftHeight() + CFuncHelper:getTopBarH()- (i-1)*collectButtons[i]:getContentSize().height - collectButtons[i]:getContentSize().height/2)
        
        collectButtons[i]:registerScriptTapHandler(function()
            if(self.itemType ~= i) then

                print("item:" .. self.itemType .. "," .. i)
                self:removeChildByTag(100,false)
                local rect = CCRect(display.left+baseLayer:getLeftWidth(), display.bottom +CFuncHelper:getTopBarH(), display.width - baseLayer:getLeftWidth() - CFuncHelper:getRightBarW() , baseLayer:getLeftHeight())
                local arrayname = {}
                if(i == CollectionType.HERO) then
                    arrayname = BaseData_heros
                elseif(i == CollectionType.EQUIP) then
                    arrayname = BaseData_equipments
                elseif(i == CollectionType.SKILL) then
                    arrayname = BaseData_skills
                end
                self.itemType = i
                self.visiableArray = game.Player:getCollections(i)
                self.indata = arrayname
                self.scheduler = require("framework.client.scheduler")
                self.schedulerNextScene = self.scheduler.scheduleGlobal( LoadUpdate, 0.5, false)

                for i=1,3 do
                    collectButtons[i]:unselected()
                    collectButtons[i]:setPosition(display.width -  collectButtons[i]:getContentSize().width/2,
                     baseLayer:getLeftHeight() + CFuncHelper:getTopBarH()- (i-1)*collectButtons[i]:getContentSize().height - collectButtons[i]:getContentSize().height/2)
                end

                collectButtons[i]:setPosition(display.width -  collectButtons[i]:getContentSize().width/2-1,
                    baseLayer:getLeftHeight() + CFuncHelper:getTopBarH()- (i-1)*collectButtons[i]:getContentSize().height - collectButtons[i]:getContentSize().height/2)
                collectButtons[i]:selected()

                self.levelsList:addEventListener("onTapLevelIcon", function(event)
                return self:onTapLevelIcon(event)
                end)
            end

        end)
        local text = ResourceMgr:getUISprite(buttonNames[i])
        text:setPosition(collectButtons[i]:getContentSize().width/2, collectButtons[i]:getContentSize().height/2)
        collectButtons[i]:addChild(text)

        local maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(0, 
            collectButtons[i]:getContentSize().height/2)
        collectButtons[i]:addChild(maodingSprite)

        -- set bg position
        self.bg:setPreferredSize(CCSizeMake(display.width - baseLayer:getLeftWidth() - collectButtons[1]:getContentSize().width, baseLayer:getLeftHeight()))
        self.bg:setPosition(baseLayer:getLeftWidth() + self.bg:getContentSize().width/2, baseLayer:getLeftHeight()/2 + CFuncHelper:getTopBarH())
    end
    collectButtons[1]:selected()

    local ctrMenu = ui.newMenu(collectButtons)
    self:addChild(ctrMenu)
end

function CGameCollectionScene:onEnter()
    -- avoid unmeant back
    -- self:performWithDelay(function()
    --     self.layer:setKeypadEnabled(true)
    -- end, 0.5)
end

function CGameCollectionScene:onTapLevelIcon(event)
    audio.playSound(GAME_SFX.tapButton)
    local infoNode = require("business_system.CCollectionInfoScene").new(event.levelIndex, self.itemType)
    infoNode:setPosition(display.width,0)
    transition.moveTo(infoNode,{x = 0, y = 0, time = 0.8})
    self:addChild(infoNode,10)
    -- game.playLevel(event.levelIndex)
end


function CGameCollectionScene:onExit( ... )
    CCTextureCache:sharedTextureCache():removeUnusedTextures()
end


--[[end class]]
return CGameCollectionScene

