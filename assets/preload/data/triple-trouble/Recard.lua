local hamCake = 3

function onUpdate()
health = getProperty('health')
if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.X') then
   if hamCake > 0 then
hamCake = hamCake - 1
setProperty('health', health+ 0.8);
runTimer('restock', 25);
      end
   end 
end

function onCreate()
	makeLuaSprite('item', 'hamCake', 1150, 400)
	addLuaSprite('item', true)
	scaleObject('item', 0.5, 0.5)
                   setObjectCamera("item", "hud")

    makeLuaText("uses",hamCake, 800, 475, screenHeight - 300) 
	
    setTextSize("uses", 80)
    setTextAlignment("uses", "right")
    setObjectCamera("uses", "hud")
    addLuaText("uses")
	
    makeLuaText("control","x", 700, 475, screenHeight - 300) 
	
    setTextSize("control", 40)
    setTextAlignment("control", "right")
    setObjectCamera("control", "hud")
    addLuaText("control")
end

function onUpdatePost()
setTextString("uses",hamCake)
end

function onTimerCompleted(tag, l, ll)
if tag == 'restock' then
hamCake = hamCake + 1
end
end

function onSongStart()
	setProperty('Phase3Static.visible', true)
end