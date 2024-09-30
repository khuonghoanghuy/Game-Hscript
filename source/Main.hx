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
		addChild(new FlxGame(Std.parseInt(Paths.returnContent("systemContent/widthSc.txt")), Std.parseInt(Paths.returnContent("systemContent/heightSc.txt")),
			PlayState, 60, 60, toggleSplashScreen()));
		QuickChange.instance.resizeGame(Std.parseInt(Paths.returnContent("systemContent/widthSc.txt")),
			Std.parseInt(Paths.returnContent("systemContent/heightSc.txt")));
	}

	function toggleSplashScreen():Bool // flip
	{
		if (Paths.returnContent("systemContent/allowSplashScreen.txt") == "true")
		{
			return false;
		}
		else
		{
			return true;
		}
	}
}
