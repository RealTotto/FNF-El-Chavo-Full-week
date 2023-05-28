function onEvent(name, value1, value2)
    	if name == 'Color Time' then
			if value1 == '0' then --turn off
				setProperty('timeBar.color',getColorFromHex("FFFFFF"));
			elseif value1 == '1' then --blue
				setProperty('timeBar.color',getColorFromHex("0000FF"))
			elseif value1 == '2' then --green
				setProperty('timeBar.color',getColorFromHex("008000"))
			elseif value1 == '3' then --pink
				setProperty('timeBar.color',getColorFromHex("FF0080"))
			elseif value1 == '4' then --red					
				setProperty('timeBar.color',getColorFromHex("FF0000"))	
			elseif value1 == '5' then --orange					
				setProperty('timeBar.color',getColorFromHex("FF8000"))	
			end
		end					

		if value2 == '0' then --turn off
			setProperty('timeTxt.color',getColorFromHex("FFFFFF"));
		elseif value2 == '1' then --blue
			setProperty('timeTxt.color',getColorFromHex("0000FF"))
		elseif value2 == '2' then --green
			setProperty('timeTxt.color',getColorFromHex("008000"))
		elseif value2 == '3' then --pink
			setProperty('timeTxt.color',getColorFromHex("FF0080"))
		elseif value2 == '4' then --red					
			setProperty('timeTxt.color',getColorFromHex("FF0000"))	
		elseif value2 == '5' then --orange					
			setProperty('timeTxt.color',getColorFromHex("FF8000"))		
		end
	end



