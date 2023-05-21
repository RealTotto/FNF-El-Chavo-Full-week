function onSongStart()
	noteTweenX('opponentNote0', 0, -1000, 1.5, 'elasticInOut') --Notes Opponent
	noteTweenX('opponentNote1', 1, -1000, 1.5, 'elasticInOut')
	noteTweenX('opponentNote2', 2, -1000, 1.5, 'elasticInOut')
	noteTweenX('opponentNote3', 3, -1000, 1.5, 'elasticInOut')
	noteTweenAngle('byeOpponentNote0', 0, 360, 1, 'elasticInOut')-- Rotation Opponent Notes
	noteTweenAngle('byeOpponentNote1', 1, 360, 1, 'elasticInOut')
	noteTweenAngle('byeOpponentNote2', 2, 360, 1, 'elasticInOut')
	noteTweenAngle('byeOpponentNote3', 3, 360, 1, 'elasticInOut')
	noteTweenX('boyfriendNote0', 4, 415, 1, 'elasticInOut')-- Notes Boyfriend
	noteTweenX('boyfriendNote1', 5, 525, 1, 'elasticInOut')
	noteTweenX('boyfriendNote2', 6, 635, 1, 'elasticInOut')
	noteTweenX('boyfriendNote3', 7, 745, 1, 'elasticInOut')
	noteTweenAngle('byeBoyfriendNote0', 4, 360, 1, 'elasticInOut')-- Rotation Boyfriend Notes
	noteTweenAngle('byeBoyfriendNote1', 5, 360, 1, 'elasticInOut')
	noteTweenAngle('byeBoyfriendNote2', 6, 360, 1, 'elasticInOut')
	noteTweenAngle('byeBoyfriendNote3', 7, 360, 1, 'elasticInOut')
end


