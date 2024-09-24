#if cpp
package;

import flixel.FlxBasic;
import sys.io.File;
import vm.lua.Lua;

// im don't sure is working tho?
class LuaScript extends FlxBasic
{
	public static var lua:Lua;

	public function new(file:String, ?execute:Bool = true)
	{
		super();
		lua.setGlobalVar("game", PlayState.instance);

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
#end