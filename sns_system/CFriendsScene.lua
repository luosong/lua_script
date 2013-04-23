--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-20
-- Time: 下午4:00
-- To change this template use File | Settings | File Templates.
--

local CFriendsScene = class("CFriendsScene", function()
    return display.newScene("CFriendsScene")
end)

function CFriendsScene:init()

    local bg = display.newSprite("ui/bg01.png")
    bg:setAnchorPoint(CCPointMake(0, 0))
    bg:setPosition(0, 0)
    self.node:addChild(bg)

    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrameName("board29.png")
    self.bg:setPreferredSize(CCSizeMake(display.width * (33.2 / 40), display.height * (36 / 40)))

    self.bg:setPosition(display.width * (20.4 / 40), display.height * (18 / 40))
    self.node:addChild(self.bg)

    local nodes = {}
    local friendButton = nil
    local enemyButton = nil
    local addFriendButton = nil
    local perButton = nil

    local function setSelButtonDisable(buttonType)
        if (perButton) then
            perButton:setEnabled(true)
            perButton:unselected()
        end

        if buttonType == CFirendType.FINDFRIEND then
            if addFriendButton then
                addFriendButton:setEnabled(false)
                addFriendButton:selected()
                perButton = addFriendButton
            end

        elseif buttonType == CFirendType.ENEMY then
            if (enemyButton) then
                enemyButton:setEnabled(false)
                enemyButton:selected()
                perButton = enemyButton
            end
        else
            if friendButton then
                friendButton:setEnabled(false)
                friendButton:selected()
                perButton = friendButton
            end

        end
    end

    local function initItem(buttonType)
        setSelButtonDisable(buttonType)

--        local friends = game.Player:getFriends()
--        if #friends >= 1 then
--
--            local function onFriend()
--
--            end
--
--            local function onEnhanceButton(tag, sender)
--                --printf("--------------Friends----------" .. sender.data:getName())
--            end
--
--            for k, v in ipairs(friends) do
--
--                nodes[k] = require("possessions.CItemSprite").new(v, 2)
--                nodes[k]:setTouchListener(onTouchItem)
--
--                local button = CSingleImageMenuItem:create("button_use.png")
--                button.data = v
--                button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
--                button:registerScriptTapHandler(onFriend)
--
--                local menu = ui.newMenu({button})
--                menu:setPosition(0, 0)
--                nodes[k]:addChild(menu)
--            end
--
--            local scrollLayer = require("ui_common.CScrollLayer").new({
--                x = display.width * (4 / 40),
--                y = display.height * (0.6 / 40),
--                width = display.width * (35.8 / 40),
--                height = display.height * (35 / 40),
--                pageSize = 4,
--                rowSize = 1,
--                nodes = nodes,
--                vertical = true
--            })
--            scrollLayer:setPosition(0, 0)
--            self.node:addChild(scrollLayer)
--        else
--            local label = ui.newTTFLabel({
--                text = "江湖上行走，没有几个朋友哪行？",
--                size = 38,
--                x    = game.cx,
--                y    = display.cy,
--                align = ui.TEXT_ALIGN_CENTER
--            })
--
--            self.node:addChild(label)
--        end

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

        friendButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, CFirendType.FRIEND),
        })
        friendButton:setPosition(self.bg:getContentSize().width + friendButton:getContentSize().width / 2,
            self.bg:getContentSize().height - friendButton:getContentSize().height * 0.5)
        local friendLabel =ResourceMgr:getUISprite("font_haoyou")
        friendLabel:setPosition(friendButton:getContentSize().width / 2, friendButton:getContentSize().height / 2)
        friendButton:addChild(friendLabel)
        local maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - friendButton:getContentSize().height * 0.5)
        self.bg:addChild(maodingSprite, 2)


        enemyButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton, CFirendType.ENEMY),
        })
        enemyButton:setPosition(self.bg:getContentSize().width + enemyButton:getContentSize().width / 2,
            self.bg:getContentSize().height - enemyButton:getContentSize().height * 1.5)
        local enemyLabel = ResourceMgr:getUISprite("font_cd")
        enemyLabel:setPosition(enemyButton:getContentSize().width / 2, enemyButton:getContentSize().height / 2)
        enemyButton:addChild(enemyLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - enemyButton:getContentSize().height * 1.5)
        self.bg:addChild(maodingSprite, 2)


        addFriendButton = ui.newImageMenuItem({
            image = "#board31.png",
            imageSelected = "#board30.png",
            listener = c_func(onButton,CFirendType.FINDFRIEND),
        })
        addFriendButton:setPosition(self.bg:getContentSize().width + addFriendButton:getContentSize().width / 2,
            self.bg:getContentSize().height - addFriendButton:getContentSize().height * 2.5)
        local addLabel = ResourceMgr:getUISprite("font_jj")
        addLabel:setPosition(addFriendButton:getContentSize().width / 2, addFriendButton:getContentSize().height / 2)
        addFriendButton:addChild(addLabel)
        maodingSprite = ResourceMgr:getUISprite("maoding")
        maodingSprite:setPosition(self.bg:getContentSize().width,
            self.bg:getContentSize().height - addFriendButton:getContentSize().height * 2.5)
        self.bg:addChild(maodingSprite, 2)

        local menu = ui.newMenu({enemyButton, friendButton, addFriendButton})
        self.bg:addChild(menu)
    end

    initButton()

    initItem()

end

function CFriendsScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CFriendsScene



