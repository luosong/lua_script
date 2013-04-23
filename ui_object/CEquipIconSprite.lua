--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-20
-- Time: 下午1:51
-- To change this template use File | Settings | File Templates.
--

local CEquipIconSprite = class("CEquipIconSprite", function(equipData)
    local iconBorder = nil
    if (equipData) then
        if(equipData:getProperty() == 0) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white2")
        elseif(equipData:getProperty() == 1) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white2")
        elseif(equipData:getProperty() == 2) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_green2")
        elseif(equipData:getProperty() == 3) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_blue2")
        elseif(equipData:getProperty() == 4) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_yellow2")
        elseif(equipData:getProperty() == 5) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_purple2")
        end
    end
    return iconBorder
end)

function CEquipIconSprite:ctor(equipData)
    if (equipData) then
        local skillIcon = ResourceMgr:getIconSprite(equipData:getIcon())
        self:addChild(skillIcon)
        skillIcon:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
    end
end

return CEquipIconSprite