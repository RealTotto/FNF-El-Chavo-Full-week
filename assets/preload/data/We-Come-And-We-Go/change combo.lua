function onCreate()
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('camGame.visible', false)

    ogHud = getPropertyFromClass('PlayState', 'showCombo')
    setPropertyFromClass('PlayState', 'showCombo', true)
end

function onDestroy()
    setPropertyFromClass('PlayState', 'showCombo', ogHud)    
end

function onUpdate()
        setProperty('combo.visible', false)
end

