
--[[

 @Author shan 
 @Date:

]]

require ("data.heros_gs")
require("data/names_1_gs")
require("data/names_2_gs")
require("data/names_3_gs")

local AdminMgr = class("AdminMgr")


function AdminMgr:genAllNPC( ... )
	local allnpc = {}
	for i=1,2 do
		allnpc[i] = self:genNPC(math.random(5,8))	
	end
	return allnpc
end

function AdminMgr:genNPC( level )
	
	local npc = {}

	npc[KEY_CONST.NICKNAME] = self:genName()
	npc[KEY_CONST.BASE_INFO_LEVEL] = level


	local arenaScore = 1
	local heroNum = 3
	if(level < 10) then
		npc[KEY_CONST.ARENA_SCORE] = math.random(5,100)
		heroNum = math.random(3,4)
	elseif(level < 15) then
		npc[KEY_CONST.ARENA_SCORE] = math.random(100,200)
		heroNum = math.random(4,5)
	elseif(level < 20) then
		npc[KEY_CONST.ARENA_SCORE] = math.random(200,300)
		heroNum = 5
	elseif(level < 25) then
		npc[KEY_CONST.ARENA_SCORE] = math.random(300,500)
		heroNum = 5	
	end

	local heroArray = {}
	local majorHero = {}
	for i=1,heroNum do
		local hero = {}

		if(i == 1) then
			hero.id = GAME_TUTORIAL.PICKUP_HEROS[math.random(1,3)]
		else
			hero.id = math.random(151, 185)
		end

		hero.lv = math.random(1,5)

		hero.extra = {ap = 0, dp = 0, hp = 0, mp = 0}
	    hero.equip = {}   -- equip
	    hero.skill = {}   -- skill
	    hero.baseSkill = {BaseData_heros[hero.id].skill,1}

	    heroArray[i] = hero
	    majorHero[i] = hero.id
	end

	npc[KEY_CONST.HEROS] = heroArray
	npc[KEY_CONST.HERO_MAJOR] = majorHero

	-- form
	local function getHerosId( heros)
        local ids = {}
        for i,v in ipairs(heros) do
            if(heros[i] ~= 0) then
                ids[i] = heros[i].id
            else
                ids[i] = 0
            end
        end
        return ids
    end
	local form = {}
	form[KEY_CONST.FORM_USING_ID] = 1
	form[KEY_CONST.FORMATIONS] = {getHerosId(heroArray)}

	npc[KEY_CONST.FORMATIONS] = form
	
	print(npc[KEY_CONST.NICKNAME] .. npc[KEY_CONST.HEROS][1].id .. "," .. npc[KEY_CONST.HEROS][2].id .. "," .. npc[KEY_CONST.HEROS][3].id)

	return npc
end

function AdminMgr:genName( ... )
	local middleName = BaseData_names_2[math.random(1,BaseData_names_2.ArrayCount())].str_name
	local prefixName = ""
	local postfixName = ""
	if(math.random(0,1) == 0) then
		prefixName = BaseData_names_1[math.random(1,BaseData_names_1.ArrayCount())].str_name
	end

	-- if(math.random(0,1) == 1) then
	-- 	postfixName = BaseData_names_3[math.random(1,BaseData_names_3.ArrayCount())].str_name
	-- end

	if(string.find(middleName,"镖") == nil) then
		postfixName = BaseData_names_3[math.random(1,BaseData_names_3.ArrayCount())].str_name
	end


	-- print(prefixName .. middleName .. postfixName)

	return (prefixName .. middleName .. postfixName)
end




return AdminMgr