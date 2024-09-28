package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import sys.io.File;

class Main extends Sprite
{
	public static var fpsCounter:FPS;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState, 60, 60, toggleSplashScreen()));
	}

	function toggleSplashScreen():Bool // flip
	{
		if (File.getContent("systemContent/allowSplashScreen.txt") == "true")
		{
			return false;
		}
		else
		{
			return true;
		}
	}
}
