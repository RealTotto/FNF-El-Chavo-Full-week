function onCreate()

if not lowQuality then

makeLuaSprite('black', '', 0, 0);

makeGraphic('black', 2500, 2500, '000000');

setObjectCamera('videoSprite', 'game');

setObjectOrder('black', 99999);

screenCenter('black');

addLuaSprite('black', true);


	setProperty('skipCountdown', true)

	makeLuaSprite('videoSprite','',0,0)
	addLuaSprite('videoSprite')

	addHaxeLibrary('MP4Handler','vlc')
	addHaxeLibrary('Event','openfl.events')

	runHaxeCode([[
		var filepath = Paths.video('Poison Power');		
		var video = new MP4Handler();
		video.playVideo(filepath);
		video.visible = false;
		setVar('video',video);
		FlxG.stage.removeEventListener('enterFrame', video.update); 
	]])
end
end

function onUpdatePost()
if not lowQuality then
	triggerEvent('Camera Follow Pos', '640', '360')

	runHaxeCode([[
		var video = getVar('video');
		game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
		video.volume = FlxG.sound.volume + 100;	
		if(game.paused)video.pause();
	]])
end
end


function onResume()
if not lowQuality then
	runHaxeCode([[
		var video = getVar('video');
		video.resume();
	]])
end
end
function onCreatePost()
if not lowQuality then
	getObjectOrder('videoSprite')
	setObjectOrder('videoSprite', 100000)
end
end

function onUpdate(elapsed)
if not lowQuality then
	triggerEvent('Camera Follow Pos', '640', '360')
end
end




function onUpdatePost()
if not lowQuality then
	triggerEvent('Camera Follow Pos', '640', '360')

	runHaxeCode([[
		var video = getVar('video');
		game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
		video.volume = FlxG.sound.volume + 100;	
		if(game.paused)video.pause();
	]])
end
end

