--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-15
-- Time: 下午6:43
-- To change this template use File | Settings | File Templates.
--

require("data.task")
local CChargeDartScene = class("CChargeDartScene", function()
    return display.newScene("CChargeDartScene");
end)

function CChargeDartScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)


    local taskDescBg = display.newSprite("task_desc.png")
    taskDescBg:setPosition(display.width * (10 / 40), game.cy)
    self.node:addChild(taskDescBg)

    local taskDescLabel = ui.newTTFLabel({
        text = "的法律阿斯顿发阿达啊sdf阿道夫啊发送到发送到阿斯顿发生大发阿斯顿发送到发送到的发生的发生发生的发生法大赛的发生发到",
        x = taskDescBg:getContentSize().width * 0.2,
        y = taskDescBg:getContentSize().height / 2,
        dimensions = CCSizeMake(taskDescBg:getContentSize().width * 0.6,
            taskDescBg:getContentSize().height * 0.8)
    })
    taskDescBg:addChild(taskDescLabel)

    local nodes = {}

    local function onTaskInfo(data)
        taskDescLabel:setString(data.desc)
    end

    local function c_func(f, ...)
        local args = {... }
        return function()
            f(unpack(args))
        end
    end

    for k, v in ipairs(tasks) do
        nodes[k] = require("task_system.CTaskItemSprite").new(v)
        nodes[k]:setTouchListener(c_func(onTaskInfo, v))
    end

    local scrollLayer = require("ui_common.CScrollLayer").new({
        x = display.width * (16 / 40),
        y = 0,
        width = display.width * (24 / 40),
        height = display.height * (35 / 40),
        pageSize = 5,
        rowSize = 1,
        nodes = nodes,
        vertical = true
    })
    scrollLayer:setPosition(0, 0)
    self.node:addChild(scrollLayer)

end


function CChargeDartScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()
end

return CChargeDartScene