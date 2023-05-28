function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'RingNote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra_note/ham_cake'); -- texture path
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true); --no note splashes
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', false); 
			setPropertyFromGroup('unspawnNotes', i, 'copyAlpha', false); 
			setPropertyFromGroup('unspawnNotes', i, 'copyX', false);  
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', 0)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', 0)
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', 0)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 0)
			--setPropertyFromGroup('unspawnNotes', i, 'copyY', false);  
			setPropertyFromGroup('unspawnNotes', i, 'noteData', 0); -- ITS ALWAYS A DAD RIGHT NOTE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		end
	end
end
