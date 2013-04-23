--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午10:02
-- To change this template use File | Settings | File Templates.
--

local CKungFuScene = class("CKungFuScene", function()
    return display.newScene("CKungFuScene")
end)

function CKungFuScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame(GAME_RES.HUAWEN_BG))
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (35 / 40)))

    self.bg:setPosition(game.cx, display.height * (17.8 / 40))
    self.node:addChild(self.bg)
    local nodes = {}

    local function initItem()

        local skills = game.Player:getSkills()
        if #skills >= 1 then

            local function onTouchItem()

            end

            local function c_func(f, ...)
                local args = {... }

                return function() f(unpack(args)) end
            end

            local function onEnhanceButton(obj)
                 printf("--------------CKungFuScene----------" .. obj:getName())
            end

            for k, v in ipairs(skills) do
                printf("---------------" .. v:getName())
                nodes[k] = require("possessions.CItemSprite").new(v, 2)
                nodes[k]:setTouchListener(onTouchItem)

                local button = ui.newImageMenuItem({
                    image = "#button14.png",
                    imageSelected = "#button15.png",
                    listener = c_func(onEnhanceButton, v),
                    x =  nodes[k]:getContentSize().width * (12 / 32),
                    y = 0
                })

                local label =  ResourceMgr:getUISprite("font_sj")
                label:setPosition(button:getContentSize().width / 2, button:getContentSize().height / 2)
                button:addChild(label)

                local menu = ui.newMenu({button})
                menu:setPosition(0, 0)
                nodes[k]:addChild(menu)
            end

            local scrollLayer = require("ui_common.CScrollLayer").new({
                x = display.width * (5.6 / 40),
                y = display.height * (2 / 40),
                width = display.width * (32.5 / 40),
                height = display.height * (32 / 40),
                pageSize = 4,
                rowSize = 1,
                nodes = nodes,
                vertical = true
            })


            scrollLayer:setPosition(0, 0)
            self.node:addChild(scrollLayer)
        else
            local label = ui.newTTFLabel({
                text = "江湖险恶，学几手防身吧",
                size = 38,
                x    = game.cx,
                y    = display.cy,
                align = ui.TEXT_ALIGN_CENTER
            })

            self.node:addChild(label)
        end

    end

    initItem()
end

function CKungFuScene:onExit()
    self.node:removeAllChildrenWithCleanup(true)
    self:removeAllChildrenWithCleanup(true)
end

function CKungFuScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

end

function CKungFuScene:onExit( ... )
    print("CKungFuScene:onExit( ... ) =========")
    -- self:removeAllChildrenWithCleanup(true)
    -- CCTextureCache:sharedTextureCache():removeUnusedTextures()
end

return CKungFuScene