
--[[

 @Author shan 
 @Date:
 @		处理player网络相关的数据，与服务器交互，但不涉及网络

]]


require("GameConst")

local CPlayerNetWork = class("CPlayerNetWork")

function CPlayerNetWork:ctor( ... )
		self.player = game.Player
end

--[[
	将下载的信息，赋值给当前player
]]
function CPlayerNetWork:SetDownloadData( playerInfo )
	-- 基本数值
    self.player:setUID(playerInfo[KEY_CONST["UID"]])                       -- uid
    self.player:setPlayerID(playerInfo[KEY_CONST["PLAYER_ID"]])            -- playerid
    self.player:setName(playerInfo[KEY_CONST["NICKNAME"]])                 -- nickname
    self.player:setLevel(playerInfo[KEY_CONST["BASE_INFO_LEVEL"]])         -- level
    self.player:setSilver(playerInfo[KEY_CONST["BASE_INFO_SILVER"]])         -- 银币
    self.player:setGold(playerInfo[KEY_CONST["BASE_INFO_GOLD"]])          -- 金元宝
    self.player:setExp(playerInfo[KEY_CONST["BASE_INFO_EXP"]])             -- exp
    self.player:setEnergy(playerInfo[KEY_CONST["BASE_INFO_ENERGY"]])       -- energy

    -- 弟子

    -- 阵法
    self.player:setCurrentFormationId(playerInfo[KEY_CONST["FORM_USING_ID"]])

    local form = {}
    if playerInfo[KEY_CONST["FORMATIONS"]] then
        form = playerInfo[KEY_CONST["FORMATIONS"]][KEY_CONST["FORMATIONS"]] or {}
    end

    local formLen = #form

    if(formLen > 0) then 
        local cform = require("game_model.CFormation")
        for i,v in ipairs(form) do
            game.Player:addFormation(cform.new({tonumber(v[1]),tonumber(v[2]),v[3]}))
        end

        local forms = game.Player:getFormations()
        for k, v in ipairs(forms) do
            local herosId = v:getHerosId()
            for i, j in ipairs(herosId) do

                if tonumber(j) > 0 then
                    local hero = game.Player:getMajorHeroById(tonumber(j))
                    v:setHero(i, hero)
                end
            end
        end
    else
        for k, v in ipairs(BaseData_formations) do
            game.Player:addFormation(require("game_model.CFormation").new({id = k, level = 1}))
        end    
    end
    --
end

--[[
	上传 player阵法
]]
function CPlayerNetWork:UploadFormData( ... )
    local msg = {}
    msg.id = self.m_currentFormationId
    msg.form = {}

    local function getHerosId( heros)
        local ids = {}
        for i,v in ipairs(heros) do
            if(heros[i] ~= 0) then
                ids[i] = heros[i].m_id
            else
                ids[i] = 0
            end
        end
        return ids
    end

    for i,v in ipairs(self.player.m_formation) do
        msg.form[i] = {v.m_id,v.m_level, getHerosId(v.m_heros)}
    end

    return msg
    
end

--[[
	上传 hero数据，可以是单个，也可以是一组,并通知服务器处理方式update,insert,delete
	参数，必须是table{}

]]
function CPlayerNetWork:UploadHerosData( heros )
	local  msg = {}

	for i,v in ipairs(heros) do
		local hero = {}
		hero.opt = v.opt
		hero.info = {}
		if(v.opt == OPTIONS_TYPE.OPT_ADD or v.opt == OPTIONS_TYPE.OPT_UPDATE) then
			hero.info.id = v.id
			hero.info.lv = v.lv
			hero.info.extra = v.extra
			hero.info.exp = v.exp
			hero.info.equip = v.equip -- equip
			hero.info.skill = v.skill -- skill

		elseif(v.opt == OPTIONS_TYPE.OPT_DEL) then
			hero.info[1] = v.m_id
		end
		-- 添加hero到msg
		msg[i] = hero
	end
	return msg
end

--[[
	上传 equipment 数据，可以是单个，也可以是一组,并通知服务器处理方式update,insert,delete

]]
function CPlayerNetWork:UploadEquips( equipments )
	local  msg = {}

	for i,v in ipairs(equipments) do
		local equip = {}
		equip.opt = v.opt
		equip.info = {}
		if(v.opt == OPTIONS_TYPE.OPT_ADD or v.opt == OPTIONS_TYPE.OPT_UPDATE) then
			equip.info[0] = v.m_id
			equip.info[1] = v.m_level
			equip.info[3] = v.m_extra


		elseif(v.opt == OPTIONS_TYPE.OPT_DEL) then
			equip.info[0] = v.m_id
		end
	end

	return msg
end

--[[
	上传 skill 数据，可以是单个，也可以是一组,并通知服务器处理方式update,insert,delete

]]
function CPlayerNetWork:UploadSkills( skills )
	local  msg = {}

	for i,v in ipairs(skills) do
		local skill = {}
		skill.opt = v.opt
		skill.info = {}
		if(v.opt == OPTIONS_TYPE.OPT_ADD or v.opt == OPTIONS_TYPE.OPT_UPDATE) then
			skill.info[0] = v.m_id
			skill.info[1] = v.m_level
			skill.info[3] = v.m_extra


		elseif(v.opt == OPTIONS_TYPE.OPT_DEL) then
			skill.info[0] = v.m_id
		end
	end

	return msg
end


--[[
	上传 backpack 数据，可以是单个，也可以是一组,并通知服务器处理方式update,insert,delete

]]
function CPlayerNetWork:UploadBackpack( items )
	local  msg = {}

	for i,v in ipairs(items) do
		local item = {}
		item.opt = v.opt
		item.info = {}
		if(v.opt == OPTIONS_TYPE.OPT_ADD or v.opt == OPTIONS_TYPE.OPT_UPDATE) then
			item.info[0] = v.m_id
			item.info[1] = v.m_level
			item.info[3] = v.m_extra


		elseif(v.opt == OPTIONS_TYPE.OPT_DEL) then
			item.info[0] = v.m_id
		end
	end

	return msg
end

-- end class
return CPlayerNetWork