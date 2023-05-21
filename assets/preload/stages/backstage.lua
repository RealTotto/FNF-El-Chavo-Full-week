function onCreate()
	--background boi
--stage1
	makeLuaSprite('stage_red', 'stages_vecindad/T1/stage_red', -600, -150);
	setLuaSpriteScrollFactor('stage_red', 0.9, 0.9);
                 addLuaSprite('stage_red', false);
--stage2
	makeLuaSprite( 'vecindad_space', 'stages_vecindad/T1/vecindad_space', -600, -300);
	setLuaSpriteScrollFactor('vecindad_space', 0.9, 0.9);
                 addLuaSprite('vecindad_space', false);

	setProperty('vecindad_space.visible', false);
--stage3
	makeLuaSprite('stageback', 'stages_vecindad/T1/Vecindad_Lluviosa', -500, -300);
	setLuaSpriteScrollFactor('Vecindad_Lluviosa', 0.9, 0.9);

	

	-- sprites that only load if Low Quality is turned off
	--if not lowQuality then
	makeAnimatedLuaSprite('Vecindad_Lluviosa', 'stages_vecindad/T1/Vecindad_Lluviosa',-500, -300);
    setLuaSpriteScrollFactor('Vecindad_Lluviosa', 0.9, 0.9);		
	scaleObject('Vecindad_Lluviosa',0.85, 0.85);
	--end

	addLuaSprite('Vecindad_Lluviosa', false); 
	addAnimationByPrefix('Vecindad_Lluviosa', 'idle', 'Vecindad-Lluviosa', 15, true);
--stage4
	makeLuaSprite( 'stage_quico', 'stages_vecindad/T1/stage_quico', -600, -150);
	setLuaSpriteScrollFactor('stage_quico', 0.9, 0.9);
                 addLuaSprite('stage_quico', false);


end

function onEvent(name,value1,value2)
	if name == 'Play Animation' then 
		
		if value1 == '2' then
			setProperty('Vecindad_Lluviosa.visible', false);
			setProperty('stage_red.visible', false);
			setProperty('vecindad_space.visible', true);
			setProperty('stage_quico.visible', false);
		end

		if value1 == '3' then
			setProperty('Vecindad_Lluviosa.visible', true)
			setProperty('stage_red.visible', false);
			setProperty('vecindad_space.visible', false);
			setProperty('stage_quico.visible', false);
		end

		if value1 == '4' then
			setProperty('Vecindad_Lluviosa.visible', false);
			setProperty('stage_red.visible', true);
			setProperty('vecindad_space.visible', false);
			setProperty('stage_quico.visible', false);
		end
	
		if value1 == '1' then
			setProperty('vecindad_space.visible', false);
			setProperty('stage_red.visible', false);
			setProperty('stage_quico.visible', true);
			setProperty('Vecindad_Lluviosa.visible', false);
		end
	end
end