package;

import flixel.FlxBasic;
import flixel.FlxState;

class PlayState extends FlxState
{
	static public var ayoScripts:Array<GameScript> = [];
	static public var instance:PlayState = null;

	public function new()
	{
		super();
		instance = this;
		callOnScripts("onNew", []);
	}

	override public function create()
	{
		Paths.getAllScripts("assets/data/");
		callOnScripts("onCreate", []);
		super.create();
		callOnScripts("onCreatePost", []);
		// Paths.getAllScripts("assets/data/");
	}

	override public function update(elapsed:Float)
	{
		callOnScripts("onUpdate", []);
		super.update(elapsed);
		callOnScripts("onUpdatePost", []);
	}

	override function destroy()
	{
		callOnScripts("onDestroy", []);
		super.destroy();
		ayoScripts = [];
	}

	// custom function
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
