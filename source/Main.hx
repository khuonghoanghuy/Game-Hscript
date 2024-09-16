package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var versionEngine:String = "v0.1.0";
	public static var fpsCounter:FPS;

	public function new()
	{
		super();
		fpsCounter = new FPS(1, 1, 0xffffff);
		
		addChild(new FlxGame(0, 0, PlayState));
	}
}
