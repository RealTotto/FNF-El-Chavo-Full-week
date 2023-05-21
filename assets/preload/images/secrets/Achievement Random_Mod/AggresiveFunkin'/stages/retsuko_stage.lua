function onCreate()
	-- background shit
	makeLuaSprite('Ceu com cidades', 'Ceu com cidades', -600, -350);
	setScrollFactor('Ceu com cidades', 0.6, 0.6);
	scaleObject('Ceu com cidades', 0.7, 0.7);
	
	makeLuaSprite('Chao', 'Chao', -2260, 673);
	scaleObject('Chao', 1.18, 1);
	
	makeLuaSprite('Vrido', 'Vrido', -826, -267);
	
	makeLuaSprite('Brilho', 'Brilho', -2100, -2800);
	scaleObject('Brilho', 2, 2);
	setBlendMode('Brilho', 'Screen')

	addLuaSprite('Ceu com cidades', false);
	addLuaSprite('Chao', false);
	addLuaSprite('Vrido', false);
	
	addLuaSprite('Brilho', true);
	
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