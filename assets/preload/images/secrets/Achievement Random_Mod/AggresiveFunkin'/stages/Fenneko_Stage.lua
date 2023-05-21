function onCreate()
	-- background shit
	makeLuaSprite('FundoStage', 'FundoStage', -1600, -400);
	
	makeLuaSprite('Baguio com brilho1', 'Baguio com brilho1', 1540, 416);
	
	makeLuaSprite('Baguio com brilho2', 'Baguio com brilho2', 1800, 416);
	
	makeLuaSprite('Fio do vr', 'Fio do vr', 155, 815);
	
	makeLuaSprite('quarto brilho', 'quarto brilho', -1090, -340);
	--scaleObject('quarto brilho', 2, 2);
	setBlendMode('quarto brilho', 'Screen')
	
	makeLuaSprite('TransiçãoVR', 'TransiçãoVR', 447, -10);
	--scaleObject('TransiçãoVR', 2, 2);
	setBlendMode('TransiçãoVR', 'Lighten')

	addLuaSprite('FundoStage', false);
	addLuaSprite('Baguio com brilho2', true);
	addLuaSprite('Fio do vr', false);
	addLuaSprite('Baguio com brilho1', true);
	
	addLuaSprite('quarto brilho', true);	
	addLuaSprite('TransiçãoVR', true);
	
	makeLuaSprite('bartop','',0,0)
    makeGraphic('bartop',1280,60,'000000')
    addLuaSprite('bartop',true)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0,659)
    makeGraphic('barbot',1280,61,'000000')
    addLuaSprite('barbot',true)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
end