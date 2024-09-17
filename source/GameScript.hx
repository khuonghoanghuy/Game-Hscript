package;

import flixel.*;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import hscript.*;
import openfl.Assets;
import sys.io.File;

class GameScript extends FlxBasic
{
	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

	public var interp:Interp = new Interp();
	public var parser:Parser = new Parser();

	public function new(file:String, ?execute:Bool = true)
	{
		super();
		parser.allowJSON = parser.allowTypes = parser.allowMetadata = true;

		setVariable("FlxG", FlxG);
		setVariable("FlxSprite", FlxSprite);
		setVariable("FlxText", FlxText);
		setVariable("FlxTween", FlxTween);
		setVariable("FlxEase", FlxEase);
		setVariable("Paths", Paths);

		setVariable("quickKey", QuickKey.instance);
		setVariable("quickChange", QuickChange.instance);
		setVariable("game", PlayState.instance);
		setVariable("add", PlayState.instance.add);
		setVariable("remove", PlayState.instance.remove);
		setVariable("insert", PlayState.instance.insert);
		setVariable("addMulti", PlayState.instance.addMulti);
		setVariable("removeMulti", PlayState.instance.removeMulti);

		if (execute)
			this.execute(file);
	}

	public function execute(file:String, ?executeCreate:Bool = true):Void
	{
		try
		{
			interp.execute(parser.parseString(File.getContent(file)));
		}
		catch (e:Dynamic)
		{
			#if hl
			trace("execute error!\n" + e);
			#else
			Lib.application.window.alert(e, 'Hscript Error!');
			#end
		}

		trace('Script Loaded Succesfully: $file');

		if (executeCreate)
			executeFunc('onCreate', []);
	}

	public function setVariable(name:String, val:Dynamic):Void
	{
		if (interp == null)
			return;

		try
		{
			interp.variables.set(name, val);
		}
		catch (e:Dynamic)
		{
			#if hl
			trace("set variable rror!\n" + e);
			#else
			Lib.application.window.alert(e, 'Hscript Error!');
			#end
		}
	}

	public function getVariable(name:String):Dynamic
	{
		if (interp == null)
			return null;

		try
		{
			return interp.variables.get(name);
		}
		catch (e:Dynamic)
		{
			#if hl
			trace("get variable error!\n" + e);
			#else
			Lib.application.window.alert(e, 'Hscript Error!');
			#end
		}

		return null;
	}

	public function removeVariable(name:String):Void
	{
		if (interp == null)
			return;

		try
		{
			interp.variables.remove(name);
		}
		catch (e:Dynamic)
		{
			#if hl
			trace("remove variable error!\n" + e);
			#else
			Lib.application.window.alert(e, 'Hscript Error!');
			#end
		}
	}

	public function existsVariable(name:String):Bool
	{
		if (interp == null)
			return false;

		try
		{
			return interp.variables.exists(name);
		}
		catch (e:Dynamic)
		{
			#if hl
			trace("exits variable error!\n" + e);
			#else
			Lib.application.window.alert(e, 'Hscript Error!');
			#end
		}
		return false;
	}

	public function executeFunc(funcName:String, ?args:Array<Dynamic>):Dynamic
	{
		if (interp == null)
			return null;

		if (existsVariable(funcName))
		{
			try
			{
				return Reflect.callMethod(this, getVariable(funcName), args == null ? [] : args);
			}
			catch (e:Dynamic)
			{
				#if hl
				trace("execute function error!\n" + e);
				#else
				Lib.application.window.alert(e, 'Hscript Error!');
				#end
			}
		}

		return null;
	}
	override function destroy()
	{
		super.destroy();
		parser = null;
		interp = null;
	}
}