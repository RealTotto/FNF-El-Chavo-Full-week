
local healthBarWidth = 0
local healthBarHeight = 0
local healthBarX = 325
local healthBarY = 650

local HeatlhBarStyle = 0

local iconDadXOffset = 215
local iconBfXOffset = 215

local iconDadYOffset = 60
local iconBfYOffset = -20
function onCreatePost()
        HeatlhBarStyle = 1
        healthBarWidth = getProperty('healthBar.width')
        healthBarHeight = getProperty('healthBar.height')
        healthBarX = screenWidth - 450
        healthBarY = screenHeight/2 + (getProperty('healthBar.height')/2)
        resetIcon(false,false,true)
        if downscroll and HeatlhBarStyle ~= 0 then
            healthBarY = 90
        end
    end
function onUpdate()
    if HeatlhBarStyle ~= 0 then
        setProperty('healthBar.x',healthBarX)
        setProperty('healthBar.y',healthBarY)
        if HeatlhBarStyle == 1 then
            setProperty('healthBar.angle',90)
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