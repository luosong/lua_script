BaseData_recruit = {
 [1] = {
  id = 1,
  str_name = "金榜",
  str_des = "有机会招募到5,4,星英雄",
  money = 200,
  daylimit = 1,
  cdtime = 172800
 },
 [2] = {
  id = 2,
  str_name = "银榜",
  str_des = "有机会招募到5,4,3星英雄",
  money = 50,
  daylimit = 1,
  cdtime = 86400
 },
 [3] = {
  id = 3,
  str_name = "铜榜",
  str_des = "有机会招募到4,3,2星英雄",
  money = 10,
  daylimit = 5,
  cdtime = 600
 }
}

function BaseData_recruit.ArrayCount()
    return #BaseData_recruit
end
