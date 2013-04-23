--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-19
-- Time: 上午10:25
-- To change this template use File | Settings | File Templates.
--

local CHeroIconSprite = class("CHeroIconSprite", function(heroData)
    local iconBorder = nil
    if (heroData) then
        if(heroData:getProperty() == 0) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white")
        elseif(heroData:getProperty() == 1) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white")
        elseif(heroData:getProperty() == 2) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_green")
        elseif(heroData:getProperty() == 3) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_blue")
        elseif(heroData:getProperty() == 4) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_yellow")
        elseif(heroData:getProperty() == 5) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_purple")
        end
    else
        iconBorder = ResourceMgr:getUISprite("icon_bg_lock")
    end
    return iconBorder
end)

function CHeroIconSprite:ctor(heroData)
    if (heroData) then
        local herosIcon = ResourceMgr:getIconSprite(heroData:getIconID())
        self:addChild(herosIcon)
        herosIcon:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.getData = function()
            return heroData
        end
    end

end

return CHeroIconSprite