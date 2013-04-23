--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-27
-- Time: 下午6:03
-- To change this template use File | Settings | File Templates.
--

local CChatScene = class("CChatScene", function()
    return display.newScene("CChatScene")
end)

function CChatScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = display.newSprite("chat.png")
    self.bg:setPosition(game.cx, self.bg:getContentSize().height / 2)
    self.node:addChild(self.bg)
end

function CChatScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
    
    local textLable = ui.newTTFLabelWithShadow({
                text = "hello",
                x = display.width/2,
                y = display.height/2
        })

    self:addChild(textLable)


    -- input box
    local boxSize = CCSize(display.width/2, 60)
    local inputBox = CCEditBox:create(boxSize, CCScale9Sprite:create"ui/board02.png")
    inputBox:setPosition(display.width/2, inputBox:getContentSize().height+10)
    inputBox:setPlaceHolder("Please input here")
 
    self:addChild(inputBox)

    local herosButton = CSingleImageMenuItem:create("ui/chatButton.png")
    herosButton:setPosition(display.width * (26 / 40), display.height * (5 / 40))
    herosButton:registerScriptTapHandler(function()
        local text = inputBox:getText()
        
        if(text ~= "") then
            textLable:setString(text)
            inputBox:setText("")
        end
    end)

    local menu = ui.newMenu({ herosButton})
    self.bg:addChild(menu)
end

return CChatScene


