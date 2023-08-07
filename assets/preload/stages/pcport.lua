isChase = false
jumpedBrick = false
jumpedGap1 = false
jumpedGap2 = false
jumpedPipe = false

jumpedGapB = false
jumpedGapB2 = false
jumpedStairs = false
jumpedStairs2 = false
jumpedGap3 = false
jumpedGap3M = false
jumpedGap4M = false
jumpedGap4 = false
jumpTriggers = {}

chaseBGX = 0

mxLegsHighY = 0
mxLegsDefY = 0
bfLegsHighY = 0
bfLegsDefY = 0

breakableObjects = {}
legsSuffix = ''
pipeEnd = false
pipeTrigger = false

bfLegsPrefix = '-fire'
bfPrefix = 'chavo-smb'
powerup = 2
dmgCooldown = 0
timeUntilPowerup = 0

allowCountdown = false
impact = false

function onCreate()
	--setProperty('skipCountdown', true)
	--Iterate over all notes
	jumpTriggers[1] = jumpedBrick
	jumpTriggers[2] = jumpedGap1
	jumpTriggers[3] = jumpedGap2
	jumpTriggers[4] = jumpedPipe
	jumpTriggers[5] = jumpedGapB
	jumpTriggers[6] = jumpedGapB2
	jumpTriggers[7] = jumpedStairs
	jumpTriggers[8] = jumpedGap3
	jumpTriggers[9] = jumpedGap3M
	jumpTriggers[10] = jumpedStairs2
	jumpTriggers[11] = jumpedGap4
	jumpTriggers[12] = jumpedGap4M

	--setPropertyFromClass('GameOverSubstate', 'characterName', 'chavo-dies')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-gameover')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'intro1')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'intro1')
	for i = 0, getProperty('unspawnNotes.length')-1 do
		setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0); --Default value is: health lost on miss
	end
	
	ogHud = getPropertyFromClass('ClientPrefs', 'hideHud')
	setPropertyFromClass('ClientPrefs', 'hideHud', true)
end

function onDestroy()
	setPropertyFromClass('ClientPrefs', 'hideHud', ogHud)
end

