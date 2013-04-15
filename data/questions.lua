

local questions = {}
local questionsData = {}


questionsData[1] = {
	id = 1,
	reward = 0,
	question = "乌龟有几条腿？",
	answers = {
		A = "1条",
		B = "2条",
		C = "3条",
		D = "4条"
	},
	result = "A"
}

questionData[2] = {
	id = 2,
	reward = 10,
	question = "中国领土面积多大？",
	answers = {
		A = "960万平方公里",
		B = "860万平方公里",
		C = "28万平方公里",
		D = "1平方公里"
	},
	result = "A"
}

questionData[3] = {
	id = 3,
	reward = 10,
	question = "哪个是中国四大发明之一？",
	answers = {
		A = "飞机",
		B = "轮船",
		C = "火药",
		D = "坦克"
	},
	result = "C"
}

questionData[4] = {
	id = 4,
	reward = 10,
	question = "你早晨吃什么？",
	answers = {
		A = "小米粥",
		B = "烧瓶",
		C = "油条",
		D = "包子"
	},
	result = "D"
}

questionData[5] = {
	id = 5,
	reward = 10,
	question = "东方不败是男人还是女人",
	answers = {
		A = "男人",
		B = "女人",
		C = "不男不女",
		D = "不知道"
	},
	result = "A"
}

questionData[6] = {
	id = 6,
	reward = 10,
	question = "东方不败是男人还是女人",
	answers = {
		A = "男人",
		B = "女人",
		C = "不男不女",
		D = "不知道"
	},
	result = "A"
}

questionData[7] = {
	id = 7,
	reward = 10,
	question = "东方不败是男人还是女人",
	answers = {
		A = "男人",
		B = "女人",
		C = "不男不女",
		D = "不知道"
	},
	result = "A"
}

function questions:getCount()
	return #questionData
end

function questions:getByID(id)
	return questionData[id]
end

function questions:generateQuestionsList(n)
	return {1, n}
end

return questions