package;

import flixel.FlxG;

class GameProgression
{
	public static var weekProgress:Map<String, {song:String, curDeaths:Int}> = [];
	public static var storyProgress:Map<String, {song:String, curDeaths:Int, Misses:Int}> = [];

	public static function load()
	{
		if (FlxG.save.data.weekProgress != null)
		{
			weekProgress = FlxG.save.data.weekProgress;
		}	
		if (FlxG.save.data.storyProgress != null)
		{
			storyProgress = FlxG.save.data.storyProgress;
		}				
	}

	public static function save()
	{
		FlxG.save.data.weekProgress = weekProgress;	

		FlxG.save.data.storyProgress = storyProgress;

		FlxG.save.flush();
	}

	public static function reset()
	{
		weekProgress = [];

		storyProgress = [];

		save();
	}
}