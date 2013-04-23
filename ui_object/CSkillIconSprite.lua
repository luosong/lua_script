--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-20
-- Time: 下午1:51
-- To change this template use File | Settings | File Templates.
--

local CSkillIconSprite = class("CSkillIconSprite", function(skillData)
    local iconBorder = nil
    if (skillData) then
        if(skillData:getProperty() == 0) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white2")
        elseif(skillData:getProperty() == 1) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_white2")
        elseif(skillData:getProperty() == 2) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_green2")
        elseif(skillData:getProperty() == 3) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_blue2")
        elseif(skillData:getProperty() == 4) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_yellow2")
        elseif(skillData:getProperty() == 5) then
            iconBorder = ResourceMgr:getUISprite("icon_bg_purple2")
        end
    end
    return iconBorder
end)

function CSkillIconSprite:ctor(skillData)
    if (skillData) then
        local skillIcon = ResourceMgr:getIconSprite(skillData:getIcon())
        self:addChild(skillIcon)
        skillIcon:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
    end
end

return CSkillIconSprite