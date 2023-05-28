function onEvent(name, value1, value2)
	if name == 'IconSpin' then
		--setProperty('iconP1.angle', -20);
		if value1 == 'P1' then		
            doTweenAngle('vuelta','iconP1', 360, value2, 'circOut')
	    elseif value1 == 'P2' then --blue
			doTweenAngle('vuelta2','iconP2', 360, value2, 'circOut') 
	    elseif value1 == 'both' then --blue
			doTweenAngle('vuelta2','iconP2', 360, value2, 'circOut')
			doTweenAngle('vuelta','iconP1', 360, value2, 'circOut') 			
		end 
	end
end
