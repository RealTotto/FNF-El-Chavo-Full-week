local HealthWidth = 0
local HealthHeight = 0
local HealthX = 325
local HealthY = 650
local HeatlhStyle = 0

function onCreatePost()
	makeLuaSprite('Health', 'stepmania/healthBarStep')
	setObjectCamera('Health', 'hud')
	addLuaSprite('Health', true)
	setObjectOrder('Health', getObjectOrder('healthBar') + 1)
                   setProperty('Health.angle',90)
	setProperty('healthBar.visible', true)
                   setProperty('healthBarBG.visible', false)
end

function onUpdatePost(elapsed)
	setProperty('Health.x', getProperty('healthBar.x') - 12)
	setProperty('Health.y', getProperty('healthBar.y') - 8)
end