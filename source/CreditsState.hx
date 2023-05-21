package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

typedef DataCredits = {

	var participant:Array<Array<Dynamic>>;
	var roles:Array<Array<Dynamic>>;

}
class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<FlxSprite>;

	var data:DataCredits;

	var bg:FlxSprite;
	var frameSelector:FlxSprite;
	var participants:FlxSprite;
	var boxText:FlxSprite;
	
	var name:FlxText;
	var rol:FlxText;
	var description:FlxText;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;

		FlxG.mouse.visible = true;

		bg = new FlxSprite();
		add(bg);
		
		grpOptions = new FlxTypedGroup<FlxSprite>();
		add(grpOptions);

		data = Json.parse(Paths.getTextFromFile('images/credits/Data.json'));

		for (i in 0...data.participant.length)
		{

			var icon:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/icons/'+ data.participant[i][0]));
			icon.antialiasing = ClientPrefs.globalAntialiasing;
			icon.setGraphicSize(102,102);
			icon.updateHitbox();
			icon.ID = i;

			if (i < 28)
			{
				icon.x = (17 + ((i * 110) % (7 * 110)));
				icon.y = 25 + (110 * Math.ffloor(i / 7));
			}
			else
			{
				icon.x = (55 + (((i - 1) * 110) % (6 * 110)));
				icon.y = 25 + (110 * (Math.ffloor((i - 4) / 6)));
			}

			grpOptions.add(icon);
		}
		
		participants = new FlxSprite(815,50);
		participants.antialiasing = ClientPrefs.globalAntialiasing;
		add(participants);

		name = new FlxText(774, 422, 450, 'name');
		name.setFormat(Paths.font("GROBOLD.ttf"), 0, FlxColor.WHITE);
		name.alignment = CENTER;
		add(name);

		rol = new FlxText(770, 478, 450, 'rol');
		rol.setFormat(Paths.font("GROBOLD.ttf"), 0);
		rol.alignment = CENTER;
		add(rol);

		description = new FlxText(774, 0, 450, 'description');
		description.setFormat(Paths.font("GROBOLD.ttf"), 0, FlxColor.WHITE);
		description.alignment = CENTER;
		add(description);

		boxText = new FlxSprite(744, 535).loadGraphic(Paths.image('credits/selectors/text_box'));
		boxText.setGraphicSize(500,110);
		boxText.updateHitbox();
		boxText.antialiasing = ClientPrefs.globalAntialiasing;
		boxText.blend = OVERLAY;
		add(boxText);

		frameSelector = new FlxSprite().loadGraphic(Paths.image('credits/selectors/select'));
		frameSelector.setGraphicSize(129,129);
		frameSelector.updateHitbox();
		frameSelector.antialiasing = ClientPrefs.globalAntialiasing;
		add(frameSelector);

		select();

		super.create();
	}

	var selecto:Int = -1;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.BACK || FlxG.mouse.pressedRight)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.mouse.visible = false;
			MusicBeatState.switchState(new MainMenuState());
		}

		grpOptions.forEach(function(spr:FlxSprite)
		{
			if (FlxG.mouse.overlaps(spr))
			{
				curSelected = spr.ID;

				if (selecto == -1){

				 selecto = spr.ID;
				 FlxG.sound.play(Paths.sound('scrollMenu'));
				 select();
				}

				else if (selecto != curSelected){
					selecto = -1;
				}

				if(FlxG.mouse.justPressed)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					CoolUtil.browserLoad(data.participant[curSelected][5]);
				}
			}
		});
		super.update(elapsed);
	}

	function select() {

		grpOptions.forEach(function(sprite:FlxSprite){
			if(sprite.ID == curSelected){
				sprite.alpha = 1;
				FlxTween.tween(frameSelector,{x:sprite.x- 14,y:sprite.y- 14}, 0.125);
			}
			else{
				sprite.alpha = 0.5;
			}
		});

		name.text = data.participant[curSelected][0];
		name.size = data.participant[curSelected][1];

		description.text = data.participant[curSelected][2];
		description.size = data.participant[curSelected][3];
		description.y = 590 - description.height/2;

		rol.text = data.roles[data.participant[curSelected][4]][0];
		rol.size = data.roles[data.participant[curSelected][4]][1];
		rol.color = FlxColor.fromRGB(
		data.roles[data.participant[curSelected][4]][2], 
		data.roles[data.participant[curSelected][4]][3], 
		data.roles[data.participant[curSelected][4]][4]);

		bg.loadGraphic(Paths.image('credits/roles_images/' + data.roles[data.participant[curSelected][4]][0]));
		bg.setGraphicSize(1280,720);
		bg.updateHitbox();

		participants.loadGraphic(Paths.image('credits/icons/' + data.participant[curSelected][0]));
		participants.setGraphicSize(360,360);
		participants.updateHitbox();

	}
}