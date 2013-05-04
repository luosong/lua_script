
local CGameLogoScene = class("CGameLogoScene", function()
	return display.newScene("CGameLogoScene")
end)

function CGameLogoScene:ctor()

	WRUtility:CheckNetworkStatus()	
	
	self.loadingText = ui.newTTFLabel({
		text = "加载中... ...",
		font = "Arial",
		size = 38,
		align = ui.TEXT_ALIGN_CENTER,
		x = display.width / 2,
		y = display.height / 2	
	})

	self:addChild(self.loadingText)
	self.scheduler = require("framework.client.scheduler")
	self.schedulerNextScene = self.scheduler.scheduleGlobal(
        function(dt)
            self.scheduler.unscheduleGlobal(self.schedulerNextScene)
            -- display.replaceScene(require("CGameMenuScene").new())
            display.replaceScene(require("CGameLoginScene").new())
	    end,
	    0.5,
	false)
end

function CGameLogoScene:onExit( ... )
    self:removeAllChildrenWithCleanup(true)
    CCTextureCache:sharedTextureCache():removeUnusedTextures()
end

require("data.heros_gs")
require("data.equipments_gs")
require("data.skills_gs")

game.Player:addSkill(require("game_model.CSkill").new({
    id = 1,
    value = 1000
}))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[2]))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[3]))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[8]))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[11]))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[13]))
game.Player:addSkill(require("game_model.CSkill").new(BaseData_skills[17]))


game.Player:addFormation(require("game_model.CFormation").new({2, 1}))
game.Player:addFormation(require("game_model.CFormation").new({3, 1}))
-- game.Player:addHero(require("game_model.HeroData").new(
--      {
--          id = 1,                  --id
--          exp = 100,               --经验
--          level = 10,              --级别
--          skills = {0, 0, 0, 0},    --技能 表
--          extra_ap = 1,            --额外加成
--          extra_dp = 2,
--          extra_hp = 3,
--          extra_mp = 4,
--          base_skill = {value = 12, level = 22}
--      }
-- ))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[2]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[50]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[20]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[5]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[6]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[7]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[8]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[9]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[1]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[2]))
-- game.Player:addHero(require("game_model.HeroData").new(BaseData_heros[3]))

--local h = game.Player:getHeros()
--for i = 1, 4 do
--     game.Player:addMajorHero(h[i]:getId())
--end

game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[1]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[11]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[21]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[31]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[41]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[51]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[61]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[23]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[33]))
game.Player:addEquipment(require("game_model.CEquip").new(BaseData_equipments[43]))



 -- echoInfo(string.format("==========MEMORY USED: %0.2f KB, UPTIME: %04.2fs", collectgarbage("count"), 1))

 -- echoInfo(string.format("==========MEMORY USED: %0.2f KB, UPTIME: %04.2fs", collectgarbage("count"), 1))

game.Player:addToPackage(1)
game.Player:addToPackage(1)
game.Player:addToPackage(1)

return CGameLogoScene

