--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-15
-- Time: 下午6:38
-- To change this template use File | Settings | File Templates.
--

local CEmailScene = class("CEmailScene", function()
    return display.newScene("CEmailScene")
end)

function CEmailScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    self.bg:setPreferredSize(CCSizeMake(display.width * (33.2 / 40), display.height * (36 / 40)))

    self.bg:setPosition(display.width * (20.4 / 40), display.height * (18 / 40))
    self.node:addChild(self.bg)


    local fightButton = nil
    local friendButton = nil
    local sysButton = nil
    local perButton = nil

    local function setSelButtonDisable(buttonType)
        if (perButton) then
            perButton:setEnabled(true)
            perButton:unselected()
        end

        if buttonType == CEmailType.FIGHTING then
            if fightButton then
                fightButton:setEnabled(false)
                fightButton:selected()
                perButton = fightButton
            end
        elseif buttonType == CEmailType.FRIEND then
            if (friendButton) then
                friendButton:setEnabled(false)
                friendButton:selected()
                perButton = friendButton
            end
        else
            if sysButton then
                sysButton:setEnabled(false)
                sysButton:selected()
                perButton = sysButton
            end

        end
    end
    local function initItem(buttonType)
        setSelButtonDisable(buttonType)



    end

    local function initButton()

        local function onButton(buttonType)
            initItem(buttonType)
        end

        local function c_func(f, ...)
            local argc = {... }
            return function()
                f(unpack(argc))
            end
        end

        fightButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, CEmailType.FIGHTING),
        })
        fightButton:setPosition(self.bg:getContentSize().width + fightButton:getContentSize().width / 2,
            self.bg:getContentSize().height - fightButton:getContentSize().height * 0.5)
        local fightLabel =ResourceMgr:getUISprite("font_zd")
        fightLabel:setPosition(fightButton:getContentSize().width / 2, fightButton:getContentSize().height / 2)
        fightButton:addChild(fightLabel)
        local maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - fightButton:getContentSize().height * 0.5)
        self.bg:addChild(maodingSprite, 2)


        friendButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, CEmailType.FRIEND),
        })
        friendButton:setPosition(self.bg:getContentSize().width + friendButton:getContentSize().width / 2,
            self.bg:getContentSize().height - friendButton:getContentSize().height * 1.5)
        local friendLabel = ResourceMgr:getUISprite("font_haoyou")
        friendLabel:setPosition(friendButton:getContentSize().width / 2, friendButton:getContentSize().height / 2)
        friendButton:addChild(friendLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - friendButton:getContentSize().height * 1.5)
        self.bg:addChild(maodingSprite, 2)


        sysButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, CEmailType.SYSTEM),
        })
        sysButton:setPosition(self.bg:getContentSize().width + sysButton:getContentSize().width / 2,
            self.bg:getContentSize().height - sysButton:getContentSize().height * 2.5)
        local sysLabel = ResourceMgr:getUISprite("font_xt")
        sysLabel:setPosition(sysButton:getContentSize().width / 2, sysButton:getContentSize().height / 2)
        sysButton:addChild(sysLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - sysButton:getContentSize().height * 2.5)
        self.bg:addChild(maodingSprite, 2)

        local menu = ui.newMenu({fightButton, friendButton, sysButton})
        self.bg:addChild(menu)
    end



    initButton()
    initItem()
end

function CEmailScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

end

return CEmailScene
