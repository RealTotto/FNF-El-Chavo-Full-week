total = 0
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'ring' then
			total = total + 1
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'genesis/ui/ringNotes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0); --Default value is: health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Default value is: health lost on miss
			--debugPrint(total)
		end
	end
	--debugPrint('Script started!')
end