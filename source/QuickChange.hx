package;

import flixel.FlxG;

class QuickChange
{
	public static var instance:QuickChange = null;

	public function new()
	{
		instance = this;
	}

	public function changeTitle(title:String)
		return FlxG.stage.window.title = title;

	public function changeDefaultFPSCapped(draw:Int = 60, update:Int = 60)
	{
		FlxG.drawFramerate = draw;
		FlxG.updateFramerate = update;
	}

	public function addFPSCounter()
		FlxG.stage.addChild(Main.fpsCounter);

	public function removeFPSCounter()
		FlxG.stage.removeChild(Main.fpsCounter);
}