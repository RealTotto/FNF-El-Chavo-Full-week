local allowCountdown = false

local SecondColor = '0xFF00969F' -- Color of The Selector and text
local Color = '0xFF800809'-- Color of the Background

--  You Can Change The Sounds If you don't Want to get Sued By Nintendo.

local WarningSound = 'SwitchSounds/error'
local ConfirmSound = 'SwitchSounds/popup+runtitle'
local BackOutSound = 'SwitchSounds/standby'
local SelectSound = 'SwitchSounds/thisone'
local AutoSelectSound = 'SwitchSounds/turnon'
local BorderHit = 'SwitchSounds/border'
local MessageStateMusic = ''

local WarningMessage = 'This song contains copyright, do you want to continue?'
local ConfirmText = 'Start Song'
local ExitText = 'Exit Song'


function onStartCountdown()
	if not allowCountdown and not seenCutscene then
        ContolsEnabled = false
        runTimer('RedScreen',1)
        doTweenAlpha('cam1','camHUD',0,0.1,'linear')
        makeLuaSprite('RedThing','',0,0)
        makeGraphic('RedThing',1280,720,Color)
        setObjectCamera('RedThing','camOther')
        addLuaSprite('RedThing')
        doTweenAlpha('RedAlpha1','RedThing',0,0.1,'linear')
        --makeLuaSprite('Thingy','Vignette',0,0) -- You can Add a Vignette Overlay Here.
        setObjectCamera('Thingy','camOther')
        addLuaSprite('Thingy',true)
        doTweenAlpha('Black','Thingy',0,0.001,'linear')
        makeLuaSprite('OptionBox2BG','',497,1592)
        makeGraphic('OptionBox2BG',300,45,'000000')
        setProperty('OptionBox2BG.alpha',0.8)
        addLuaSprite('OptionBox2BG')
        setObjectCamera('OptionBox2BG','camOther')
        makeLuaSprite('OptionBox1BG','',497,1492)
        makeGraphic('OptionBox1BG',300,45,'000000')
        setProperty('OptionBox1BG.alpha',0.8)
        addLuaSprite('OptionBox1BG')
        setObjectCamera('OptionBox1BG','camOther')
        makeLuaSprite('OptionBoxLB','',492,1490)
        makeGraphic('OptionBoxLB',5,50,SecondColor)
        setProperty('OptionBoxLB.alpha',0.8)
        addLuaSprite('OptionBoxLB')
        setObjectCamera('OptionBoxLB','camOther')
        makeLuaSprite('OptionBoxRB','',791,1490)
        makeGraphic('OptionBoxRB',6,50,SecondColor)
        setProperty('OptionBoxRB.alpha',0.8)
        addLuaSprite('OptionBoxRB')
        setObjectCamera('OptionBoxRB','camOther')
        makeLuaSprite('OptionBoxTB','',497,1490)
        makeGraphic('OptionBoxTB',294,5,SecondColor)
        setProperty('OptionBoxTB.alpha',0.8)
        addLuaSprite('OptionBoxTB')
        setObjectCamera('OptionBoxTB','camOther')
        makeLuaSprite('OptionBoxBB','',497,1535)
        makeGraphic('OptionBoxBB',294,5,SecondColor)
        setProperty('OptionBoxBB.alpha',0.8)
        addLuaSprite('OptionBoxBB')
        setObjectCamera('OptionBoxBB','camOther')
        doTweenAlpha('FBdAas','OptionBox1BG',0,01.5,'linear')
        doTweenAlpha('FBdasA','OptionBox2BG',0,01.5,'linear')
        doTweenAlpha('FBasasasdA','OptionBoxLB',0,0.001,'linear')
        doTweenAlpha('FBasasadA','OptionBoxRB',0,0.001,'linear')
        doTweenAlpha('FBdasasA','OptionBoxBB',0,0.001,'linear')
        doTweenAlpha('TopBorderAlpha','OptionBoxTB',0,0.001,'linear')

        makeLuaText('FirstBody','WARNING: '..WarningMessage,800,250,300) -- Texts Are Here.
        makeLuaText('Confirm',ConfirmText,300,500,700)
        makeLuaText('EsC',ExitText,300,500,900)
        
        setTextSize('FirstBody',30)
        setTextSize('Confirm',20)
        setTextSize('EsC',20)
        addLuaText('FirstBody')
        addLuaText('Confirm')
        addLuaText('EsC')
        setObjectCamera('FirstBody','camOther')
        setObjectCamera('Confirm','camOther')
        setObjectCamera('EsC','camOther')
        doTweenAlpha('FBA','FirstBody',0,0.001,'linear')
        doTweenAlpha('CA','Confirm',0,0.001,'linear')
        doTweenAlpha('ESCA','EsC',0,0.001,'linear')

		return Function_Stop
	end
	return Function_Continue