function onCreatePost()
	setProperty('scoreFullweek.visible', false)
	
	precacheImage('pcport/bf-die')
	precacheImage('pcport/luigi')
	precacheImage('flower')
	precacheImage('mushroom')
	addCharacterToList('chavo-smb-small', 'boyfriend')
	addCharacterToList('chavo-smb', 'boyfriend')
	
	addCharacterToList('chavo-chase-small', 'boyfriend')
	addCharacterToList('chavo-chase', 'boyfriend')
	addCharacterToList('chavo-chase-fire', 'boyfriend')
	
	addCharacterToList('chavo-wall-fire', 'boyfriend')
	addCharacterToList('chavo-wall-small', 'boyfriend')
	addCharacterToList('chavo-wall', 'boyfriend')
	
	addCharacterToList('mx', 'dad')
	addCharacterToList('marionear', 'dad')
	addCharacterToList('big-mx', 'dad')
	addCharacterToList('mx-angry', 'dad')
	addCharacterToList('mx-angry2', 'dad')
	
	makeLuaSprite('border1','',960,0)
	makeGraphic('border1',500,4000,'000000')
	setScrollFactor('border1', 0, 0)
	
	makeLuaSprite('border2','',-200,-80)
	makeGraphic('border2',200,4000,'000000')
	setScrollFactor('border2', 0, 0)
	
	makeLuaSprite('goal', 'pcport/goal', 0, 0)
	setProperty('goal.antialiasing', false)
	scaleObject('goal', 6, 6)
	updateHitbox('goal')
	addLuaSprite('goal')
	
	makeLuaSprite('border', 'border', -150, -80)
	setProperty('border.antialiasing', false)
	setObjectCamera('border', 'other')
	scaleObject('border', 1.25, 1.25)
	addLuaSprite('border')
	
	makeLuaSprite('loop', 'pcport/loop', -2119 *6, 0)
	setProperty('loop.antialiasing', false)
	scaleObject('loop', 6, 6)
	updateHitbox('loop')
	addLuaSprite('loop')
	setProperty('loop.visible', false)
	
	makeLuaSprite('flagpole', 'pcport/flagpole', -2119 *6, 0)
	setProperty('flagpole.antialiasing', false)
	scaleObject('flagpole', 6, 6)
	updateHitbox('flagpole')
	addLuaSprite('flagpole')
	setProperty('flagpole.visible', false)
	
	makeLuaSprite('empty', 'pcport/empty', -2119 *6, 0)
	setProperty('empty.antialiasing', false)
	scaleObject('empty', 6, 6)
	updateHitbox('empty')
	addLuaSprite('empty')
	setProperty('empty.visible', false)
	
	makeAnimatedLuaSprite('popup', 'pcport/popup', 0, 0)
	addAnimationByPrefix('popup', 'popup', 'popup', 70, false)
	objectPlayAnimation('popup', 'popup')
	setProperty('popup.antialiasing', false)
	scaleObject('popup', 6, 6)
	updateHitbox('popup')
	addLuaSprite('popup', true)
	setProperty('popup.visible', false)
	
	---/////OBJECTS MAKING////---
		makeAnimatedLuaSprite('pipe1', 'pcport/pipebreak', 0, -16*6)
		addAnimationByIndices('pipe1', 'idle', 'pipebreak', '0, 0', 35)
		addAnimationByPrefix('pipe1', 'break', 'pipebreak', 70, false)
		setProperty('pipe1.antialiasing', false)
		addLuaSprite('pipe1')
		setProperty('pipe1.visible', false)
		
		breakableObjects[1] = getProperty('pipe1')
		
		makeAnimatedLuaSprite('pipe2', 'pcport/pipebreak', 0, -16*6)
		addAnimationByIndices('pipe2', 'idle', 'pipebreak', '0, 0', 35)
		addAnimationByPrefix('pipe2', 'break', 'pipebreak', 70, false)
		setProperty('pipe2.antialiasing', false)
		addLuaSprite('pipe2')
		setProperty('pipe2.visible', false)
		
		breakableObjects[12] = getProperty('pipe2')
		
		makeAnimatedLuaSprite('solidB1', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB1', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB1', 'break', 'brickbreak', 70, false)
		setProperty('solidB1.antialiasing', false)
		addLuaSprite('solidB1')
		setProperty('solidB1.visible', false)
		
		breakableObjects[2] = getProperty('solidB1')
		
		makeAnimatedLuaSprite('solidB2', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB2', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB2', 'break', 'brickbreak', 70, false)
		setProperty('solidB2.antialiasing', false)
		addLuaSprite('solidB2')
		setProperty('solidB2.visible', false)
		
		breakableObjects[3] = getProperty('solidB2')
		
		makeAnimatedLuaSprite('solidB3', 'pcport/brickbreak', 0, 17*6)
		addAnimationByIndices('solidB3', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB3', 'break', 'brickbreak', 70, false)
		setProperty('solidB3.antialiasing', false)
		addLuaSprite('solidB3')
		setProperty('solidB3.visible', false)
		
		breakableObjects[4] = getProperty('solidB3')
		
		makeAnimatedLuaSprite('solidB4', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB4', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB4', 'break', 'brickbreak', 70, false)
		setProperty('solidB4.antialiasing', false)
		addLuaSprite('solidB4')
		setProperty('solidB4.visible', false)
		
		breakableObjects[5] = getProperty('solidB4')
		
		makeAnimatedLuaSprite('solidB5', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB5', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB5', 'break', 'brickbreak', 70, false)
		setProperty('solidB5.antialiasing', false)
		addLuaSprite('solidB5')
		setProperty('solidB5.visible', false)
		
		breakableObjects[6] = getProperty('solidB5')
		
		makeAnimatedLuaSprite('solidB6', 'pcport/brickbreak', 0, 17*6)
		addAnimationByIndices('solidB6', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB6', 'break', 'brickbreak', 70, false)
		setProperty('solidB6.antialiasing', false)
		addLuaSprite('solidB6')
		setProperty('solidB6.visible', false)
		
		breakableObjects[7] = getProperty('solidB6')
		
		makeAnimatedLuaSprite('emptyB1', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB1', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB1', 'break', 'emptybreak', 70, false)
		setProperty('emptyB1.antialiasing', false)
		addLuaSprite('emptyB1')
		setProperty('emptyB1.visible', false)
		
		breakableObjects[8] = getProperty('emptyB1')
		
		makeAnimatedLuaSprite('emptyB2', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB2', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB2', 'break', 'emptybreak', 70, false)
		setProperty('emptyB2.antialiasing', false)
		addLuaSprite('emptyB2')
		setProperty('emptyB2.visible', false)
		
		breakableObjects[9] = getProperty('emptyB2')
		
		makeAnimatedLuaSprite('emptyB3', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB3', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB3', 'break', 'emptybreak', 70, false)
		setProperty('emptyB3.antialiasing', false)
		addLuaSprite('emptyB3')
		setProperty('emptyB3.visible', false)
		
		breakableObjects[10] = getProperty('emptyB3')
		
		makeAnimatedLuaSprite('emptyB4', 'pcport/emptybreak', 0, -16*6)
		addAnimationByIndices('emptyB4', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB4', 'break', 'emptybreak', 70, false)
		setProperty('emptyB4.antialiasing', false)
		addLuaSprite('emptyB4')
		setProperty('emptyB4.visible', false)
		
		breakableObjects[11] = getProperty('emptyB4')
		
		makeAnimatedLuaSprite('emptyB5', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB5', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB5', 'break', 'emptybreak', 70, false)
		setProperty('emptyB5.antialiasing', false)
		addLuaSprite('emptyB5')
		setProperty('emptyB5.visible', false)
		
		breakableObjects[13] = getProperty('emptyB5')
		
		makeAnimatedLuaSprite('emptyB6', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB6', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB6', 'break', 'emptybreak', 70, false)
		setProperty('emptyB6.antialiasing', false)
		addLuaSprite('emptyB6')
		setProperty('emptyB6.visible', false)
		
		breakableObjects[14] = getProperty('emptyB6')
		
		makeAnimatedLuaSprite('emptyB7', 'pcport/emptybreak', 0, -20*6)
		addAnimationByIndices('emptyB7', 'idle', 'emptybreak', '0, 0', 35)
		addAnimationByPrefix('emptyB7', 'break', 'emptybreak', 70, false)
		setProperty('emptyB7.antialiasing', false)
		addLuaSprite('emptyB7')
		setProperty('emptyB7.visible', false)
		
		breakableObjects[15] = getProperty('emptyB7')
		
		makeAnimatedLuaSprite('solidB7', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB7', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB7', 'break', 'brickbreak', 70, false)
		setProperty('solidB7.antialiasing', false)
		addLuaSprite('solidB7')
		setProperty('solidB7.visible', false)
		
		breakableObjects[16] = getProperty('solidB7')
		
		makeAnimatedLuaSprite('solidB8', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB8', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB8', 'break', 'brickbreak', 70, false)
		setProperty('solidB8.antialiasing', false)
		addLuaSprite('solidB8')
		setProperty('solidB8.visible', false)
		
		breakableObjects[17] = getProperty('solidB8')
		
		makeAnimatedLuaSprite('solidB9', 'pcport/brickbreak', 0, 17*6)
		addAnimationByIndices('solidB9', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB9', 'break', 'brickbreak', 70, false)
		setProperty('solidB9.antialiasing', false)
		addLuaSprite('solidB9')
		setProperty('solidB9.visible', false)
		
		breakableObjects[18] = getProperty('solidB9')
		
		makeAnimatedLuaSprite('solidB10', 'pcport/brickbreak', 0, 17*6)
		addAnimationByIndices('solidB10', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB10', 'break', 'brickbreak', 70, false)
		setProperty('solidB10.antialiasing', false)
		addLuaSprite('solidB10')
		setProperty('solidB10.visible', false)
		
		breakableObjects[19] = getProperty('solidB10')
		
		makeAnimatedLuaSprite('solidB11', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB11', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB11', 'break', 'brickbreak', 70, false)
		setProperty('solidB11.antialiasing', false)
		addLuaSprite('solidB11')
		setProperty('solidB11.visible', false)
		
		breakableObjects[20] = getProperty('solidB11')
		
		makeAnimatedLuaSprite('solidB12', 'pcport/brickbreak', 0, 33*6)
		addAnimationByIndices('solidB12', 'idle', 'brickbreak', '0, 0', 35)
		addAnimationByPrefix('solidB12', 'break', 'brickbreak', 70, false)
		setProperty('solidB12.antialiasing', false)
		addLuaSprite('solidB12')
		setProperty('solidB12.visible', false)
		
		breakableObjects[21] = getProperty('solidB12')
		
	--//////OBJECTS END////----
	makeLuaSprite('brickscroll', 'pcport/brickscroll', 0, 0)
	setProperty('brickscroll.antialiasing', false)
	scaleObject('brickscroll', 6, 6)
	updateHitbox('brickscroll')
	addLuaSprite('brickscroll')
	setProperty('brickscroll.visible', false)
	
	makeLuaSprite('pipeEnd', 'pcport/endpipe', 0, 0)
	setProperty('pipeEnd.antialiasing', false)
	scaleObject('pipeEnd', 6, 6)
	updateHitbox('pipeEnd')
	addLuaSprite('pipeEnd', true)
	setProperty('pipeEnd.visible', false)
	
	addLuaSprite('border1',true)
	addLuaSprite('border2',true)
	
	makeLuaSprite('hiddenWall', 'pcport/hiddenwall', 0, 0)
	setProperty('hiddenWall.antialiasing', false)
	scaleObject('hiddenWall', 6, 6)
	updateHitbox('hiddenWall')
	addLuaSprite('hiddenWall')
	setProperty('hiddenWall.visible', false)
	
	makeAnimatedLuaSprite('mxLegs', 'pcport/legs', 70*6, 8.95*6)
	addAnimationByPrefix('mxLegs', 'idle', 'legs', 48, true)
	addAnimationByPrefix('mxLegs', 'idle-mad', 'runmad', 40, true)
	addAnimationByPrefix('mxLegs', 'jump', 'legjump', 30, true)
	setProperty('mxLegs.antialiasing', false)
	addLuaSprite('mxLegs')
	setProperty('mxLegs.visible', false)
	
	makeAnimatedLuaSprite('bfLegs', 'pcport/bflegs', 70*6, 8.95*6)
	addAnimationByPrefix('bfLegs', 'idle', 'run0', 30, true)
	addAnimationByPrefix('bfLegs', 'jump', 'jump0', 30, true)
	addAnimationByPrefix('bfLegs', 'idle-fire', 'runfire0', 30, true)
	addAnimationByPrefix('bfLegs', 'jump-fire', 'jumpfire0', 30, true)
	addAnimationByPrefix('bfLegs', 'idle-small', 'runsmall0', 30, true)
	addAnimationByPrefix('bfLegs', 'jump-small', 'jumpsmall0', 30, true)
	setProperty('bfLegs.antialiasing', false)
	addLuaSprite('bfLegs')
	setProperty('bfLegs.visible', false)
	scaleObject('bfLegs', 6, 6)

	makeLuaSprite('one', '1', 70.95*6, 28.5*6)
	setProperty('one.antialiasing', false)
	scaleObject('one', 6, 6)
	updateHitbox('one')
	addLuaSprite('one', true)
	setProperty('one.visible', false)
	
	makeLuaSprite('two', '2', 70.95*6, 28.5*6)
	setProperty('two.antialiasing', false)
	scaleObject('two', 6, 6)
	updateHitbox('two')
	addLuaSprite('two', true)
	setProperty('two.visible', false)
	
	makeLuaSprite('three', '3', 71.95*6, 28.5*6)
	setProperty('three.antialiasing', false)
	scaleObject('three', 6, 6)
	updateHitbox('three')
	addLuaSprite('three', true)
	setProperty('three.visible', false)
	
	makeLuaSprite('go', 'start', 61.95*6, 24.45*6)
	setProperty('go.antialiasing', false)
	scaleObject('go', 6, 6)
	updateHitbox('go')
	addLuaSprite('go', true)
	setProperty('go.visible', false)
	
	makeLuaText('disclaimer', 'IF YOU WANNA TOGGLE BREAK IMPACT DURING\nTHE CHASE SEQUENCE:\n PRESS F1!', 0, getPropertyFromClass('flixel.FlxG', 'width')/2-(80*6)+2, getPropertyFromClass('flixel.FlxG', 'height')/2-(15*6))
	setProperty('disclaimer.borderSize', 0)
	setProperty('disclaimer.antialiasing', false)
	setTextFont('disclaimer', 'smb1.ttf')
	setTextSize('disclaimer', 4*6, 4*6)
	setScrollFactor('disclaimer', 0, 0)
	setTextAlignment('disclaimer', 'center')
	addLuaText('disclaimer')
	setProperty('camGame.alpha', 0)
	
	setProperty('dad.x', 110*6)
	setProperty('dad.y', 22*6)
	
	makeLuaSprite('mxPoint', 'pcport/legs', 74*6, 8.95*6)
	makeLuaSprite('bfPoint', 'pcport/legs', 74*6, 8.95*6)
end

function onGameOverStart()
	-- You died! Called every single frame your health is lower (or equal to) zero
	--return Function_Stop
	--setScrollFactor(getPropertyFromClass('GameOverSubstate', 'boyfriend'), 0, 0)
	setPropertyFromClass('flixel.FlxG', 'camera.x', 0)
	setPropertyFromClass('flixel.FlxG', 'camera.y', 0)
	setProperty('boyfriend.x', 580)
	setProperty('boyfriend.y', 385)
	objectPlayAnimation('boyfriend', 'die', true)
	return Function_Continue;
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'powerup' and not isSustainNote then
		if powerup < 2 then
			if getPropertyFromGroup('notes', id, 'texture') == 'mushroom' then
				powerup = 1
			else
				powerup = 2
			end
			powerupSpawned = false
			powerupVisuals(getProperty('boyfriend.animation.name'), getProperty('boyfriend.animation.curAnim.curFrame'))
			playSound('powerup')
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'big-mx' and flashingLights then
		--triggerEvent('Pixel Cam Shake', '3, 2, 2', '0.025')
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if dmgCooldown <= 0 then
		dmgCooldown = 2.5
		powerup = powerup - 1
		playSound('power_down')
		if powerup < 0 then
			setProperty('health', 0)
		else
			powerupVisuals(getProperty('boyfriend.animation.name'), getProperty('boyfriend.animation.curAnim.curFrame'))
		end
	end
end

function powerupVisuals(curAnim, curFrame)
	prefix = bfPrefix
	stopFlicker = true
	if powerup == 2 then
		triggerEvent('Change Character', 'chavo', prefix..'-fire')
		bfLegsPrefix = '-fire'
		timeUntilPowerup = -1
	elseif powerup == 1 then
		timeUntilPowerup = 12
		triggerEvent('Change Character', 'chavo', prefix)
		bfLegsPrefix = ''
	elseif powerup == 0 then
		timeUntilPowerup = 5
		triggerEvent('Change Character', 'chavo', prefix..'-small')
		bfLegsPrefix = '-small'
	end
	legsAnim = getProperty('bfLegs.animation.curAnim.name')
	animToPlay = ''
	if legsAnim == 'jump' or legsAnim == 'jump-fire' or legsAnim == 'jump-small' then
		animToPlay = 'jump'
	else 
		animToPlay = 'idle'
	end
	objectPlayAnimation('bfLegs', animToPlay..bfLegsPrefix, true)
	stopFlicker = false

	if prefix == 'chavo-chase' then
		setProperty('boyfriend.x', 37*6)
		setProperty('boyfriend.y', 28*6)
	elseif prefix == 'chavo-wall' then
		setProperty('boyfriend.x', 0)
		setProperty('boyfriend.y', 0)
	end
	
	characterPlayAnim('boyfriend', curAnim, true)
	setProperty('boyfriend.animation.curAnim.curFrame', curFrame)
end

function onStartCountdown()
	-- countdown started, duh
	if not allowCountdown then
		return Function_Stop
	end
	return Function_Continue;
end

math.round = function(num)
    return math.floor(num + 0.5)
end

startTrigger = false
triggered = false
stopFlicker = false

starColor = 0

trigger = false
deathTrigger = false

powerupSpawned = false
pressedEnter = false
set = false

function onUpdate(elapsed)
	setProperty('camZooming', false)
	
	if powerup >= 0 then
		setProperty('health', 1)
	end
	
	if timeUntilPowerup > 0 then
		timeUntilPowerup = timeUntilPowerup - elapsed
		--debugPrint(timeUntilPowerup)
	elseif timeUntilPowerup <= 0 then
		if powerup < 2 and not powerupSpawned then
			if getPropertyFromGroup('unspawnNotes', 0, 'noteType') == '' and getPropertyFromGroup('unspawnNotes', 0, 'mustPress') and getPropertyFromGroup('unspawnNotes', 0, 'isSustainNote') == false then
				--debugPrint('powerup spawn')
				powerupSpawned = true
				setPropertyFromGroup('unspawnNotes', 0, 'noteType', 'powerup')
				if powerup == 0 then
					setPropertyFromGroup('unspawnNotes', 0, 'texture', 'mushroom')
				elseif powerup == 1 then 
					setPropertyFromGroup('unspawnNotes', 0, 'texture', 'flower')
				end
			end
		end
	end
	
	if dmgCooldown > 0 then
		setProperty('boyfriend.alpha', (getPropertyFromClass('flixel.FlxG', 'game.ticks') % 2))
		setProperty('bfLegs.alpha', (getPropertyFromClass('flixel.FlxG', 'game.ticks') % 2))
		dmgCooldown = dmgCooldown - elapsed
		if dmgCooldown <= 0 then
			dmgCooldown = 0
			setProperty('boyfriend.alpha', 1)
			setProperty('bfLegs.alpha', 1)
		end
	end
	
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') and not pressedEnter then
		pressedEnter = true
		removeLuaText('disclaimer')
		setProperty('one.visible', true)
		setProperty('camGame.alpha', getProperty('camGame.alpha') + 0.25)
		runTimer('countdown1', 0.63)
		playSound('countdown')
	end
	
	--cahse shit
	if isChase then
		if startTrigger == false then
			startTrigger = true
			removeLuaSprite('goal')
			setProperty('flagpole.visible', true)
			setProperty('loop.visible', true)
			setProperty('mxLegs.visible', true)
			chaseBGX = getProperty('loop.x')
			
			setProperty('mxPoint.y', getProperty('mxLegs.y'))
			mxLegsHighY = getProperty('mxLegs.y') - (40*6)
			mxLegsDefY = getProperty('mxLegs.y')
			
			setProperty('bfPoint.y', getProperty('bfLegs.y'))
			bfLegsHighY = getProperty('bfLegs.y') - (40*6)
			bfLegsDefY = getProperty('bfLegs.y')
			
			for i,object in pairs(breakableObjects) do
				setProperty(object..'.visible', true)
			end
		end
		
		--legs shit
		if getProperty('dad.idleSuffix') ~= '-j' then
			if getProperty('dad.animation.curAnim.name') == 'idle' and getProperty('mxLegs.visible') ~= false then
				setProperty('mxLegs.visible', false)
			elseif getProperty('dad.animation.curAnim.name') ~= 'idle' and getProperty('mxLegs.visible') ~= true then
				setProperty('mxLegs.visible', true)
			end
		elseif getProperty('mxLegs.visible') ~= true then
			setProperty('mxLegs.visible', true)
		end
		
		if getProperty('boyfriend.idleSuffix') ~= '-j' then
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' and getProperty('bfLegs.visible') ~= false then
				setProperty('bfLegs.visible', false)
			elseif getProperty('boyfriend.animation.curAnim.name') ~= 'idle' and getProperty('bfLegs.visible') ~= true then
				setProperty('bfLegs.visible', true)
			end
		elseif getProperty('bfLegs.visible') ~= true then
			setProperty('bfLegs.visible', true)
		end
		
		--bg shit

		chaseBGX = chaseBGX + 1640 * elapsed
		
		if chaseBGX >= 0 then
			if getProperty('brickscroll.visible') == false then
				setProperty('brickscroll.visible', true)
			end
			removeLuaSprite('flagpole')
			chaseBGX = -2119 *6
			for i=1, #jumpTriggers do --wanted to do a different for loop but it wouldnt work :v
				jumpTriggers[i] = false
			end
			
			for i,object in pairs(breakableObjects) do
				if not pipeEnd then
					objectPlayAnimation(object, 'idle', true)
				end
			end
		end
		setProperty('loop.x', math.round(chaseBGX/6)*6)
		setProperty('brickscroll.x', getProperty('loop.x'))
		setProperty('pipeEnd.x', getProperty('loop.x'))
		setProperty('empty.x', getProperty('loop.x'))
		if getProperty('flagpole') ~= nil then
			setProperty('flagpole.x', getProperty('loop.x'))
		end
		--debugPrint(getProperty('loop.x'))
		
		--mx shit
		if not pipeEnd then
			for i=-1684*6, -1648*6 do
				if getProperty('loop.x') == i and not jumpTriggers[1] then
					jumpTriggers[1] = true
					doTweenY('jumpMX', 'mxPoint', mxLegsHighY, 0.4, 'sineOut')
					objectPlayAnimation('mxLegs', 'jump', true)
					setProperty('dad.idleSuffix', '-j')
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						characterPlayAnim('dad', 'idle-j', true)
					end
				end
			end
			
			for i=-1356*6, -1340*6 do
				if getProperty('loop.x') == i and not jumpTriggers[2] then
					jumpTriggers[2] = true
					doTweenY('jumpMX', 'mxPoint', mxLegsHighY, 0.45, 'sineOut')
					objectPlayAnimation('mxLegs', 'jump', true)
					setProperty('dad.idleSuffix', '-j')
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						characterPlayAnim('dad', 'idle-j', true)
					end
				end
			end
			
			for i=-835*6, -825*6 do
				if getProperty('loop.x') == i and not jumpTriggers[7] then
					jumpTriggers[7] = true
					doTweenY('jumpMX', 'mxPoint', mxLegsHighY, 0.45, 'sineOut')
					objectPlayAnimation('mxLegs', 'jump', true)
					setProperty('dad.idleSuffix', '-j')
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						characterPlayAnim('dad', 'idle-j', true)
					end
				end
			end
			
			for i=-549*6, -540*6 do
				if getProperty('loop.x') == i and not jumpTriggers[9] then
					jumpTriggers[9] = true
					doTweenY('jumpMX', 'mxPoint', mxLegsHighY, 0.45, 'sineOut')
					objectPlayAnimation('mxLegs', 'jump', true)
					setProperty('dad.idleSuffix', '-j')
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						characterPlayAnim('dad', 'idle-j', true)
					end
				end
			end
			
			for i=-138*6, -130*6 do
				if getProperty('loop.x') == i and not jumpTriggers[12] then
					jumpTriggers[12] = true
					doTweenY('jumpMX', 'mxPoint', mxLegsHighY, 0.45, 'sineOut')
					objectPlayAnimation('mxLegs', 'jump', true)
					setProperty('dad.idleSuffix', '-j')
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						characterPlayAnim('dad', 'idle-j', true)
					end
				end
			end
			
			--bf shit
			for i=-2119*6, -2075*6 do
				if getProperty('loop.x') == i and not jumpTriggers[3] then
					jumpTriggers[3] = true
					doTweenY('jumpBF', 'bfPoint', bfLegsHighY+(2*6), 0.45, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-1760*6, -1712*6 do
				if getProperty('loop.x') == i and not jumpTriggers[4] then
					jumpTriggers[4] = true
					doTweenY('jumpBF', 'bfPoint', bfLegsHighY+(6*6), 0.5, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-1430*6, -1411*6 do
				if getProperty('loop.x') == i and not jumpTriggers[5] then
					jumpTriggers[5] = true
					doTweenY('jumpBF', 'bfPoint', bfLegsHighY+(10*6), 0.45, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-955*6, -910*6 do
				if getProperty('loop.x') == i and not jumpTriggers[6] then
					jumpTriggers[6] = true
					doTweenY('jumpBFs', 'bfPoint', bfLegsHighY-(2*6), 0.5, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-620*6, -600*6 do
				if getProperty('loop.x') == i and not jumpTriggers[8] then
					jumpTriggers[8] = true
					doTweenY('jumpBFF', 'bfPoint', bfLegsHighY+(15*6), 0.3, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-440*6, -415*6 do
				if getProperty('loop.x') == i and not jumpTriggers[10] then
					jumpTriggers[10] = true
					doTweenY('jumpBF', 'bfPoint', bfLegsHighY, 0.4, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
			
			for i=-194*6, -180*6 do
				if getProperty('loop.x') == i and not jumpTriggers[11] then
					jumpTriggers[11] = true
					doTweenY('jumpBFF', 'bfPoint', bfLegsHighY+(18*6), 0.25, 'sineOut')
					objectPlayAnimation('bfLegs', 'jump'..bfLegsPrefix, true)
					setProperty('boyfriend.idleSuffix', '-j')
					if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
						characterPlayAnim('boyfriend', 'idle-j', true)
					end
				end
			end
		end
		
		setProperty('boyfriend.y', math.round(getProperty('bfPoint.y')/6)*6+(1*6))
		setProperty('bfLegs.y', getProperty('boyfriend.y')-(1*6))
		
		setProperty('dad.y', math.round(getProperty('mxPoint.y')/6)*6)
		setProperty('mxLegs.y', getProperty('dad.y'))
		
		--objects shit
		for i,object in pairs(breakableObjects) do
			local offset = 0
			
			if i == 1 then --pipe 1
				offset = 2010
			elseif i == 2 then
				offset = 2088
			elseif i == 3 or i == 4 then
				offset = 2072
			elseif i == 5 then
				offset = 1992
			elseif i == 6 or i == 7 then
				offset = 2008
			elseif i == 8 then
				offset = 1400
			elseif i == 9 then
				offset = 1369
			elseif i == 10 then
				offset = 1336
			elseif i == 11 then
				offset = 1768
			elseif i == 12 then --pipe 2
				offset = 870
			elseif i == 13 then
				offset = 602
			elseif i == 14 then
				offset = 571
			elseif i == 15 then
				offset = 540
			elseif i == 16 then
				offset = 426
			elseif i == 17 or i == 18 then
				offset = 410
			elseif i == 19 or i == 20 then
				offset = 345
			elseif i == 21 then
				offset = 329
			end
			
			hitboxOfs = 0
			
			if i == 1 or i == 12 then
				hitboxOfs = 52
			else
				hitboxOfs = 20
			end
			
			setProperty(object..'.x', getProperty('loop.x') + (offset * 6))
			
			if getProperty(object..'.x') >= (getProperty('dad.x') - (hitboxOfs * 6)) and not pipeEnd then
			
				if getProperty(object..'.animation.curAnim.name') ~= 'break' then
					objectPlayAnimation(object, 'break', true)
					if impact then
						triggerEvent('Pixel Cam Shake', '5, 4, 3', '0.015')
						playSound('break', 3)
					end
				end
				
			end
		end
	elseif pipeEnd and getProperty('boyfriend.animation.curAnim.name') ~= 'pause' then
		characterPlayAnim('boyfriend', 'pause', true)
		characterPlayAnim('dad', 'pause', true)
	end
	
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F1') then
		impact = not impact
	end
	
	if not middlescroll then
		if curBeat == 0 then
			setPropertyFromGroup('playerStrums', 0, 'y', defaultOpponentStrumY0-30)

			setPropertyFromGroup('playerStrums', 1, 'y', defaultOpponentStrumY1-30)

			setPropertyFromGroup('playerStrums', 2, 'y', defaultOpponentStrumY2-30)

			setPropertyFromGroup('playerStrums', 3, 'y', defaultOpponentStrumY3-30)


			setPropertyFromGroup('opponentStrums', 0, 'y', defaultPlayerStrumY0 - 30)

			setPropertyFromGroup('opponentStrums', 1, 'y', defaultPlayerStrumY1 - 30)

			setPropertyFromGroup('opponentStrums', 2, 'y', defaultPlayerStrumY2 - 30)

			setPropertyFromGroup('opponentStrums', 3, 'y', defaultPlayerStrumY3 - 30)


		end
	end
end

function onTweenCompleted(tag)
	if tag == 'jumpMX' then
		doTweenY('fallMX', 'mxPoint', mxLegsDefY, 0.45, 'sineIn')
	end
	
	if tag == 'fallMX' then
		setProperty('dad.idleSuffix', '')
		objectPlayAnimation('mxLegs', 'idle'..legsSuffix, true)
		if getProperty('dad.animation.curAnim.name') == 'idle-j' then
			characterPlayAnim('dad', 'idle', true)
		end
	end
	
	if tag == 'jumpBF' then
		doTweenY('fallBF', 'bfPoint', bfLegsDefY, 0.4, 'sineIn')
	end
	
	if tag == 'jumpBFF' then
		doTweenY('fallBF', 'bfPoint', bfLegsDefY, 0.25, 'sineIn')
	end
	
	if tag == 'jumpBFs' then
		doTweenY('fallBF', 'bfPoint', bfLegsDefY, 0.5, 'sineIn')
	end
	
	if tag == 'fallBF' then
		setProperty('boyfriend.idleSuffix', '')
		objectPlayAnimation('bfLegs', 'idle'..bfLegsPrefix, true)
		if getProperty('boyfriend.animation.curAnim.name') == 'idle-j' then
			characterPlayAnim('boyfriend', 'idle', true)
		end
	end
end

function onMoveCamera(focus)
	setPropertyFromClass('flixel.FlxG.camera', 'target', nil)
	setProperty('camGame.zoom', 0.8)
	setProperty('camGame.x', 23*6)
	setProperty('camGame.y', 15*6)
	setProperty('camHUD.zoom', 0.8)
	setProperty('isCameraOnForcedPos', true)
	setProperty('camFollowPos.x', getPropertyFromClass('flixel.FlxG', 'width') / 2)
	setProperty('camFollowPos.y', getPropertyFromClass('flixel.FlxG', 'height') / 2)
	setProperty('camFollow.x', getPropertyFromClass('flixel.FlxG', 'width') / 2)
	setProperty('camFollow.y', getPropertyFromClass('flixel.FlxG', 'height') / 2)
end

starTrigger = false
curFrame = -1
function onEvent(n, v1, v2)
	if n == 'Powerup Visuals' and v1 == 'chavo-chase' then
		stopFlicker = false
		bfPrefix = v1
		powerupVisuals(getProperty('boyfriend.animation.name'), getProperty('boyfriend.animation.curAnim.curFrame'))
		setProperty('boyfriend.x', 37*6)
		setProperty('boyfriend.y', 28*6)
		setProperty('bfLegs.x', 37*6)
		setProperty('bfLegs.y', 26*6)
	end

	if n == 'Powerup Visuals' and v1 == 'chavo-wall' then
		stopFlicker = false
		bfPrefix = v1
		powerupVisuals(getProperty('boyfriend.animation.name'), getProperty('boyfriend.animation.curAnim.curFrame'))
		setProperty('boyfriend.x', 0)
		setProperty('boyfriend.y', 0)
		setProperty('camHUD.visible', true)
		removeLuaSprite('luigiDead')
	end
	
	if n == 'Change Character' and v2 == 'marionear' then
		setProperty('dad.y', 29*6)
	end
	
	if n == 'Change Character' and v2 == 'mx' then
		if not starTrigger then
			starTrigger = true
			stopFlicker = true
			cancelTween('starFlicker')
		end
		setProperty('dad.x', 78*6)
		setProperty('dad.y', 9.1*6)
		setProperty('mxLegs.x', getProperty('dad.x'))
		isChase = true
	end
	
	if n == 'Powerup Visuals' and v1 == 'chavo-chase' then
		if isChase == false then
			isChase = true
			setProperty('camGame.visible', true)
		end
	end
	
	if n == 'Change Character' and v2 == 'mx-angry' then
		stopFlicker = true
		cancelTween('starFlicker')
		legsSuffix = '-mad'
		setProperty('dad.x', 78*6)
		setProperty('dad.y', 9*6)
		setProperty('mxLegs.y', getProperty('dad.y'))
		switchScene(false)
	end
	
	if n == 'Change Character' and v2 == 'mx-angry2' then
		setProperty('dad.x', 78*6)
		setProperty('dad.y', 9.05*6)
	end
	
	if n == 'Change Character' and v2 == 'big-mx' then
		stopFlicker = true
		cancelTween('starFlicker')
		isChase = false
		setProperty('dad.x', 0)
		setProperty('dad.y', 0)
		switchScene(true)
	end
	
	if n == 'end Pipe' then
		pipeEnd = true
		setProperty('pipeEnd.visible', true)
		setProperty('loop.visible', false)
		setProperty('empty.visible', true)
		for i,object in pairs(breakableObjects) do
			removeLuaSprite(object)
		end
		
		for i=1, #jumpTriggers do --wanted to do a different for loop but it wouldnt work :v
			jumpTriggers[i] = true
		end
	end
	
	if n == 'Enter Pipe' then
		isChase = false
		removeLuaSprite('mxLegs')
		removeLuaSprite('bfLegs')
		setProperty('boyfriend.y', getProperty('boyfriend.y')-(4*6))
		runTimer('goIntoPipe', 0.05, 30)
	end
	
	if n == 'Popup' then
		curFrame = curFrame + 1
		if curFrame < 10 then
			setProperty('popup.animation.curAnim.curFrame', curFrame)
			setProperty('popup.visible', true)
		else
			removeLuaSprite('popup')
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'goIntoPipe' then
		setProperty('boyfriend.x', getProperty('boyfriend.x')-6)
	end

	
	if tag == 'countdown1' then
		removeLuaSprite('one')
		setProperty('two.visible', true)
		playSound('countdown')
		runTimer('countdown2', 0.63)
		setProperty('camGame.alpha', getProperty('camGame.alpha') + 0.25)
		allowCountdown = true
		startCountdown()
		for i=0, getProperty('opponentStrums.length')-1 do
			if not middlescroll then
				setPropertyFromGroup('opponentStrums', i, 'alpha', 1)
				setPropertyFromGroup('playerStrums', i, 'alpha', 1)
			else 
				setPropertyFromGroup('opponentStrums', i, 'visible', false)
				setPropertyFromGroup('playerStrums', i, 'alpha', 1)
			end
			setPropertyFromGroup('opponentStrums', i, 'texture', 'smbNotes')
			setPropertyFromGroup('playerStrums', i, 'texture', 'smbNotes')
		end
		for i=0, getProperty('strumLineNotes.length')-1 do
			if middlescroll and downscroll then
			setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y')+8*6)
			elseif not middlescroll and downscroll then
			setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y')+10*6)
			end
			
			if middlescroll and not downscroll then
				setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y')-4*6)
			end
		end
	end
	
	if tag == 'countdown2' then
		removeLuaSprite('two')
		setProperty('three.visible', true)
		playSound('countdown')
		runTimer('countdown3', 0.63)
		setProperty('camGame.alpha', getProperty('camGame.alpha') + 0.25)
	end
	
	if tag == 'countdown3' then
		removeLuaSprite('three')
		setProperty('go.visible', true)
		playSound('countdownEnd')
		runTimer('countdown4', 0.63)
		setProperty('camGame.alpha', getProperty('camGame.alpha') + 0.25)
	end
	
	if tag == 'countdown4' then
		removeLuaSprite('go')
	end
end

function switchScene(isWall)
	if isWall then
		isChase = false
		setObjectOrder('hiddenWall', getObjectOrder('dadGroup') + 1)
		setObjectOrder('boyfriendGroup', getObjectOrder('hiddenWall') + 1)
		makeLuaSprite('luigiDead', 'pcport/luigi', 0, 0)
		setProperty('luigiDead.antialiasing', false)
		scaleObject('luigiDead', 6, 6)
		updateHitbox('luigiDead')
		addLuaSprite('luigiDead', true)
		
		for i,object in pairs(breakableObjects) do
			setProperty(object..'.visible', false)
		end
		
		setProperty('brickscroll.visible', false)
		setProperty('hiddenWall.visible', true)
		setProperty('camHUD.visible', false)
		setProperty('mxLegs.visible', false)
		setProperty('bfLegs.visible', false)
		setProperty('loop.visible', false)
	else
		removeLuaSprite('hiddenWall')
		setProperty('brickScroll.visible', true)
		setProperty('camGame.visible', false)
		
		for i=1, #jumpTriggers do --wanted to do a different for loop but it wouldnt work :v
				jumpTriggers[i] = false
			end
		
		startTrigger = false
		for i,object in pairs(breakableObjects) do
			objectPlayAnimation(object, 'idle', true)
		end
		setProperty('loop.x', -2119 * 6)
	end
end