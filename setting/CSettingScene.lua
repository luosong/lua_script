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
    self.bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), baseLayer:getLeftHeight()) )
    self.bg:setPosition(game.cx, CFuncHelper:getTopBarH() + baseLayer:getLeftHeight()/2)
    self.node:addChild(self.bg)



    local nodes = {}
    nodes[1] = require("setting.CSettingItemSprite").new(SettingType.MUSIC, self.soundOn)
    nodes[2] = require("setting.CSettingItemSprite").new(SettingType.SOUND, self.sfxOn)
    nodes[3] = require("setting.CSettingItemSprite").new(SettingType.WEIBO, false)
    nodes[4] = require("setting.CSettingItemSprite").new(SettingType.HELP, false)


    local nodesLayout = require("ui_common.CNodeLayout").new({
        nodes = nodes,
        width =  CFuncHelper:getRelativeX(34),
        height = baseLayer:getLeftHeight()-20,
        rowSize = 1
    })
    nodesLayout:setPosition(CFuncHelper:getRelativeX(4.8), CFuncHelper:getTopBarH()+5)
    self.node:addChild(nodesLayout)

end

function CSettingScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)



    self.soundOn = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.ENABLE_MUSIC)
    if(soundOn == false) then
        CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_MUSIC, true)
    end

    self.sfxOn = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.ENABLE_SFX)
    if(sfxOn == false) then
        CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_SFX, true)
    end
    CCUserDefault:sharedUserDefault():flush()

    self:init()
end

return CSettingScene