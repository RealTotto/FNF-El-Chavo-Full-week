package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal.IFlxSignal;
import flixel.util.FlxTimer;
import lime.app.Application;
import lime.graphics.Image;

using StringTools;

#if desktop
import Discord.DiscordClient;
#end

class GameLoadState extends MusicBeatState
{
	var canPress:Bool = false;

	override function create()
	{
		if(ClientPrefs.doNotShowWarnings)
		{
			MusicBeatState.switchState(new MainMenuState());

			return;	
		}			

		super.create();

		FlxG.camera.alpha = 0;

		var warnText:FlxText = new FlxText(0, 850, FlxG.width, "Epilepsy Warning".toUpperCase(), 21);

		warnText.setFormat("VCR OSD Mono", 80, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(warnText);
		warnText.screenCenter();
		warnText.y -= 230;

		var warnText2:FlxText = new FlxText(0, 850, FlxG.width,
			"This mod can have violent lights or screen movements, if you are a photosensitive person it is recommended that you deactivate the lights or screen movements in the options. \n\n\n\nPress Enter to Continue",
			21);

		warnText2.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		warnText2.fieldWidth = 1100;

		add(warnText2);

		warnText2.screenCenter();
		warnText2.y += 80;

		FlxTween.tween(FlxG.camera, {alpha: 1}, 1, {
			onComplete: function(_:FlxTween)
			{
				canPress = true;
			}
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canPress && (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER))
		{
			canPress = false;

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {alpha: 0}, 1, {
				onComplete: function(_:FlxTween)
				{
					MusicBeatState.switchState(new MainMenuState());
				}
			});
		}
	}
}