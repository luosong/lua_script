--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-22
-- Time: 上午11:34
-- To change this template use File | Settings | File Templates.
--
--选择对手



local CChallengeScene = class("CChallengeScene", function()
    return display.newScene("CChallengeScene")
end)

function CChallengeScene:init()
    local baseLayer = require("CBorderLayer").new()
    baseLayer:setPosition(0, 0)
    self.node:addChild(baseLayer)

    local bg = CCScale9Sprite:createWithSpriteFrameName("board21.png")
    bg:setPreferredSize(CCSizeMake(display.width * (36 / 40), display.height * (36 / 40)))
    bg:setPosition(game.cx, display.height * (18 / 40))
    self.node:addChild(bg)

    

end

function CChallengeScene:initEnemy( enemylist )
    local enemyPlayer = {}

    local function addEnemy(enemy)
       enemyPlayer[#enemyPlayer + 1] = enemy
    end

    -- 将服务器上玩家，加入到list中
    local herodata = require("game_model.HeroData")
    for k,v in pairs(enemylist) do
        local heros = v[KEY_CONST.HEROS]
        local mh = {}
        local index = 1

        for k,v in pairs(heros) do
            mh[index] = herodata.new({
                        id = tonumber(v.id),                 --id
                        exp = tonumber(v.exp) or 0,          --经验
                        level = tonumber(v.lv),              --级别
                        skills = v.skill,                    --技能 表
                        extra_ap = tonumber(v.extra.ap),     --额外加成
                        extra_dp = tonumber(v.extra.dp),
                        extra_hp = tonumber(v.extra.hp),
                        extra_mp = tonumber(v.extra.mp),
                        base_skill = v.baseSkill --{value = 12, level = 22}
                })
            index = index + 1
        end

        
        local form = v[KEY_CONST.FORMATIONS]
        local formid = form[KEY_CONST.FORM_USING_ID]
        local forms = {}

        for form_Key, form_Value in ipairs(form["form"]) do
            forms[form_Key] = require("game_model.CFormation").new({form_Value["id"], form_Value["lv"], form_Value["form"]})
        end

        addEnemy(require("game_model.COtherPlayer").new({
            name    = v[KEY_CONST.NICKNAME],
            ranking = 1000,
            level   = v[KEY_CONST.BASE_INFO_LEVELl],
            majorHeros = mh,
            currentFormId = formid,
            formations   = forms
                    }))

    end


    local nodes = {}
    local function onFightButton()

    end

    for k, v in ipairs(enemyPlayer) do
        nodes[k] = require("ui_common.CScrollCell").new(require("competition.fight.CChallengeItemSprite").new(v))
        nodes[k]:setTouchListener(onFightButton)

        local form = v:getCurrentFormation()
        --dump(form)
    end

    local scrollLayer = require("ui_common.CScrollLayer").new({
        x = display.width * (5.6 / 40),
        y = display.height * (2 / 40),
        width = display.width * (32.5 / 40),
        height = display.height * (32 / 40),
        pageSize = 4,
        rowSize = 1,
        nodes = nodes,
        vertical = true
    })
    scrollLayer:setPosition(0, 0)
    self.node:addChild(scrollLayer)

    self:registerScriptHandler(function(action)
        if action == "exit" then
            self:removeAllChildrenWithCleanup(true)
            self:removeAllChildrenWithCleanup(true)
        end
    end)
end


function CChallengeScene:test( ptr)

    local gameNetWork = require("GameNetWork").new()


    local function uploadCB( data )

        ptr:initEnemy( data[KEY_CONST.MSG_BODY][REQUEST_ID.ARENA_LIST] )
    end
    gameNetWork:SendData( game.Player:getPlayerID(),game.Player:getServerID(), 
        REQUEST_ID.ARENA_LIST, {}, uploadCB)

end

function CChallengeScene:ctor()
    self.node = display.newNode()
    self.node:setPosition(0, 0)
    self:addChild(self.node)

    self:init()

        --loading界面
    local loading = require("ui_common.CLoadingLayer")
    loading.new(CChallengeScene.test, self)
end

return CChallengeScene