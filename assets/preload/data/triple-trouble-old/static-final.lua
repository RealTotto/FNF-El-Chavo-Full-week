function onUpdate(elapsed)
    if getProperty('static.animation.curAnim.finished') and getProperty('static.animation.curAnim.name') == 'flash' then
        setProperty('static.alpha', 0)
    else
        setProperty('static.alpha', 0.7)
    end
end


