local dFont = "pixel_smaller.ttf"

function onCreatePost()
	setTextFont("judgementCounter", dFont)  

	setTextFont("botplayTxt", dFont)  

	setTextFont("msTimeTxt", dFont)

	setTextFont("timeTxt", dFont)

                  setTextFont("leSongName", dFont)

                  doTweenAlpha('camGameOff' ,'camOther', 1, 0.7, 'cubeOut')
end  

local keepScroll = false

function onCreate()
                   setProperty('judgementCounter.visible', true) --not Bug
	if getPropertyFromClass('ClientPrefs', 'introSongName') == true then
		keepScroll = true;
	elseif getPropertyFromClass('ClientPrefs', 'introSongName') == false then
		setPropertyFromClass('ClientPrefs', 'introSongName', true);
	end
end

function onDestroy()
	if keepScroll == false then
		setPropertyFromClass('ClientPrefs', 'introSongName', false);
	elseif keepScroll == true then
		keepScroll = false;
	end
end



