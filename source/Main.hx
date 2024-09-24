package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var versionEngine:String = #if !hl "v" + FlxG.stage.application.meta.get("version") #else "v0.1.1" #end;
	public static var fpsCounter:FPS;

	public function new()
	{
		super();
		fpsCounter = new FPS(1, 1, 0xffffff);
		trace("Game-Hscript " + versionEngine);
		addChild(new FlxGame(0, 0, PlayState, 60, 60, true));
	}
}
