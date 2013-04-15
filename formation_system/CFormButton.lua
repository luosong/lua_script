--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-10
-- Time: 上午11:45
-- To change this template use File | Settings | File Templates.
--

local width = 302
local height = 48

local CFormButton = class("CFormButton", function()
    return require("ui_common.CScrollCell").new(display.newSprite("ui/tiao.png"))
end)

function CFormButton:init(icon, text)

    local iconSprite = ResourceMgr:getUISprite(icon)
    iconSprite:setPosition(-self:getContentSize().width /  2 + iconSprite:getContentSize().width * 1.6, 0)
    self:addChild(iconSprite)

    local label = ui.newTTFLabel({
        text = text,
        size = 18,
        font = GAME_FONT.font_youyuan,
        color = ccc3(0, 0, 0),
        align = ui.TEXT_ALIGN_CENTER,
        x = 0,
        y = 0
    })
    self:addChild(label)

    local button = CSingleImageMenuItem:create("ui/chatButton.png")
    button:setPosition(self:getContentSize().width /  2 - button:getContentSize().width / 2, 0)
    button:registerScriptTapHandler(function()
        game.Player:setCurrentFormationId(self.formationId)
    end)
    button:setScale(0.6)

    self.menu = ui.newMenu({button})
    self:addChild(self.menu)

    self.menu:setVisible(false)

end

function CFormButton:setSelect(s, formationId)
    self.menu:setVisible(s)

    self.formationId = formationId
end

function CFormButton:ctor(icon, text)
    self:init(icon, text)
end

return CFormButton