package;

import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import FunkinLua;

using StringTools;

class Cache extends MusicBeatState
{
    var toBeDone = 0;
    var done = 0;

    var text:FlxText;
    var chavologo:FlxSprite; 	
    var randomTxt:FlxText;

	var isTweening:Bool = false;
	var lastString:String = '';    

	override function create()
	{
        FlxG.mouse.visible = false;

        FlxG.worldBounds.set(0,0);

        text = new FlxText(FlxG.width / 2, FlxG.height / 2 + 70,0,"Loading...");
        text.size = 34;
        text.alignment = FlxTextAlign.CENTER;
        text.screenCenter(X);
        text.alpha = 0;

        chavologo = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image('logoMenu'));
        chavologo.x -= chavologo.width / 2;
        chavologo.y -= chavologo.height / 2 + 100;
        //text.y -= chavologo.height / 2 - 125;
        //text.x -= 170;
        chavologo.setGraphicSize(Std.int(chavologo.width * 0.3));

        chavologo.alpha = 0;

		randomTxt = new FlxText(20, FlxG.height - 80, 1000, "", 26);
		randomTxt.scrollFactor.set();
		randomTxt.setFormat(Paths.font("GROBOLD.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(randomTxt);              

        add(chavologo);
        add(text);

        trace('starting caching..');
        
        sys.thread.Thread.create(() -> {
            cache();
        });

        super.create();
    }

    var calledDone = false;
    var selectedSomethin:Bool = false;
	var timer:Float = 0;

    override function update(elapsed) 
    {

        if (toBeDone != 0 && done != toBeDone)
        {
            var alpha = CacheLoading.truncateFloat(done / toBeDone * 100,2) / 100;
            chavologo.alpha = alpha;
            text.alpha = alpha;
            text.text = "Loading... (" + done + "/" + toBeDone + ")";
        }
		if (!selectedSomethin){
			if (isTweening){
				randomTxt.screenCenter(X);
				timer = 0;
			}else{
				randomTxt.screenCenter(X);
				timer += elapsed;
				if (timer >= 3)
				{
					changeText();
				}
			}
		}
        super.update(elapsed);
    }

    function cache()
    {

        var images = [];
        var music = [];

        trace("caching images...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
        {
            if (!i.endsWith(".png"))
                continue;
            images.push(i);
        }

        trace("caching music...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
        {
            music.push(i);
        }

        toBeDone = Lambda.count(images) + Lambda.count(music);

        trace("LOADING: " + toBeDone + " OBJECTS.");

        for (i in images)
        {
            var replaced = i.replace(".png","");
            FlxG.bitmap.add(Paths.image("characters/" + replaced,"shared"));
            trace("cached " + replaced);
            done++;
        }

		for (i in music)
		{
			trace(i);
		}

        trace("Finished caching...");

        FlxG.switchState(new TitleState());
    }

	function changeText()
	{
		var selectedText:String = '';
		var textArray:Array<String> = CoolUtil.coolTextFile(Paths.txt('randomText'));

		randomTxt.alpha = 1;
		isTweening = true;
		selectedText = textArray[FlxG.random.int(0, (textArray.length - 1))].replace('--', '\n');
		FlxTween.tween(randomTxt, {alpha: 0}, 1, {
			ease: FlxEase.linear,
			onComplete: function(shit:FlxTween)
			{
				if (selectedText != lastString)
				{
					randomTxt.text = selectedText;
					lastString = selectedText;
				}
				else
				{
					selectedText = textArray[FlxG.random.int(0, (textArray.length - 1))].replace('--', '\n');
					randomTxt.text = selectedText;
				}

				randomTxt.alpha = 0;

				FlxTween.tween(randomTxt, {alpha: 1}, 1, {
					ease: FlxEase.linear,
					onComplete: function(shit:FlxTween)
					{
						isTweening = false;
					}
				});
			}
		});
	}    

}