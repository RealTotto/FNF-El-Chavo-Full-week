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

class MainCoversState extends MusicBeatState
{
	public static var osEngineVersion:String = '1.5.1'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		//'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		//'donate',
		//'discord', you can go to discord now by pressing ctrl in credits
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

	var itemTween:FlxTween;
	var itemFlicker:FlxFlicker;	

	//Character item
	var itemFreeplay:FlxSprite;
	var itemMods:FlxSprite;
	var itemAwards:FlxSprite;
	var itemCredits:FlxSprite;
	var itemOptions:FlxSprite;

	private static var curWeek:Int = 0;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isWeekSuicida = true;
		PlayState.isNotWeekSuicida = false;	
		PlayState.isStoryMode = false;
		PlayState.isFreeplay = false;

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
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('CoversDelOcho/menuBG'));
        bg.scrollFactor.set(0, yScroll);
        bg.setGraphicSize(Std.int(bg.width * 1.175));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        itemFreeplay = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/MainCharacters/freeplay'));
		itemFreeplay.scrollFactor.set();
		itemFreeplay.updateHitbox();
		itemFreeplay.antialiasing = ClientPrefs.globalAntialiasing;
		itemFreeplay.visible = false;
		add(itemFreeplay);

        itemMods = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/MainCharacters/mods'));
		itemMods.scrollFactor.set();
		itemMods.updateHitbox();
		itemMods.antialiasing = ClientPrefs.globalAntialiasing;
		itemMods.visible = false;
		add(itemMods);

        itemAwards = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/MainCharacters/awards'));
		itemAwards.scrollFactor.set();
		itemAwards.updateHitbox();
		itemAwards.antialiasing = ClientPrefs.globalAntialiasing;
		itemAwards.visible = false;
		add(itemAwards);	

        itemCredits = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/MainCharacters/credits'));
		itemCredits.scrollFactor.set();
		itemCredits.updateHitbox();
		itemCredits.antialiasing = ClientPrefs.globalAntialiasing;
		itemCredits.visible = false;
		add(itemCredits);

        itemOptions = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/MainCharacters/options'));
		itemOptions.scrollFactor.set();
		itemOptions.updateHitbox();
		itemOptions.antialiasing = ClientPrefs.globalAntialiasing;
		itemOptions.visible = false;
		add(itemOptions);					

        var Splash:FlxSprite = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/Splash'));
		Splash.scrollFactor.set();	
		Splash.antialiasing = ClientPrefs.globalAntialiasing;
		add(Splash);		

        if(ClientPrefs.themedmainmenubg == true) {

            var themedBg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('CoversDelOcho/menuDesat'));
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
                themedBg.loadGraphic(Paths.image('CoversDelOcho/menuBG'));
            }
        }	

        camFollow = new FlxObject(0, 0, 1, 1);
        camFollowPos = new FlxObject(0, 0, 1, 1);
        add(camFollow);
        add(camFollowPos);

        magenta = new FlxSprite(-80).loadGraphic(Paths.image('CoversDelOcho/menuDesat'));
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

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(curoffset, (i * 140) + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('CoversDelOcho/mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			//curoffset = curoffset + 20;
		}

		var notaTxt:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Nota'));
		notaTxt.scrollFactor.set(0, 0);
		notaTxt.antialiasing = ClientPrefs.globalAntialiasing;
		notaTxt.color = FlxColor.BLACK;
		notaTxt.updateHitbox();
        add(notaTxt);			

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 44, 0, "OS Engine v" + osEngineVersion + " - Modded Psych Engine", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(FlxG.width * 0.7, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
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

		super.create();

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


	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('CoversDelOcho/confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

    override function openSubState(SubState:FlxSubState)
	{
		persistentUpdate = false;
		if (itemTween != null)
			itemTween.active = false; 

		super.openSubState(SubState);	       
	}	
	
	override function closeSubState() {
		persistentUpdate = true;
		changeItem();
		super.closeSubState();
	}	

	override function update(elapsed:Float)
	{
		var selectedItem:String = optionShit[curSelected];

		switch(selectedItem)
		{
            case 'freeplay':
			    itemFreeplay.visible = true;
				itemMods.visible = false;
				itemAwards.visible = false;
                itemCredits.visible = false;
				itemOptions.visible = false;   
			case 'mods':
				itemMods.visible = true;
				itemFreeplay.visible = false;
				itemAwards.visible = false;
                itemCredits.visible = false;
				itemOptions.visible = false;  	
			case 'awards':
			    itemAwards.visible = true;
				itemFreeplay.visible = false;
				itemMods.visible = false;
                itemCredits.visible = false;
				itemOptions.visible = false;
			case 'credits':
			    itemCredits.visible = true;
				itemFreeplay.visible = false;
				itemMods.visible = false;
				itemAwards.visible = false;
				itemOptions.visible = false;
			case 'options':
			    itemOptions.visible = true;		
				itemFreeplay.visible = false;
				itemMods.visible = false;
				itemAwards.visible = false;
				itemCredits.visible = false;					      	 			    			 
		}
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			//if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('CoversDelOcho/scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('CoversDelOcho/scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				LoadingState.loadAndSwitchState(new TitleCoversState());
			}

			if(FlxG.keys.justPressed.CONTROL)
			{
				LoadingState.loadAndSwitchState(new codeocho.CategoryModsState());			
			}			

			if (controls.ACCEPT)
			{
				/*if (optionShit[curSelected] == 'story_mode') {	
				}*/										
				if (optionShit[curSelected] == 'donate') {
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				} else if (optionShit[curSelected] == customOption) {
					CoolUtil.browserLoad(customOptionLink);
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('CoversDelOcho/confirmMenu'));

					if(ClientPrefs.flashing) itemFlicker = FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{	
						persistentUpdate = false;				
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
							itemTween = FlxTween.tween(spr, {x: -500}, 2, {ease: FlxEase.backInOut, type: ONESHOT, onComplete: function(twn:FlxTween) {
								spr.kill();
							}});
						}
						else
						{
							/*
							FlxTween.tween(spr, {x: 500}, 1, {ease: FlxEase.backInOut, type: ONESHOT, onComplete: function(tween: FlxTween) {	no more tweenings
								var daChoice:String = optionShit[curSelected];


								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end			
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							}});
							*/
							itemFlicker = FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)

							{
									
								var daChoice:String = optionShit[curSelected];
								var selectedStory:Bool = false;						

								switch (daChoice)
								{
									/*case 'story_mode':
										MusicBeatState.switchState(new StorySuicidaState());*/																					
									case 'freeplay':
										MusicBeatState.switchState(new FreeplaySelectCoversState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState()); 
									#end
									#if ACHIEVEMENTS_ALLOWED
									case 'awards':
										MusicBeatState.switchState(new codeocho.AchievementsMenuState());
									#end										
									case 'credits':
										MusicBeatState.switchState(new codeocho.CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new codeocho.options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new codesuicida.editors.MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
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
			spr.animation.play('idle');
			//spr.updateHitbox();
			spr.scale.x = 0.7;
			spr.scale.y = 0.7;

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