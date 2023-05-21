function onCreatePost()
	makeLuaSprite('Health', 'healthbarr')
	setObjectCamera('Health', 'hud')
	addLuaSprite('Health', true)
	setObjectOrder('Health', getObjectOrder('healthBar') + 1)
	setProperty('healthBar.visible', true)
end

function onUpdatePost(elapsed)
	setProperty('Health.x', getProperty('healthBar.x') - 36)
	setProperty('Health.y', getProperty('healthBar.y') - 18)
end