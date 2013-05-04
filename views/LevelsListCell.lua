
require("ResourceMgr")

local ScrollViewCell = require("ui.ScrollViewCell")
local LevelsListCell = class("LevelsListCell", ScrollViewCell)

function LevelsListCell:ctor(size, beginLevelIndex, endLevelIndex, rows, cols, inData, rect, VisiableArray, itemType, startY)
    local rowHeight = math.floor((size.height) / rows)
    local colWidth = math.floor(size.width  / cols)

    GAME_TEXTURE_DATA_FILENAME  = "AllSprites.plist"
    GAME_TEXTURE_IMAGE_FILENAME = "AllSprites.png"

    PLIST_NAME = "heros/icons/icon_heros_1.plist"
    TEXTURE_NAME = "heros/icons/icon_heros_1.png"

    local testsprite = display.newSprite("heros/icons/icon_heros_1.png")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)



    local batch = display.newBatchNode(TEXTURE_NAME)
    self:addChild(batch)
    self.pageIndex = pageIndex
    self.buttons = {}

    local startX =  rect.origin.x + (rect.size.width - colWidth * (cols - 1)) / 2
    local y = startY - 80
    local levelIndex = beginLevelIndex

    local isVisiableArray = {}

    for i,v in ipairs(VisiableArray) do
        if(v~= nil) then
            isVisiableArray[v] = true
        end
    end


    for row = 1, rows do
        local x = startX
        for column = 1, cols do
            local icon = nil
            local iconBg = null
            local isVisiable = true
            if(isVisiableArray[levelIndex] == nil) then
                isVisiable = false
            end

            isVisiable = true
            
            if(isVisiable) then
                icon =  ResourceMgr:getIconSprite(inData[levelIndex].str_icon, x, y)--display.newSprite("#icon_azi.png", x, y)
                local iconBgName = "icon_bg_white"
                if(inData[levelIndex].property == 0) then
                    iconBgName = "icon_bg_white"
                elseif(inData[levelIndex].property == 1) then
                    iconBgName = "icon_bg_white"           
                elseif(inData[levelIndex].property == 2) then
                    iconBgName = "icon_bg_green"
                elseif(inData[levelIndex].property == 3) then
                    iconBgName = "icon_bg_blue"
                elseif(inData[levelIndex].property == 4) then
                    iconBgName = "icon_bg_yellow"
                elseif(inData[levelIndex].property == 5) then
                    iconBgName = "icon_bg_purple"
                end

                -- 装备，武功的背景icon不同，需要另外设置
                if(itemType ~= CollectionType.HERO) then
                    iconBgName = iconBgName .. "2"
                end

                iconBg = ResourceMgr:getUISprite(iconBgName, x, y)
                
                if(iconBg ~= nil) then
                    self:addChild(iconBg)
                end
            else
                icon = ResourceMgr:getUISprite("icon_bg_none", x, y)
            end
            
            
            self:addChild(icon)
            icon.levelIndex = levelIndex
            icon.name = inData[levelIndex].str_name
            self.buttons[#self.buttons + 1] = icon

            if(isVisiable) then
                local label = ui.newBMFontLabel({
                    text  = icon.name,
                    font  = "fonts/font_names.fnt",
                    x     = x,
                    y     = y - icon:getContentSize().height*4/5,
                    align = ui.TEXT_ALIGEN_CENTER,
                })

                label:setColor(ccc3(156,74,55))
                self:addChild(label)
            end
            x = x + colWidth
            levelIndex = levelIndex + 1
            if levelIndex > endLevelIndex then break end
        end

        y = y - rowHeight
        if levelIndex > endLevelIndex then break end
    end

    -- add highlight level icon
    self.highlightButton = display.newSprite("#HighlightLevelIcon.png")
    self.highlightButton:setVisible(false)
    self:addChild(self.highlightButton)
end

function LevelsListCell:onTouch(event, x, y)
    if event == "began" then
        local button = self:checkButton(x, y)
        if button then
            self.highlightButton:setVisible(true)
            self.highlightButton:setPosition(button:getPosition())
        end
    elseif event ~= "moved" then
        self.highlightButton:setVisible(false)
    end
end

function LevelsListCell:onTap(x, y)
    local button = self:checkButton(x, y)
    if button then
        self:dispatchEvent({name = "onTapLevelIcon", levelIndex = button.levelIndex})
    end
end

function LevelsListCell:checkButton(x, y)
    local pos = ccp(x, y)
    for i = 1, #self.buttons do
        local button = self.buttons[i]
        if button:boundingBox():containsPoint(pos) then
            return button
        end
    end
    return nil
end

return LevelsListCell
