

GAME_DEBUG = {
	ENABLE_GRID = false,
	DEBUG_RANDNAME = true
}

--[[ =================================]]
ItemShowType = {}
ItemShowType.MEMBER_HEROS_INFO = 1  --成员信息
ItemShowType.BASE_HEROS_INFO   = 2  --人物基础数据
ItemShowType.MEMBER_EQUIP_INFO = 3  --成员装备信息
ItemShowType.BASE_EQUIP_INFO   = 4  --装备基础数据

EquipmentType = {}
EquipmentType.WEAPON = 1
EquipmentType.DRESS  = 2
EquipmentType.SHOES  = 3
EquipmentType.OTHER  = 4

EquipmentEffectType = {}
EquipmentEffectType.ATTACK  = 0
EquipmentEffectType.DEFENSE = 2
EquipmentEffectType.HP      = 4
EquipmentEffectType.MAGIC   = 6

--0：单体
--1：单行
--2：单列
--3：十字
--4：全体
SkillAtkType = {}
SkillAtkType.SINGLE_PERSON = 0
SkillAtkType.SINGLE_ROW    = 1
SkillAtkType.SINGLE_COL    = 2
SkillAtkType.CROSS         = 3
SkillAtkType.All           = 4


--[[ Collection type 图鉴]]
CollectionType = {}
CollectionType.HERO = 1
CollectionType.EQUIP  = 2
CollectionType.SKILL  = 3



-- for load static data from scripts and network

DataDefs = {
	DD_ID         = "id",
	DD_NAME       = "str_name",
	DD_ATK        = "atk",
	DD_VALUE      = "value",
	DD_LEVEL      = "level",
	DD_ATTACKTYPE = "attType",
	DD_PROPERTY   = "property",
	DD_MATCHID    = "matchid",

	DD_ANIM       = "anim_id",
	DD_SKILL      = "skill",
	DD_HP         = "hp",
	DD_MP         = "mp",

	DD_HONOUR     = "honour",
	DD_EXP        = "exp",
	DD_EQUIP      = "equip"
}


GAME_FONT = {
	font_youyuan = "fonts/font_names.fnt",
	font_maobi = "fonts/font_names_maobi.fnt",
	font_zhaoxian = "fonts/font_zhaoxian.fnt"
}

GAME_SFX = {
    tapButton  = "music/sfx/TapButtonSound.mp3",
    backButton = "music/sfx/BackButtonSound.mp3",
}


GAME_SETTING = {
	ENABLE_MUSIC = "enable_music",
	ENABLE_SFX = "enable_sfx",
}


--[[
	操作类型: 
	example:client 删除了一个hero，需要通知服务器，则给该hero配置一个操作类型，
			由服务器进行操作
]] 
OPTIONS_TYPE = {
	OPT_ADD = 1,
	OPT_UPDATE = 2,
	OPT_DEL = 3,
}