velocity = 0

function onCreate()
	daBF = "chavo"

	setPropertyFromClass("GameOverSubstate", "characterName", daBF.."-dead")
	setPropertyFromClass("GameOverSubstate", "deathSoundName", "death")
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "")
	setPropertyFromClass("GameOverSubstate", "endSoundName", "")
end

function onGameOverStart()
	timeUntilStart = 0.4
	timeUntilReset = 3
	xPosition = getProperty("boyfriend.x")
	yPosition = getProperty("boyfriend.y")
end

function onUpdate(elapsed)
	if inGameOver then
		timeUntilReset = timeUntilReset - elapsed
		if timeUntilReset <= 0 or keyJustPressed("accept") then
			restartSong(true)
		end

		if timeUntilStart > 0 then
			timeUntilStart = timeUntilStart - elapsed
			if timeUntilStart <= 0 then
				timeUntilStart = 0
				velocity = -750
				removeLuaSprite("redScreen", true)
			end
		else
			velocity = velocity + (12.5 * 130 * elapsed)
		end	

		yPosition = yPosition + velocity * elapsed
		setProperty("boyfriend.y", math.floor(yPosition / 6) * 6)
	end
end