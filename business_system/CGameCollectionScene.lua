
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
    local baseLayer = require("CBorderLayer").new()
    self:addChild(baseLayer)
    
    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    self.bg:setPosition(game.cx, display.height * (18 / 40))
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
            local rect = CCRect(display.left+100, display.bottom + 30, display.width - 180 , display.height - 130)

            if(self.visiableArray == nil) then
                print("====================================nil====")
            end
            
            self.levelsList = require("views.LevelsList").new(rect, self.indata, self.visiableArray, self.itemType)
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

    local buttonNames = {"font_ry","font_zb","font_wg"}    
    local collectButtons = {}
    local offY = 180
    local offSize = (display.height-offY)/3
    for i=1,3 do
        collectButtons[i] = CSingleImageMenuItem:create(ResourceMgr:getUISprite("board05"))
        collectButtons[i]:setPosition(display.width - collectButtons[i]:getContentSize().width/2, display.height-offY- (i-1)*offSize)
        
        collectButtons[i]:registerScriptTapHandler(function()
            if(self.itemType ~= i) then
                print("item:" .. self.itemType .. "," .. i)
                self:removeChildByTag(100,false)
                local rect = CCRect(display.left+100, display.bottom + 30, display.width - 180 , display.height - 130)
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
                    collectButtons[i]:setPosition(display.width - collectButtons[i]:getContentSize().width/2, display.height-offY- (i-1)*offSize)
                end
                collectButtons[i]:setPosition(display.width - collectButtons[i]:getContentSize().width/2-5, display.height-offY- (i-1)*offSize)

                self.levelsList:addEventListener("onTapLevelIcon", function(event)
                return self:onTapLevelIcon(event)
                end)
            end

        end)
        local text = ResourceMgr:getUISprite(buttonNames[i])
        text:setPosition(collectButtons[i]:getContentSize().width/2, collectButtons[i]:getContentSize().height/2)
        collectButtons[i]:addChild(text)

    end

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

