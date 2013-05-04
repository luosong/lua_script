
--[[

 @ Author shan 
 @ Description:再封一层，把读取option存档也加进来
 @ Date:

]]

local GameAudio = class("GameAudio")

function GameAudio:ctor( ... )
	self.saved = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.HAS_SAVE)

	if(self.saved == false) then
		CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.HAS_SAVE, true)
		CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_SFX, true)
		CCUserDefault:sharedUserDefault():setBoolForKey(GAME_SETTING.ENABLE_MUSIC, true)
		CCUserDefault:sharedUserDefault():flush()
	end

	self.soundOn = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.ENABLE_MUSIC)
	self.sfxOn = CCUserDefault:sharedUserDefault():getBoolForKey(GAME_SETTING.ENABLE_SFX)
end

function GameAudio:preloadMusic(filename)

	audio.preloadMusic(filename)

end


function GameAudio:playMusic(filename, isLoop)
	if (self.soundOn == true) then
		audio.playMusic(filename, isLoop)
	end
end


function GameAudio:stopMusic(isReleaseData)
	if(self.soundOn == true and audio.isMusicPlaying()) then
		audio.stopMusic(isReleaseData)
	end
end


function GameAudio:playSound(filename, isLoop)
	if(self.sfxOn == true) then
		audio.playSound(filename, isLoop)
	end
end

return GameAudio
