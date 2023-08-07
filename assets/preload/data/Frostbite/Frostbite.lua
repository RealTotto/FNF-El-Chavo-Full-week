
function onUpdatePost(elapsed)
    setProperty('iconP2.x',XoffsetP2)
    setProperty('iconP1.x',XoffsetP1) 
end
function onUpdate(elapsed)
    healthBarPercent = getProperty('healthBar.percent')
    XoffsetP2=healthBarX+(healthBarWidth*healthBarPercent*0.01)+(150 *getProperty('iconP1.scale.x') - 150) / 2 - 26
    XoffsetP1=healthBarX+(healthBarWidth*healthBarPercent*0.01)-(150 *getProperty('iconP2.scale.x')) / 2 - 26* 2
    setProperty('iconP2.x',XoffsetP2)
    setProperty('iconP1.x',XoffsetP1) 
end
function onCreate()
    setProperty('skipCountdown',true)
    addHaxeLibrary('Application', 'lime.app')
    setProperty('healthBar.flipX',true)
    healthBarWidth= getProperty('healthBar.width')
    setProperty('iconP1.flipX',true)
    setProperty('iconP2.flipX',true)
    healthBarX = getProperty('healthBar.x')
    IconP1ScaleX = getProperty('iconP1.scale.x')
end