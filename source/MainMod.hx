package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class MainMod extends MusicBeatState
{
	var loadingRar:FlxSprite;

	override function create()
	{
        if (ClientPrefs.mainMod == "El Chavo Del 8"){
            MusicBeatState.switchState(new GameLoadState());

            return;
        }	

			if (ClientPrefs.mainMod == "Vs El Chavo Suicida"){

			var loadingRar = new FlxSprite().loadGraphic(Paths.image('loadingMod'));
			loadingRar.screenCenter();
			loadingRar.angle = -360;
			add(loadingRar);

        new FlxTimer().start(0.7, function(tmr:FlxTimer)
		    { 
				if	(loadingRar.angle == 360) 
					FlxTween.angle(loadingRar, loadingRar.angle, 360, 1, {ease: FlxEase.linear});
				if (loadingRar.angle == -360) 
					FlxTween.angle(loadingRar, loadingRar.angle, -360, 1, {ease: FlxEase.linear});	
			}, 0);						

			var warnText2:FlxText = new FlxText(0, 850, FlxG.width,
				"Reloading Resources",
				21);	

			warnText2.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			warnText2.fieldWidth = 1100;

			add(warnText2);

			warnText2.screenCenter();
			warnText2.y += 80;					

        }			
		super.create(); 
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxTween.tween(FlxG.camera, {alpha: 1}, 7, {
			onComplete: function(_:FlxTween)
			{
				MusicBeatState.switchState(new TitleSuicidaState());
			}
		});
	}		 
}

