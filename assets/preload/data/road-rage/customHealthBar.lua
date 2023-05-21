
local healthBarWidth = 0
local healthBarHeight = 0
local healthBarX = 325 
local healthBarY = 650
local healthBarOverlayX = 325
local healthBarOverlayY = 650
local healthBarOverlayHeight = 0
local healthBarOverlayWidth = 0

local HeatlhBarStyle = 0

local iconDadXOffset = 215
local iconBfXOffset = 215

local iconDadYOffset = 60
local iconBfYOffset = -20

local keepScroll = false

function onCreate()
                  setProperty('iconP1.visible', false)
                  setProperty('iconP2.visible', false)
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
		keepScroll = true;
	elseif getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		setPropertyFromClass('ClientPrefs', 'middleScroll', true);
	end
end

function onDestroy()
	if keepScroll == false then
		setPropertyFromClass('ClientPrefs', 'middleScroll', false);
	elseif keepScroll == true then
		keepScroll = false;
	end
end

function onCreatePost()
        HeatlhBarStyle = 1
        healthBarWidth = getProperty('healthBar.width')
        healthBarHeight = getProperty('healthBar.height')
        healthBarX = screenWidth - 430 --370
        healthBarY = screenHeight/2 + (getProperty('healthBar.height')/2)

        healthBarOverlayWidth = getProperty('healthBarOverlay.width')
        healthBarOverlayHeight = getProperty('healthBarOverlay.height')
        healthBarOverlayX = screenWidth - 430
        healthBarOverlayY = screenHeight/2.01 + (getProperty('healthBarOverlay.height')/2.1)        
        resetIcon(false,false,true)
        if downscroll and HeatlhBarStyle ~= 0 then
            healthBarY = 90
            healthBarOverlayY = 90
        end
    end
function onUpdate()
    if HeatlhBarStyle ~= 0 then
        setProperty('healthBar.x',healthBarX)
        setProperty('healthBar.y',healthBarY)
        setProperty('healthBarOverlay.x',healthBarOverlayX)
        setProperty('healthBarOverlay.y',healthBarOverlayY)
        if HeatlhBarStyle == 1 then
            setProperty('healthBar.angle',90)
            setProperty('healthBarOverlay.angle',90)
        end
    end
end
function onUpdatePost()
    if HeatlhBarStyle == 1 then
        setProperty('iconP1.x',healthBarX + (healthBarHeight/2) + iconBfXOffset)
        setProperty('iconP2.x',healthBarX + (healthBarHeight/2) + iconBfXOffset)
        if getProperty('health') > 0 and getProperty('health') < 2 then
            setProperty('iconP1.y',healthBarWidth/2 - getProperty('health') * 300 + 200 + 150 + iconBfYOffset)
            setProperty('iconP2.y',healthBarWidth/2 - getProperty('health') * 300 + 200 + iconDadYOffset)
        end
    end
end
