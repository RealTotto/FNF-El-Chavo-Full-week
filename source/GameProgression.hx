package;

import flixel.FlxG;

class GameProgression
{
	public static var weekProgress:Map<String, {song:String}> = [];

	public static function load()
	{
		if (FlxG.save.data.weekProgress != null)
		{
			weekProgress = FlxG.save.data.weekProgress;
		}
	}

	public static function save()
	{
		FlxG.save.data.weekProgress = weekProgress;

		FlxG.save.flush();
	}

	public static function reset()
	{
		weekProgress = [];

		save();
	}
}