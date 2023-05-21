function onCreate()
    makeAnimatedLuaSprite('static', 'exep3/Phase3Static', 0, 0)
    addAnimationByPrefix('static', 'flash', 'Phase3Static instance 1', 24, false)
    setGraphicSize('static', getProperty('static.width') * 4)
    setProperty('static.alpha', 0.3)
    setProperty('static.visible', false)
    addLuaSprite('static', true)
    setObjectCamera('static', 'other')
end

function onSongStart()
	setProperty('static.visible', true)
end
