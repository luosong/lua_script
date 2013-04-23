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
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    self.bg = CCScale9Sprite:createWithSpriteFrame(ResourceMgr:getUISpriteFrame(GAME_RES.HUAWEN_BG))
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (35 / 40)))
    self.bg:setPosition(game.cx, display.height * (17.8 / 40))
    self.node:addChild(self.bg)



    local nodes = {}
    nodes[1] = require("setting.CSettingItemSprite").new(SettingType.MUSIC)
    nodes[2] = require("setting.CSettingItemSprite").new(SettingType.SOUND)
    nodes[3] = require("setting.CSettingItemSprite").new(SettingType.WEIBO)
    nodes[4] = require("setting.CSettingItemSprite").new(SettingType.HELP)


    local nodesLayout = require("ui_common.CNodeLayout").new({
        nodes = nodes,
        width =  CFuncHelper:getRelativeX(34),
        height = CFuncHelper:getRelativeY(31.5),
        rowSize = 1
    })
    nodesLayout:setPosition(CFuncHelper:getRelativeX(4.8), CFuncHelper:getRelativeY(2))
    self.node:addChild(nodesLayout)

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