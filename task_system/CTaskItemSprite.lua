--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-4-18
-- Time: 上午11:19
-- To change this template use File | Settings | File Templates.
--

local CTaskItemSprite = class("CTaskItemSprite", function()
    return require("ui_common.CScrollCell").new(display.newSprite("task_item.png"))
end)

function CTaskItemSprite:init(data)

    local nameLabel = ui.newTTFLabel({
        text = data.name,
        size = 28,
        x = -self:getContentSize().width * (1 / 3),
        y = 0
    })
    self:addChild(nameLabel)

    local acceptButton = CSingleImageMenuItem:create("button.png")
    acceptButton:setPosition(self:getContentSize().width * (1.2 / 3), 0)
    acceptButton:registerScriptTapHandler(function()
        printf("接镖")
    end)

    local menu = ui.newMenu({acceptButton})
    self:addChild(menu)
end


function CTaskItemSprite:ctor(data)
    self:init(data)
end

return CTaskItemSprite