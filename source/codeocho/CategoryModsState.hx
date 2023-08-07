package codeocho;

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
import lime.graphics.Image;
import openfl.Lib;
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
import flixel.input.keyboard.FlxKey;
import codesuicida.MainTitle;

class CategoryModsState extends MusicBeatState
{
    var bg:FlxSprite;
	var logoSuicida:FlxSprite;
	var elChavo:FlxSprite;
	var coversDelOcho:FlxSprite;
	private var curSelected = 0;
	var leText:Alphabet;
	private var grpTexts:FlxTypedGroup<Alphabet>;
	var mods:Array<String> = [
		'El Chavo',
		'Vs Suicida',
		'Covers Del Ocho'
	];	

    override function create()	
	{	
		bg = new FlxSprite().loadGraphic(Paths.image('CoversDelOcho/menuDesat'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();	

		grpTexts = new FlxTypedGroup<Alphabet>();
		add(grpTexts);		

		for (i in 0...mods.length)
		{
			var leText:Alphabet = new Alphabet(0, (70 * i) + 30, mods[i], true, false);
			leText.isMenuItem = true;
			leText.targetY = i;
			grpTexts.add(leText);
		}	

		elChavo = new FlxSprite(1300, 140);
		elChavo.frames = Paths.getSparrowAtlas('logoBumpin');

		elChavo.setGraphicSize(Std.int(elChavo.width * 0.7));
		elChavo.antialiasing = ClientPrefs.globalAntialiasing;
		elChavo.animation.addByPrefix('bump', 'logo bumpin', 14, false);
	    elChavo.animation.play('bump');
		elChavo.updateHitbox();	
		elChavo.scrollFactor.set();
		add(elChavo);		

		logoSuicida = new FlxSprite(1300, 140);
		logoSuicida.frames = Paths.getSparrowAtlas('VsSuicida/LogoBumpin');

		logoSuicida.setGraphicSize(Std.int(logoSuicida.width * 0.7));
		logoSuicida.antialiasing = ClientPrefs.globalAntialiasing;
		logoSuicida.animation.addByPrefix('bump', 'logo bumpin', 14, false);
		logoSuicida.animation.play('bump');
		logoSuicida.updateHitbox();	
		logoSuicida.scrollFactor.set();
		add(logoSuicida);

		coversDelOcho = new FlxSprite(1300, 140);
		coversDelOcho.frames = Paths.getSparrowAtlas('CoversDelOcho/logoBumpin');

        coversDelOcho.setGraphicSize(Std.int(coversDelOcho.width * 0.7));
		coversDelOcho.antialiasing = ClientPrefs.globalAntialiasing;
		coversDelOcho.animation.addByPrefix('bump', 'logo bumpin', 14, false);
		coversDelOcho.animation.play('bump');
		coversDelOcho.updateHitbox();	
		coversDelOcho.scrollFactor.set();
		add(coversDelOcho);								

        changeSelection();			

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
        if (!selectedSomethin)
		{		
			var Select:String = mods[curSelected];
			switch (Select)
			{
				case 'El Chavo':
					bg.color = 0xFF008000;
					elChavo.visible = true;
					logoSuicida.visible = false;
					coversDelOcho.visible = false;

					FlxTween.tween(elChavo, {x: 600}, 0.7, {ease:FlxEase.circInOut});
					FlxTween.tween(logoSuicida, {x: 1300}, 0.5, {ease:FlxEase.circInOut});	
					FlxTween.tween(coversDelOcho, {x: 1300}, 0.5, {ease:FlxEase.circInOut});		
				case 'Vs Suicida':
					bg.color = 0xFF808080;	
					logoSuicida.visible = true;
					elChavo.visible = false;
					coversDelOcho.visible = false;

					FlxTween.tween(logoSuicida, {x: 600}, 0.7, {ease:FlxEase.circInOut});
					FlxTween.tween(elChavo, {x: 1300}, 0.5, {ease:FlxEase.circInOut});
					FlxTween.tween(coversDelOcho, {x: 1300}, 0.5, {ease:FlxEase.circInOut});
				case 'Covers Del Ocho':	
					bg.color = 0xFFFFFF00;	
					coversDelOcho.visible = true;
					logoSuicida.visible = false;
					elChavo.visible = false;

                    FlxTween.tween(coversDelOcho, {x: 600}, 0.5, {ease:FlxEase.circInOut});
					FlxTween.tween(logoSuicida, {x: 1300}, 0.7, {ease:FlxEase.circInOut});
					FlxTween.tween(elChavo, {x: 1300}, 0.5, {ease:FlxEase.circInOut});				
			}

			if (controls.UI_UP_P)
			{
				changeSelection(-1);
			}
			if (controls.UI_DOWN_P)
			{
				changeSelection(1);
			}

			if(controls.ACCEPT)
			{
				persistentUpdate = false;
				switch (Select)
				{
					case 'El Chavo':
						MusicBeatState.switchState(new TitleState());
						Lib.application.window.title = "Friday Night Funkin': El Chavo";
						Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("iconOG").bitmap));					
					case 'Vs Suicida':
						MusicBeatState.switchState(new codesuicida.MainTitle());
						Lib.application.window.title = "Friday Night Funkin': Vs El Chavo Suicida";
						Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("VsSuicida/IconSuicida").bitmap));	
					case 'Covers Del Ocho':	
						MusicBeatState.switchState(new TitleCoversState());
						Lib.application.window.title = "Friday Night Funkin': Covers Del Ocho";
						Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("iconOG").bitmap));									
				}
			}
			if (controls.BACK)
			{
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainCoversState());
			}

			var bullShit:Int = 0;
			for (item in grpTexts.members)
			{
				item.targetY = bullShit - curSelected;
				bullShit++;

				item.alpha = 0.6;
				// item.setGraphicSize(Std.int(item.width * 0.8));

				if (item.targetY == 0)
				{
					item.alpha = 1;
					// item.setGraphicSize(Std.int(item.width));
				}
			}									
			super.update(elapsed);	
		}				
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('CoversDelOcho/scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = mods.length - 1;
		if (curSelected >= mods.length)
			curSelected = 0;
	}	
}