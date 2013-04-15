
require("config")
require("framework.init")
require("framework.client.init")

-- define global module
game = {}
game.cx = display.width * (21.8 / 40)
game.cy = display.height * (17.5 / 40)
game.Player = require("game_model.CPlayer").new()
game.PlayerNetWork = require("CPlayerNetWork").new()
-- game.Player:setName("床前明月光")
function game.startup()
    --CCFileUtils:sharedFileUtils():addSearchResolutionsOrder("Resources/")
    CCFileUtils:sharedFileUtils():addSearchPath("Resources/")
    -- if display.contentScaleFactor <= 0.50 then
    --     -- for iPhone 3Gs, use low-res assets
    --     CCFileUtils:sharedFileUtils():addSearchResolutionsOrder("res/sd/")
    --     CCDirector:sharedDirector():setContentScaleFactor(display.contentScaleFactor)
    -- else
    --     CCFileUtils:sharedFileUtils():addSearchResolutionsOrder("res/hd/")
    -- end
    -- display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)

    -- if device.platform == "ios" then
    --     require("config_ios")
    -- elseif device.platform == "mac" then
    --     require("config_mac")
    -- end
    
    display.replaceScene(require("CGameLogoScene").new())
end
