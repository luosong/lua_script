--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-26
-- Time: 下午1:40
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-22
-- Time: 下午4:27
-- To change this template use File | Settings | File Templates.
--

local CFriendItemSprite = class("CFriendItemSprite", function()
    local sprite = CCScale9Sprite:create("bartile.png")
    sprite:setPreferredSize(CCSizeMake(display.width * (30 / 40), display.height * (7 / 40)))
    return require("ui_common.CScrollCell").new(sprite)
end)

function CFriendItemSprite:EnableSound( enable )

end

function CFriendItemSprite:ctor(settingType, isEnable)

end

return CFriendItemSprite