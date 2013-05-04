

GAME_DEBUG = {
	ENABLE_GRID = false,
	DEBUG_RANDNAME = true
}



if device.platform == "android" then
    FONT_SIZE = {
        GameMenuSceneFont = {
            TITLE_LABEL_SIZE = 13,
            LV_LABEL_SIZE    = 9,
            EXP_LABEL_SIZE   = 8,
            VIP_LABEL_SIZE   = 9
        },
        MembersSceneFont = {
            ICON_LABEL_SIZE = 11
        },
        ItemSpriteFont = {
            DESC_LABEL_SIZE = 13,
            EFFECT_VALUE_LABEL_SIZE   = 9,
            PROPERTY_LABEL_SIZE = 11,

        } ,
        HeroSpriteFont = {
            NAME_LABEL_SIZE = 6,
            LV_LABEL_SIZE = 6,
        }
    }
else
    FONT_SIZE = {
        GameMenuSceneFont = {
            TITLE_LABEL_SIZE = 26,
            LV_LABEL_SIZE    = 18,
            EXP_LABEL_SIZE   = 16,
            VIP_LABEL_SIZE   = 18
        },
        MembersSceneFont = {
            ICON_LABEL_SIZE = 22
        },
        ItemSpriteFont = {
            DESC_LABEL_SIZE = 26,
            EFFECT_VALUE_LABEL_SIZE   = 18,
            PROPERTY_LABEL_SIZE = 22,

        },
        HeroSpriteFont = {
            NAME_LABEL_SIZE = 12,
            LV_LABEL_SIZE = 12,
        }
    }
end

CEmailType = {
    FRIEND    = 1,
    FIGHTING  = 2,
    SYSTEM    = 3
}

CFirendType = {
    FRIEND = 1,
    ENEMY = 2,
    FINDFRIEND = 3
}

SettingType = {
    MUSIC = 1,
    SOUND = 2,
    WEIBO = 3,
    HELP  = 4
}

BattleType = {
    Adventure_map = 1,
    Other_player  = 2
}

ItemType = {}

ItemType.EQUIPMENT = 1
ItemType.SKILL = 2
ItemType.HERO = 3
ItemType.Other = 4


--[[ =================================]]
ItemShowType = {}
ItemShowType.MEMBER_HEROS_INFO = 1  --成员信息
ItemShowType.BASE_HEROS_INFO   = 2  --人物基础数据
ItemShowType.MEMBER_EQUIP_INFO = 3  --成员装备信息
ItemShowType.BASE_EQUIP_INFO   = 4  --装备基础数据

EquipmentType = {}     --装备类型
EquipmentType.WEAPON = 1  --武器
EquipmentType.DRESS  = 2  --衣服
EquipmentType.SHOES  = 3  --鞋
EquipmentType.OTHER  = 4  --其他

EquipmentEffectType = {} --装备加成类型
EquipmentEffectType.ATTACK     = 0     --攻击固定数值
EquipmentEffectType.ATTACK_PER = 1     --攻击加成百分比

EquipmentEffectType.DEFENSE     = 2    --防御
EquipmentEffectType.DEFENSE_PER = 3

EquipmentEffectType.HP         = 4     --血值
EquipmentEffectType.HP_PER     = 5

EquipmentEffectType.MAGIC      = 6     --内力
EquipmentEffectType.MAGIC_PER  = 7

--1：单体
--2：单行
--3：单列
--4：十字
--5：回字
--6:全体
SkillAtkType = {}
SkillAtkType.SINGLE_PERSON = 1
SkillAtkType.SINGLE_ROW    = 2
SkillAtkType.SINGLE_COL    = 3
SkillAtkType.CROSS         = 4
SkillAtkType.CIRCLE        = 5
SkillAtkType.ALL           = 6


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
	font_zhaoxian = "fonts/font_zhaoxian.fnt",
    font_vip = "fonts/font_vip.fnt",

    font_blood = "fonts/font_blood.fnt",

    font_ttf_mini = "fonts/minijty.ttf",
    font_ttf_ygy = "fonts/ygyxsziti2.0.ttf",
    font_ttf_mf = "fonts/Marker Felt.ttf",
}

GAME_SFX = {
    tapButton  = "music/sfx/TapButtonSound.mp3",
    backButton = "music/sfx/BackButtonSound.mp3",
}

GAME_MUSIC = {
    LOGO = "music/zitaoyunxiaxiandaowei.mp3", -- "music/logo.wav",--
    MM = "music/sound_mm.wav",
    MM_OTHER = "music/sound_other.wav",
}


GAME_SETTING = {
    HAS_SAVE = "saved",
	ENABLE_MUSIC = "enable_music",
	ENABLE_SFX = "enable_sfx",
}


GAME_BLACKSMITH_COST = {
    LEVEL_1 = 500,
    LEVEL_2 = 1000,
    LEVEL_3 = 1500,
    LEVEL_4 = 2000
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


GAME_RES = {
    HUAWEN_BG = "board29",
}

-- 碎片，一个单独的物品，可以转化为多少个碎片
GAME_FRAGMENT_HERO = {
    STAR_5 = 40,
    STAR_4 = 30,
    STAR_3 = 20,
    STAR_2 = 10
}

GAME_FRAGMENT_EQUIP = {
    STAR_5 = 40,
    STAR_4 = 30,
    STAR_3 = 20,
    STAR_2 = 10,
    STAR_1 = 5,
}

GAME_FRAGMENT_SKILL = {
    STAR_5 = 40,
    STAR_4 = 30,
    STAR_3 = 20,
    STAR_2 = 10,
    STAR_1 = 5,
}


-- 游戏教学，
GAME_TUTORIAL = {
    PICKUP_HEROS = {43, 57, 92}, -- 可以挑选的3个heroid
}
