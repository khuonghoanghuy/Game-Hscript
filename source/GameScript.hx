package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import openfl.Assets;
import tea.SScript;

class GameScript extends SScript {
	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

	var file:String;
    
    public function new(file:String) {
        super(file, false, false);
		this.file = file;
		parser.allowTypes = parser.allowJSON = true;
		presentAllVariable();
	}

	function presentAllVariable()
	{
		initVariable("FlxG", FlxG);
		initVariable("FlxSprite", FlxSprite);
		initVariable("FlxText", FlxText);
		initVariable("FlxMath", FlxMath);
		initVariable("FlxCamera", FlxCamera);

		initVariable("add", FlxG.state.add);
		initVariable("remove", FlxG.state.remove);
		initVariable("addMulti", PlayState.instance.addMulti);
		initVariable("removeMulti", PlayState.instance.removeMulti);
		initVariable("game", PlayState.instance);
		initVariable("change", QuickChange.instance);

		initVariable("Function_Continue", Function_Continue);
		initVariable("Function_Stop", Function_Stop);
		executeCode();
	}

	function initVariable(key:String, value:Dynamic)
	{
		return variables.set(key, value);
	}

	public function executeCode()
	{
		try
		{
			interp.execute(parser.parseString(Assets.getText(file)));
			executeFunction("onCreate", []);
		}
		catch (e) {}
	}

	public function executeFunction(funcName:String, ?args:Array<Dynamic>):Dynamic
	{
		if (interp.variables.exists(funcName))
		{
			try
			{
				return Reflect.callMethod(PlayState.instance, interp.variables.get(funcName), args == null ? [] : args);
			}
			catch (e) {}
		}
		return null;
    }
}