package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;

class FreeplaySelectState extends MusicBeatState
{
    var freeplayCats:Array<String> = ['StoryMode', 'Extras'];
	var grpCats:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;
	var BG:FlxSprite;
    override function create(){
        BG = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		BG.updateHitbox();
		BG.screenCenter();
		add(BG);
        grpCats = new FlxTypedGroup<Alphabet>();
		add(grpCats);
        for (i in 0...freeplayCats.length)
        {
			var catsText:Alphabet = new Alphabet(0, (70 * i) + 30, freeplayCats[i], true, false);
            catsText.targetY = i;
			catsText.screenCenter(X);
			catsText.forceX = catsText.x;
            catsText.isMenuItem = true;
			grpCats.add(catsText);
		}
        changeSelection();
        super.create();
    }

	var selectedSomethin:Bool = false;

    override public function update(elapsed:Float){
		if (!selectedSomethin)
		{        
			if (controls.UI_UP_P) 
				changeSelection(-1);
			if (controls.UI_DOWN_P) 
				changeSelection(1);
			if (controls.BACK) {
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
			if (controls.ACCEPT){
				selectedSomethin = true;
				switch(curSelected){
					case 0:
					MusicBeatState.switchState(new FreeplayState());
					case 1:
					MusicBeatState.switchState(new FreeplayCategory2State());
				}
			}
			super.update(elapsed);
		}	
    }

    function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = freeplayCats.length - 1;
		if (curSelected >= freeplayCats.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpCats.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}