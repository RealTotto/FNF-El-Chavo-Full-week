function onStepHit()
	if curStep == 1456 then
		noteTweenAlpha('A', 4, 0, 1, 'circInOut')
		noteTweenAlpha('B', 5, 0, 1, 'circInOut')
		noteTweenAlpha('C', 6, 0, 1, 'circInOut')
		noteTweenAlpha('D', 7, 0, 1, 'circInOut')
	end

	if curStep == 1712 then
		noteTweenAlpha('A', 4, 1, 0.2, 'circInOut')
		noteTweenAlpha('B', 5, 1, 0.2, 'circInOut')
		noteTweenAlpha('C', 6, 1, 0.2, 'circInOut')
		noteTweenAlpha('D', 7, 1, 0.2, 'circInOut')
	end		
end