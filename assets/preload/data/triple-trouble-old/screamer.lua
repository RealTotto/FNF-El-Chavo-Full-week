function onCreate()
    makeLuaSprite('screamerTails', 'jumpscare/Tails', 0, 0)
    setObjectCamera('screamerTails', 'other')
    setProperty('screamerTails.visible', false)
    addLuaSprite('screamerTails', true)

    makeLuaSprite('screamerKnuckles', 'jumpscare/Knuckles', 0, 0)
    setObjectCamera('screamerKnuckles', 'other')
    setProperty('screamerKnuckles.visible', false)
    addLuaSprite('screamerKnuckles', true)

    makeLuaSprite('screamerEggman', 'jumpscare/Eggman', 0, 0)
    setObjectCamera('screamerEggman', 'other')
    setProperty('screamerEggman.visible', false)
    addLuaSprite('screamerEggman', true)

    makeAnimatedLuaSprite('daSTAT', 'daSTAT', 0, 0)
    addAnimationByPrefix('daSTAT', 'STAT', 'staticFLASH', 24, true)
    scaleObject('daSTAT', 4, 4)
    setObjectCamera('daSTAT', 'other')
    setProperty('daSTAT.alpha', 0.3)
    setProperty('daSTAT.visible', false)
    addLuaSprite('daSTAT', true)
end

