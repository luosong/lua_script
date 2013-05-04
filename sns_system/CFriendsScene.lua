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

game.Player:addFriend("a")
game.Player:addFriend("b")
game.Player:addFriend("c")
game.Player:addFriend("d")
game.Player:addFriend("e")


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

    local itemNodes = display.newNode()
    itemNodes:setPosition(0, 0)
    self.node:addChild(itemNodes)

    local function initItem(buttonType)
        setSelButtonDisable(buttonType)
        itemNodes:removeAllChildrenWithCleanup(true)

        local function initFriendItem()
            local friends = game.Player:getFriends()
            if #friends >= 1 then

                local function onFriend()
                end

                local function onEnhanceButton()

                end

                for k, v in ipairs(friends) do

                    nodes[k] = require("sns_system.CFriendItemSprite").new()
                    nodes[k]:setTouchListener(onTouchItem)

                    local button = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_small"))
                    button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
                    button:registerScriptTapHandler(onFriend)

                    local menu = ui.newMenu({ button })
                    menu:setPosition(0, 0)
                    nodes[k]:addChild(menu)
                end

                local scrollLayer = require("ui_common.CScrollLayer").new({
                    x = display.width * (5 / 40),
                    y = display.height * (2 / 40),
                    width = display.width * (30.8 / 40),
                    height = display.height * (32 / 40),
                    pageSize = 4,
                    rowSize = 1,
                    nodes = nodes,
                    vertical = true
                })
                scrollLayer:setPosition(0, 0)
                itemNodes:addChild(scrollLayer)
            else
                local label = ui.newTTFLabel({
                    text = "江湖上行走，没有几个朋友哪行？",
                    size = 38,
                    x = game.cx,
                    y = display.cy,
                    align = ui.TEXT_ALIGN_CENTER
                })

                itemNodes:addChild(label)
            end
        end

        local function initEnemyItem()
            local friends = game.Player:getFriends()
            if #friends >= 1 then

                local function onFriend()
                end

                local function onEnhanceButton(tag, sender)

                end

                for k, v in ipairs(friends) do

                    nodes[k] = require("sns_system.CFriendItemSprite").new()
                    nodes[k]:setTouchListener(onTouchItem)

                    local button = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_small"))
                    button:setPosition(nodes[k]:getContentSize().width * (10 / 32), 0)
                    button:registerScriptTapHandler(onFriend)

                    local menu = ui.newMenu({ button })
                    menu:setPosition(0, 0)
                    nodes[k]:addChild(menu)
                end

                local scrollLayer = require("ui_common.CScrollLayer").new({
                    x = display.width * (5 / 40),
                    y = display.height * (2 / 40),
                    width = display.width * (30.8 / 40),
                    height = display.height * (32 / 40),
                    pageSize = 4,
                    rowSize = 1,
                    nodes = nodes,
                    vertical = true
                })
                scrollLayer:setPosition(0, 0)
                itemNodes:addChild(scrollLayer)
            else
                local label = ui.newTTFLabel({
                    text = "没有仇敌",
                    size = 38,
                    x = game.cx,
                    y = display.cy,
                    align = ui.TEXT_ALIGN_CENTER
                })
               itemNodes:addChild(label)
            end
        end

        local function findFriend()

            local inputItem = require("sns_system.CFriendItemSprite").new()
            inputItem:setPosition(CFuncHelper:getRelativeX(20.4), CFuncHelper:getRelativeY(30))
            itemNodes:addChild(inputItem)

            local inputBorder = ResourceMgr:getUISprite("board39")
            inputBorder:setPosition(-inputBorder:getContentSize().width / 6, 0)
            inputItem:addChild(inputBorder)

            local function onOKButton()
                printf(" 查找好友")
            end

            local okButton = ui.newImageMenuItem({
                image = "#button14.png",
                imageSelected = "#button15.png",
                listener = onOKButton,
            })
            okButton:setPosition(inputItem:getContentSize().width / 2.8, 0)
            local menu = ui.newMenu({okButton})
            inputItem:addChild(menu)

            local okLabel = ResourceMgr:getUISprite("font_enter")
            okLabel:setPosition(okButton:getContentSize().width / 2, okButton:getContentSize().height / 2)
            okButton:addChild(okLabel)

        end

        if buttonType == CFirendType.FINDFRIEND then
            findFriend()
        elseif buttonType == CFirendType.ENEMY then
            initEnemyItem()
        else
            initFriendItem()
        end


    end

    local function initButton()

        local function onButton(buttonType)
            initItem(buttonType)
        end

        local function c_func(f, ...)
            local argc = { ... }
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
        local friendLabel = ResourceMgr:getUISprite("font_haoyou")
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
            listener = c_func(onButton, CFirendType.FINDFRIEND),
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

        local menu = ui.newMenu({ enemyButton, friendButton, addFriendButton })
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