end
function onCountdownTick(counter)
    if counter == 0 then
        doTweenAlpha('cam1','camHUD',1,0.5,'linear')
    end
end
function onUpdate(elapsed)
    MessageStateMusicVolume = 0.3

	if not allowCountdown and (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER')) and ContolsEnabled == true and not startedCountdown then
        if ExitButton == true then 
            doTweenAlpha('Darkness','camOther',0,0.1,'linear')
            doTweenAlpha('Like','camHUD',0,0.1,'linear')
            doTweenAlpha('Soul','camGame',0,0.1,'linear')
            ContolsEnabled = false
            playSound(BackOutSound)
            endSong()
        end
        if StartButton == true then 
            ContolsEnabled = false
            allowCountdown = true 
            playSound(ConfirmSound)
            cameraFlash('camOther','0xffffff', 1, true)
            runTimer('Confirm',0.5)    
            runTimer('Start',0.7)
        end
	end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and ContolsEnabled == true then
        StartButton = true
        ExitButton = false
        if not startedCountdown then
            playSound(SelectSound,1)
            setTextColor('Confirm',SecondColor)
            setTextColor('EsC','0xffffff')
            doTweenAlpha('FBasasasdA','OptionBoxLB',1,0.1,'linear')
            doTweenAlpha('FBasasadA','OptionBoxRB',1,0.1,'linear')
            doTweenAlpha('FBdasasA','OptionBoxBB',1,0.1,'linear')
            doTweenAlpha('TopBorderAlpha','OptionBoxTB',1,0.1,'linear')
            doTweenY('SlectorLB','OptionBoxLB',490,0.1,'quartInOut')
            doTweenY('SlectorRB','OptionBoxRB',490,0.1,'quartInOut')
            doTweenY('SlectorTB','OptionBoxTB',490,0.1,'quartInOut')
            doTweenY('SlectorBB','OptionBoxBB',535,0.1,'quartInOut')

        end
    end
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and ContolsEnabled == true then
        StartButton = false
        ExitButton = true
        if not startedCountdown then
            playSound(SelectSound,1)
            setTextColor('EsC',SecondColor)
            setTextColor('Confirm','0xffffff')
            doTweenAlpha('FBasasasdA','OptionBoxLB',1,0.1,'linear')
            doTweenAlpha('FBasasadA','OptionBoxRB',1,0.1,'linear')
            doTweenAlpha('FBdasasA','OptionBoxBB',1,0.1,'linear')
            doTweenAlpha('TopBorderAlpha','OptionBoxTB',1,0.1,'linear')
            doTweenY('SlectorLB','OptionBoxLB',590,0.1,'quartInOut')
            doTweenY('SlectorRB','OptionBoxRB',590,0.1,'quartInOut')
            doTweenY('SlectorTB','OptionBoxTB',590,0.1,'quartInOut')
            doTweenY('SlectorBB','OptionBoxBB',635,0.1,'quartInOut')    
        end
    end
end

function onTimerCompleted(name)
    if name == 'RedScreen' then 
        doTweenAlpha('RedAlpha1','RedThing',0.7,1,'quartInOut')
        doTweenAlpha('Black','Thingy',1,1,'quartInOut')
        runTimer('Sound',0.3)
        runTimer('Music',0.5)
        runTimer('AutoSelect',3)
        runTimer('Text',1)
    end
    if name =='Sound' then 
        playSound(WarningSound,1)
    end
    if name =='Music' then 
        playMusic(MessageStateMusic,MessageStateMusicVolume)
    end
    if name == 'Text' then 
        doTweenY('Sus1','FirstBody',100,1,'quartInOut')
        doTweenY('Sus2','Confirm',500,1,'quartInOut')
        doTweenY('Sus3','EsC',600,1,'quartInOut')
        doTweenY('Sus4','OptionBox1BG',492,0.8,'quartInOut')
        doTweenY('Sus5','OptionBox2BG',592,1,'quartInOut')
        doTweenY('BL','OptionBoxLB',490,1,'quartInOut')
        doTweenY('BT','OptionBoxTB',490,1,'quartInOut')
        doTweenY('BR','OptionBoxRB',490,1,'quartInOut')
        doTweenY('BB','OptionBoxBB',535,1,'quartInOut')
        doTweenAlpha('FBdAas','OptionBox1BG',0.7,1.5,'linear')
        doTweenAlpha('FBdasA','OptionBox2BG',0.7,1.5,'linear')
        doTweenAlpha('FBdA','FirstBody',1,1.5,'linear')
        doTweenAlpha('CAd','Confirm',1,1.5,'linear')
        doTweenAlpha('ESdCA','EsC',1,1.5,'linear')
    end
    if name == 'AutoSelect' then 
        playSound(AutoSelectSound,1)

        StartButton = false
        ExitButton = true
        ContolsEnabled = true 

        setTextColor('EsC',SecondColor)
        setTextColor('Confirm','0xffffff')

        doTweenAlpha('FBasasasdA','OptionBoxLB',1,0.1,'linear')
        doTweenAlpha('FBasasadA','OptionBoxRB',1,0.1,'linear')
        doTweenAlpha('FBdasasA','OptionBoxBB',1,0.1,'linear')
        doTweenAlpha('TopBorderAlpha','OptionBoxTB',1,0.1,'linear')

        doTweenY('SlectorLB','OptionBoxLB',590,0.01,'quartInOut')
        doTweenY('SlectorRB','OptionBoxRB',590,0.01,'quartInOut')
        doTweenY('SlectorTB','OptionBoxTB',590,0.01,'quartInOut')
        doTweenY('SlectorBB','OptionBoxBB',635,0.01,'quartInOut')
    end
    if name == 'Confirm' then 
        doTweenAlpha('RedAlpha1','RedThing',0,1,'linear')
        doTweenAlpha('Black','Thingy',0,1,'linear')
        doTweenAlpha('FBdA','FirstBody',0,1,'linear')
        doTweenAlpha('CAd','Confirm',0,1,'linear')
        doTweenAlpha('ESdCA','EsC',0,1,'linear')
        doTweenAlpha('FBdAas','OptionBox1BG',0,1,'linear')
        doTweenAlpha('FBdasA','OptionBox2BG',0,1,'linear')
        doTweenAlpha('FBasasasdA','OptionBoxLB',0,1,'linear')
        doTweenAlpha('FBasasadA','OptionBoxRB',0,1,'linear')
        doTweenAlpha('FBdasasA','OptionBoxBB',0,1,'linear')
        doTweenAlpha('TopBorderAlpha','OptionBoxTB',0,1,'linear')
    end
    if name == 'Start' then
        startCountdown()
    end
end
function onSongStart()
    removeLuaSprite('RedThing')
    removeLuaSprite('Thingy')
    removeLuaSprite('OptionBox1BG')
    removeLuaSprite('OptionBox2BG')
    removeLuaSprite('OptionBoxLB')
    removeLuaSprite('OptionBoxTB')
    removeLuaSprite('OptionBoxBB')
    removeLuaSprite('OptionBoxRB')
    removeLuaText('FirstBody')
    removeLuaText('Confirm')
    removeLuaText('EsC')
    removeLuaScript('assets/data/We-Come-And-We-Go/alvertencia')
end

function onCreate()
	setProperty('boyfriendGroup.visible', false);
	setProperty('gfGroup.visible', false);
	
	noteTweenX('byearrows1', 0, -200, 0.01, 'linear')
        noteTweenX('byearrows2', 1, -200, 0.01, 'linear')
        noteTweenX('byearrows3', 2, -200, 0.01, 'linear')
        noteTweenX('byearrows4', 3, -200, 0.01, 'linear')
	noteTweenX('middletime1', 4, 414, 0.01, 'linear')
        noteTweenX('middletime2', 5, 527, 0.01, 'linear')
        noteTweenX('middletime3', 6, 637, 0.01, 'linear')
        noteTweenX('middletime4', 7, 750, 0.01, 'linear')
end

