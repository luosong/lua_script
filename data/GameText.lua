
local GameText = {}




local TEXT = {
	confirm         = "确定",
    concel          = "取消",
	next_question   = "下一题",
	began_challenge = "开始挑战",
	no_question     = "现在没有可回答的问题",
	tip             = "提示",
	next_time       = "下次再来",
	are_you_ready   = "准备好了吗?",
	next_map        = "继续前行",
	pre_map         = "原路返回",
    IDS_QUEUE_SETTING = "快速摆阵",

	-- recruit scene
	IDS_JINBANG       = "金榜",
	IDS_YINBANG       = "银榜",
	IDS_TONGBANG      = "铜榜",
	IDS_ZHAOXIAN_DESC = "可招募到的英雄星级",
	IDS_1_STAR        = "1 星",	
	IDS_2_STAR        = "2 星",
	IDS_3_STAR        = "3 星",
	IDS_4_STAR        = "4 星",
	IDS_5_STAR        = "5 星",
	IDS_FREE_TIME_DESC= "今日免费次数:",
	IDS_JINBANG_STAR = "5星\n4星",
	IDS_YINBANG_STAR = "5星\n4星\n3星",
	IDS_TONGBANG_STAR = "4星\n3星\n2星",

}


function GameText.getLength()
	return #TEXT
end


function GameText.getText(strName)
	return TEXT[strName]
end

return GameText