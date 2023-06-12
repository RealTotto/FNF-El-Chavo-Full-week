package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import ColorblindFilters;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import PlayState;

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

import GameJolt;
import GameJolt.GameJoltAPI;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var osEngineVersion:String = '1.5.1'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay Locked',
		//'freeplay',
		//#if MODS_ALLOWED 'mods', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		//'donate',
		//'discord', you can go to discord now by pressing ctrl in credits
		//'instrumental', the instrumentalstate is in its beta version you can now use it by entering donate
		'options'
	];

	#if MODS_ALLOWED
	var customOption:String;
	var	customOptionLink:String;
	#end

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	var soundCooldown:Bool = true;
	var blockedBG:FlxSprite;
	var textBlocked:FlxText;
	var blockedsBG:FlxSprite;
	var textsBlocked:FlxText;

	var dateNow:String = Date.now().toString();
	var timeRar:FlxText;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();
		if (ClientPrefs.colorblindMode != null) ColorblindFilters.applyFiltersOnGame(); // applies colorbind filters, ok?	

		GameJoltAPI.connect();
        GameJoltAPI.authDaUser(FlxG.save.data.gjUser, FlxG.save.data.gjToken);		

		#if desktop
		// Updating Discord Rich Presence

		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];
		//camera.zoom = 1.85;

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;			

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
        bg.scrollFactor.set(0, yScroll);
        bg.setGraphicSize(Std.int(bg.width * 1.175));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

		var logoMenu:FlxSprite = new FlxSprite(0,-620).loadGraphic(Paths.image('logoMenu'));
		logoMenu.scrollFactor.set(0, 0);
		logoMenu.setGraphicSize(Std.int(logoMenu.width * 0.3));
		logoMenu.screenCenter(X);
		logoMenu.antialiasing = ClientPrefs.globalAntialiasing;
		logoMenu.angle = -8;
		add(logoMenu);

		new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				if	(logoMenu.angle == -8) 
					FlxTween.angle(logoMenu, logoMenu.angle, 8, 8, {ease: FlxEase.elasticOut});
				if (logoMenu.angle == 8) 
					FlxTween.angle(logoMenu, logoMenu.angle, -8, 8, {ease: FlxEase.elasticOut});
			}, 0);		

        if(ClientPrefs.themedmainmenubg == true) {

            var themedBg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
            themedBg.scrollFactor.set(0, yScroll);
            themedBg.setGraphicSize(Std.int(bg.width));
            themedBg.updateHitbox();
            themedBg.screenCenter();
            themedBg.antialiasing = ClientPrefs.globalAntialiasing;
            add(themedBg);			

            var hours:Int = Date.now().getHours();
            if(hours > 18) {
                themedBg.color = 0x545f8a; // 0x6939ff
            } else if(hours > 8) {
                themedBg.loadGraphic(Paths.image('menuBG'));
            }
        }		

        camFollow = new FlxObject(0, 0, 1, 1);
        camFollowPos = new FlxObject(0, 0, 1, 1);
        add(camFollow);
        add(camFollowPos);

        magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
        magenta.scrollFactor.set(0, yScroll);
        magenta.setGraphicSize(Std.int(magenta.width * 1.175));
        magenta.updateHitbox();
        magenta.screenCenter();
        magenta.visible = false;
        magenta.antialiasing = ClientPrefs.globalAntialiasing;
        magenta.color = 0xFFfd719b;
        add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.7;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		var curoffset:Float = 100;
		#if MODS_ALLOWED
		pushModMenuItemsToList(Paths.currentModDirectory);
		#end			

	    if(StoryMenuState.weekCompleted.get('Season2')){
			optionShit.insert(2,"freeplay");
			optionShit.remove("freeplay Locked");
			FlxG.save.data.weekCompleted = StoryMenuState.weekCompleted;
			FlxG.save.flush();			
		}		
		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			//menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " locked", 24);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.play('idle');			
			menuItem.ID = i;
			menuItem.x = -40;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.90));
			menuItem.updateHitbox();
			//curoffset = curoffset + 20;
			//switch (i)
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		timeRar = new FlxText(FlxG.width * 0.7, FlxG.height - 84, 0, "", 12);
		timeRar.scrollFactor.set();
		timeRar.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeRar.visible = false;
		timeRar.text = "Time:" + dateNow;
		add(timeRar);
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 64, 0, "Press CONTROL To View The Info");
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);	
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 44, 0, "OS Engine v" + osEngineVersion + " - Modded Psych Engine", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 24, 0, "FNF El Chavo' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);		

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end	

		textBlocked = new FlxText(0, 71, 0, "", 32);
		textBlocked.text = "Play Season Two To Unlock Freeplay";
		textBlocked.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
        textBlocked.scrollFactor.set();
		textBlocked.screenCenter(X);
		textBlocked.visible = false;

		blockedBG = new FlxSprite(textBlocked.x - 6, 66).makeGraphic(1, 42, 0xFF000000);
		blockedBG.scale.x = textBlocked.width + 6;
		blockedBG.x = (textBlocked.x + textBlocked.width) - (blockedBG.scale.x / 2);
		blockedBG.scrollFactor.set();
		blockedBG.alpha = 0.6;
		blockedBG.visible = false;
		add(blockedBG);		
		add(textBlocked);				

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		//changeItem();
		super.closeSubState();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModMenuItemsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var menuitemsFile:String = null;
		if(folder != null && folder.trim().length > 0) menuitemsFile = Paths.mods(folder + '/data/menuitems.txt');
		else menuitemsFile = Paths.mods('data/menuitems.txt');

		if (FileSystem.exists(menuitemsFile))
		{
			var firstarray:Array<String> = File.getContent(menuitemsFile).split('\n');
			if (firstarray[0].length > 0) {
				var arr:Array<String> = firstarray[0].split('||');
				//if(arr.length == 1) arr.push(folder);
				optionShit.push(arr[0]);
				customOption = arr[0];
				customOptionLink = arr[1];
			}
		}
		modsAdded.push(folder);
	}
	#end

	public function startSecretVideo(name:String)
	{
		#if VIDEOS_ALLOWED
		PlayState.inCutscene = true;

		var filepath:String = Paths.video(name);
		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			//PlayState.startAndEnd();
			return;
		}

		var video:MP4Handler = new MP4Handler();
		video.playVideo(filepath);
		video.finishCallback = function()
		{
			//PlayState.startAndEnd();
			return;
		}
		#else
		FlxG.log.warn('Platform not supported!');
		//PlayState.startAndEnd();
		return;
		#end
	}	


	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;
	var teclas:Float = 0;
	var keys:Float = 0;

	override function update(elapsed:Float)
	{
		if (!FlxG.save.data.disableKeysThree)
		{
			switch (teclas){

		case 0:
			if (FlxG.keys.justPressed.C)
				teclas += 1;
		case 0:
			if (FlxG.keys.justPressed.H)
				teclas += 1;
		case 0:
			if (FlxG.keys.justPressed.A)
				teclas += 1;						
		case 1:
			if (FlxG.keys.justPressed.V)
				teclas += 1;
		case 2:
			if (FlxG.keys.justPressed.O) {
				PlayState.isFreeplay = false;
				PlayState.SONG = Song.loadFromJson('vesania-hard', 'vesania');
				FlxG.save.data.songInsertRarThree = true;
				FlxG.save.data.disableKeysThree = true;
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				LoadingState.loadAndSwitchState(new PlayState());
				}
			}
		}	
		switch (keys){	
     case 0:
        if (FlxG.keys.justPressed.J)
            teclas += 1;
     case 1:
        if (FlxG.keys.justPressed.R) {
			startSecretVideo('bella riata profesor jirafales');		
       }
	}  
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			//if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		timeRar.text = "Time:" + dateNow;	

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if(FlxG.keys.justPressed.CONTROL)
			{
				timeRar.visible = true;
				if(optionShit[curSelected] == "freeplay Locked") {
					textBlocked.visible = true;	
					blockedBG.visible = true;
				}								
			}			

			if (controls.ACCEPT && optionShit[curSelected] != "freeplay Locked")
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));

				if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						/*
						FlxTween.tween(spr, {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
						*/
						FlxTween.tween(spr, {x: -500}, 2, {ease: FlxEase.backInOut, type: ONESHOT, onComplete: function(twn:FlxTween) {
							spr.kill();
						}});
					}
					else
					{
						FlxTween.tween(FlxG.camera, {zoom: 2.2}, 1.6,{ease:FlxEase.circInOut});						
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = optionShit[curSelected];

							switch (daChoice)
							{
								case 'story_mode':
                                    MusicBeatState.switchState(new StoryMenuState());															
								case 'freeplay':
									MusicBeatState.switchState(new FreeplaySelectState());
								case 'freeplay Locked':
									MusicBeatState.switchState(new FreeplayState());									
								#if MODS_ALLOWED
								case 'mods':
									MusicBeatState.switchState(new ModsMenuState()); 
								#end
								case 'awards':
									MusicBeatState.switchState(new AchievementsMenuState());
								case 'credits':
									MusicBeatState.switchState(new CreditsState());
								case 'donate':
									MusicBeatState.switchState(new InstrumentalState());									
								/*case 'instrumental':
									MusicBeatState.switchState(new InstrumentalState());*/										
								case 'options':
									LoadingState.loadAndSwitchState(new options.OptionsState());
							}
						});
					}
				});
			}

			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			var daChoice:String = optionShit[curSelected];
			spr.animation.play('idle');			
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{				
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				//spr.centerOffsets();
			}
		});
	}
}
