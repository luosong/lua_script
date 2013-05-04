--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-22
-- Time: 下午4:27
-- To change this template use File | Settings | File Templates.
--

local CSettingItemSprite = class("CSettingItemSprite", function()
    local sprite = CCScale9Sprite:create("bartile.png")
    sprite:setPreferredSize(CCSizeMake(display.width * (32 / 40), sprite:getContentSize().height ))
    return require("ui_common.CScrollCell").new(sprite)
end)

function CSettingItemSprite:EnableSound( enable )

    CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_MUSIC, enable)
    CCUserDefault:sharedUserDefault():flush()
    if(enable == true) then
        game.GameAudio:playMusic(GAME_MUSIC.LOGO)
    else
        game.GameAudio:stopMusic(true)
    end

end

function CSettingItemSprite:ctor(settingType, isEnable)
    local str = ""
    if (settingType == SettingType.MUSIC) then
        str = "音乐"
    elseif settingType == SettingType.SOUND then
        str = "音效"
    elseif settingType == SettingType.WEIBO then
        str = "微博"
    elseif settingType == SettingType.HELP then
        str = "帮助"
    end
    local label = ui.newTTFLabel({
        text = str,
        x = - self:getContentSize().width * (2 / 5),
        y = 0,
        size = 28
    })
    self:addChild(label)

    local selSprite = nil
    local boxButton = CSingleImageMenuItem:create(ResourceMgr:getUISprite("sicon21"))
    boxButton:registerScriptTapHandler(function()

        if (touchType == SettingType.MUSIC) then
            printf("音乐")
        elseif touchType == SettingType.SOUND then
            printf("音效")
        elseif touchType == SettingType.WEIBO then
            printf("微博")
        elseif touchType == SettingType.HELP then
            printf("帮助")
        end

        if selSprite:isVisible() then
            selSprite:setVisible(false)
            self:EnableSound(false)
        else
            selSprite:setVisible(true)
            self:EnableSound(true)
        end
    end)
    boxButton:setPosition(self:getContentSize().width * (1.5 / 5), 0)
    local menu = ui.newMenu({boxButton})
    self:addChild(menu)

    selSprite = ResourceMgr:getUISprite("sicon20")
    selSprite:setPosition(boxButton:getContentSize().width, boxButton:getContentSize().height / 2)
    boxButton:addChild(selSprite)
    selSprite:setVisible(isEnable)

    --------------------------
    self.setEnable = function(self, b)
        selSprite:setVisible(b)
    end
end

return CSettingItemSprite