

require("Animation")
require("data.formations_gs")

local CQueueShowLayer = class("CQueueShowLayer", function()
	return display.newLayer()
end)


function CQueueShowLayer:init()

	local cellLayerSize = require("formation_system.CellsLayerSize")

	self.iconNode = display.newNode()
    self.iconNode:setPosition(ccp(0, 0))
    self:addChild(self.iconNode, 2)

	--初始化九个单元格
    local function initBackgroundCell()
        local cellsPos = cellLayerSize:getCellsPos()
        for i = 1, 9 do
            self.cellSprites[i] = require("formation_system.CGridCellNode").new()
            self.cellSprites[i]:setPosition(cellsPos[i].x , cellsPos[i].y)
            self:addChild(self.cellSprites[i]:getLayer())
        end
    end

	
	local iconSprites = {}
	local iconRects = {}
    self.touchSprite = nil

    local function onDeselect(touchSprite)
        iconSprites[touchSprite:getTag()]:setSelect(false)
        iconSprites[touchSprite:getTag()]:setColor(ccc3(255, 255, 255))
        touchSprite:removeFromParentAndCleanup(true)
    end



	--触摸消息处理
	local function onTouch(eventType, x, y)

		if eventType == "began" then
            for k, v in ipairs(self.cellSprites) do
                if v:boundingBox():containsPoint(CCPointMake(x, y)) then
                    if (v:getEmpty() == false) then
                        self.touchSprite = v.touchSprite
                        self.queueType:setHero(k, 0)
                        v:setEmpty(true)
                        v.touchSprite = nil

                    end
                    return true
                end

            end
			return true
        elseif eventType == "moved" then
        	if (self.touchSprite ~= nil) then
                self.touchSprite:setPosition(CCPointMake(x, y))
        	end
        elseif eventType == "ended" then
            if (self.touchSprite ~= nil) then
                for k, v in ipairs(self.cellSprites) do

                    if v:boundingBox():containsPoint(CCPointMake(x, y)) then
                        if (self.queueType:getForm()[k] == 1) then

                            if (v:getEmpty() == false) then
                                onDeselect(v.touchSprite)
                            end
                            self.queueType:setHero(k, self.touchSprite.heroData)
                            local posX, posY = v:getPosition()
                            posY = posY - v:getContentSize().width / 6
                            self.touchSprite:setPosition(CCPointMake(posX, posY))

                            v:setEmpty(false)
                            v.touchSprite = self.touchSprite
                        else
                            onDeselect(self.touchSprite)
                        end
                        self.touchSprite = nil
                        return
                    end
                end
                onDeselect(self.touchSprite)
                self.touchSprite = nil
            end
        end
	end

    --初始化底部人物ICON
	local function initBottomIcon()

		function touchTarget(obj, eventType, x, y, data)
			if (obj:getSelect() == false) then
				if eventType == "began" then
					obj:setSelect(true)
					obj:setColor(ccc3(100, 100, 100))
                    self.touchSprite = ResourceMgr:getSprite(data:getAnimId())
                    self.touchSprite:setAnchorPoint(CCPointMake(0.5, 0))
                    self.touchSprite:setPosition(CCPointMake(x, y))
                    self.touchSprite:setTag(obj:getTag())
                    self.touchSprite:setScale(0.6)
                    self.touchSprite.heroData = data
                    if (self.touchSprite == nil) then
                       CCMessageBox("initBottomIcon", "ERROR")
                    end
					self.iconNode:addChild(self.touchSprite)
		        end
			end
	    end

	    local scroller = nil
	    local bottomIconArea = CCSizeMake(display.width * (3 / 4), display.height / 5.5)
	    local bottomCellWidth = bottomIconArea.width / 5
		local bottomCellHeight = bottomIconArea.height
		local bottomBaseX = (display.width - bottomIconArea.width) / 2
		local bottomBaseY = bottomCellHeight / 10

	    function initIcon()
			local heros = game.Player:getMajorHeros()
	    	--local nodes = {}
	    	if (#heros > 0) then
	    		for k, v in ipairs(heros) do
					iconRects[k] = CCRectMake(bottomBaseX + bottomCellWidth * (k - 1) - bottomCellWidth / 2, 0, bottomCellWidth, bottomCellHeight)
                    iconSprites[k] = require("formation_system.CTouchNode").new(require("ui_object.CHeroIconSprite").new(v))
					iconSprites[k]:setTag(k)
					iconSprites[k]:setTouchTarget(touchTarget)
				end

				scroller = CScrollLayer:create(iconSprites, CCRectMake(bottomBaseX, bottomBaseY, bottomIconArea.width, bottomIconArea.height))
				scroller:setNumOfEachPage(6)
				scroller:setNumOfEachRow(6)
				scroller:setDisplayModel(1)
				self:addChild(scroller)
	    	end
		    
        end
        initIcon()
    end

    --重置位置和UI效果
    local function reset()
        for k, v in ipairs(self.cellSprites) do
            v:setEmpty(true)
            v:setDisplayFrame(display.newSpriteFrame("bagua2.png"))
        end
        self.iconNode:removeAllChildrenWithCleanup(true)
        for k, v in ipairs(iconSprites) do
            v:setSelect(false)
            v:setColor(ccc3(255, 255, 255))
        end
    end


    local function resetIcon(hero)
        for k, v in ipairs(iconSprites) do
            if v:getHeroData():getId() == hero:getId() then
                v:setSelect(true)
                v:setColor(ccc3(100, 100, 100))
                break
            end
        end
    end

    local function getHeroTag(v)
        local heros = game.Player:getHeros()
        if (#heros > 0) then
            for i, value in ipairs(heros) do
                if value:getId() == v:getId() then
                    return i
                end
            end
        end
    end

    local function showHeros(index)
        local formation = game.Player:getFormationById(index)
        for k, v in ipairs(formation:getHeros()) do

            if v ~= 0 then
                local heroSprite = ResourceMgr:getSprite(v:getAnimId())
                heroSprite:setScale(0.6)
                heroSprite:setAnchorPoint(CCPointMake(0.5, 0))
                local posX, posY = self.cellSprites[k]:getPosition()
                posY = posY - self.cellSprites[k]:getContentSize().width / 6
                heroSprite:setPosition(CCPointMake(posX, posY))
                heroSprite.heroData = v
                heroSprite:setTag(getHeroTag(v))

                self.cellSprites[k].touchSprite = heroSprite
                self.cellSprites[k]:setEmpty(false)
                self.iconNode:addChild(heroSprite, 100)

                resetIcon(v)
            end

        end
    end

	--变换阵法
	local function changeQueue(id)

        printf("-------------------------------- id        " .. id)
        self.queueType = game.Player:getFormationById(id)


        local arr = self.queueType:getForm()
		reset()
		for k, v in ipairs(arr) do
			if (v == 1) then
                self.cellSprites[k]:setDisplayFrame(display.newSpriteFrame("bagua1.png"))
			end
        end

        showHeros(id)
    end


	--初始化自己队员
	local function initArmy()
		changeQueue(game.Player:getCurrentFormationId())
	end

	--notification center消息处理
	local function onNotification(event)
		changeQueue(event.info)
    end

    self:registerScriptHandler(function(action)
        if action == "exit" then
            self.iconNode:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)


    function onQuickButton()

        self.queueType:resetForm()

        local heros = game.Player:getMajorHeros()
        local herosLen = #heros
        local i = 1
        for k, v in ipairs(self.queueType:getForm()) do
            if (v == 1) then
                if i > herosLen then
                    break
                end
                self.queueType:setHero(k, heros[i])
                i = i + 1
            end
        end
        changeQueue(self.queueType:getId())
    end

    function initButton()
        local quickSetting = ui.newTTFLabelMenuItem({
            text = require("data.GameText").getText("IDS_QUEUE_SETTING"),
            color = ccc3(0, 255, 0),
            listener = onQuickButton
        })

        quickSetting:setAnchorPoint(CCPointMake(1, 0.5))
        quickSetting:setPosition(display.width - quickSetting:getContentSize().width, quickSetting:getContentSize().height * 2)

        local menus = ui.newMenu({quickSetting})
        self:addChild(menus, 3)
    end

    initButton()


    initBackgroundCell()
	initBottomIcon()
	initArmy()

	self.onNotification = onNotification
	self:setTouchEnabled(true)
    self:addTouchEventListener(onTouch)
end

function CQueueShowLayer:ctor()

	self.cellSprites = {}
	self.iconNode    = nil

	self:init()
end

function CQueueShowLayer:getMagorHeros()
    return self.magorHeros
end


return CQueueShowLayer
