--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午9:24
-- To change this template use File | Settings | File Templates.
--
require("GameConst")

local CSettingScene = class("CSettingScene", function()
    return display.newScene("CSettingScene")
end)

function CSettingScene:init()
    local baseLayer = require("CBaseLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = display.newSprite("setting.png")
    self.bg:setPosition(game.cx, self.bg:getContentSize().height / 2)
    self.node:addChild(self.bg)
end

function CSettingScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

    local soundOn = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.ENABLE_MUSIC)

    if(soundOn == false) then
        CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_MUSIC, true)
    end

    CCUserDefault:sharedUserDefault():flush()
end

return CSettingScene