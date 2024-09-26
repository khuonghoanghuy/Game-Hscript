package;

import flixel.FlxBasic;
import flixel.text.FlxText;
import sys.io.File;
import vm.lua.Lua;
import vm.lua.State;

// im not sure is working tho?
class LuaScript extends FlxBasic
{
	public static var lua:Lua;

	public function new(file:String, ?execute:Bool = true)
	{
		super();
		lua.call("onCreate", [PlayState.instance.create]);
		lua.call("onUpdate", [PlayState.instance.update]);

		lua.setGlobalVar("makeText", function (tag:String, x:Float, y:Float, text:String){
			if (!PlayState.object.exists(tag)) {
				var text:FlxText = new FlxText(x, y, 0, text);
				text.active = true;
				PlayState.object.set(tag, text);
			}
		});
		lua.setGlobalVar("addObject", function (basic:String){
			return PlayState.instance.add(PlayState.object.get(basic));
		});

		if (execute)
			this.executeFile(file);

		lua.destroy();
	}

	function executeFile(file)
	{
		try
		{
			lua.run(File.getContent(file));
		}
		catch (e)
		{
			trace(e.message);
		}
	}
}
