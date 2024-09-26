package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import flixel.sound.FlxSound;

class PlayState extends FlxState
{
	static public var ayoScripts:Array<GameScript> = [];
	static public var instance:PlayState = null;

	public function new()
	{
		super();
		instance = this;
		Paths.getAllScripts();
		
		callOnScripts("onNew", []);
	}

	override public function create()
	{
		callOnScripts("onCreate", []);
		super.create();
		callOnScripts("onCreatePost", []);
	}

	override public function update(elapsed:Float)
	{
		callOnScripts("onUpdate", [elapsed]);
		super.update(elapsed);
		callOnScripts("onUpdatePost", [elapsed]);
	}

	override function destroy()
	{
		callOnScripts("onDestroy", []);
		super.destroy();
		ayoScripts = [];
	}

	// custom function
	public function playSound(name:String, outLoud:Float = 1, looped:Bool = false):FlxSound
	{
		return FlxG.sound.play(Paths.sounds(name), outLoud, looped);
	}

	public function playMusic(name:String, outLoud:Float = 1, looped:Bool = false)
	{
		return FlxG.sound.playMusic(Paths.music(name), outLoud, looped);
	}

	public function addMulti(basic:Array<FlxBasic>)
	{
		for (bsc in basic)
		{
			add(bsc);
		}
	}

	public function removeMulti(basic:Array<FlxBasic>)
	{
		for (bsc in basic)
		{
			remove(bsc);
		}
	}

	private function callOnScripts(funcName:String, args:Array<Dynamic>):Dynamic
	{
		var value:Dynamic = GameScript.Function_Continue;

		for (i in 0...ayoScripts.length)
		{
			final call:Dynamic = ayoScripts[i].executeFunc(funcName, args);
			final bool:Bool = call == GameScript.Function_Continue;
			if (!bool && call != null)
				value = call;
		}

		return value;
	}
}
