package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class QuickKey
{
	public static var instance:QuickKey = null;

	public function new()
	{
		instance = this;
		ListKey.initKey();
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
class ListKey
{
	public static var keyMap:Map<String, FlxKey> = [];

	public static function initKey()
	{
		// alphabet
		setKey("A", A);
		setKey("B", B);
		setKey("C", C);
		setKey("D", D);
		setKey("E", E);
		setKey("F", F);

		// number

		// fkey
		setKey("F1", F1);

		// speical key

		trace(keyMap.toString());
	}

	public static function setKey(key:String, keyCode:FlxKey)
	{
		return keyMap.set(key, keyCode);
	}

	public static function getKey(key:String)
	{
		return keyMap.get(key);
	}
}