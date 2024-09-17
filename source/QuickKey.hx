package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class QuickKey
{
	public static var instance:QuickKey = null;

	public function new()
	{
		instance = this;
	}

	public function press(key:FlxKey)
		return FlxG.keys.anyPressed([key]);

	public function justPressed(key:FlxKey)
		return FlxG.keys.anyJustPressed([key]);

	public function justReleased(key:FlxKey)
		return FlxG.keys.anyJustReleased([key]);

	public function anyPressed(key:Array<FlxKey>)
		return FlxG.keys.anyPressed(key);

	public function anyJustPressed(key:Array<FlxKey>)
		return FlxG.keys.anyJustPressed(key);

	public function anyJustRelease(key:Array<FlxKey>)
		return FlxG.keys.anyJustReleased(key);
}