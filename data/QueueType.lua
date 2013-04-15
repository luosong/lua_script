

local QueueTypes = {
	[1] = "L1",
	[2] = "L2",
	[3] = "L3",
	[4] = "L4",
	[5] = "L5";
	
	L1 = {
		id = 1,
		name = "灵盾阵",
		icon = "ui/sicon11.png",
		formation = {0, 1, 0, 1, 1, 1, 0, 1, 0}
	},
	
	L2 = {
		id = 2,
		name = "铁甲阵",
		icon = "ui/sicon12.png",
		formation = {1, 1, 1 , 1, 1, 0, 0, 0, 0}
	},
	
	L3 = {
		id = 3,
		name = "魂契阵",
		icon = "ui/sicon09.png",
		formation = {1, 1, 1, 0, 0, 0, 1, 0, 1}
	},
	
	L4 = {
		id = 4,
		name = "剑刃阵",
		icon = "ui/sicon10.png",
		formation = {0, 1, 1, 0, 0, 1, 1, 1, 0}
	},
	
	L5 = {
		id = 5,
		name = "怒神阵",
		icon = "ui/sicon13.png",
		formation = {0, 1, 1, 0, 1, 0, 1, 1, 0}
	}
}

return QueueTypes