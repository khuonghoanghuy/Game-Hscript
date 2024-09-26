package;

import flixel.*;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import haxe.Json;
import hscript.*;
import openfl.Lib;
import sys.io.File;

using StringTools;

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

		// Haxe Classes
		setVariable("Math", Math);
		setVariable("Reflect", Reflect);
		setVariable("Json", Json);
		setVariable("Std", Std);

		// Flixel Classes
		setVariable("FlxMath", FlxMath);
		setVariable("FlxG", FlxG);
		setVariable("FlxSprite", FlxSprite);
		setVariable("FlxText", FlxText);
		setVariable("FlxTween", FlxTween);
		setVariable("FlxEase", FlxEase);
		setVariable("FlxAtlasFrames", FlxAtlasFrames);
		setVariable("FlxCamera", FlxCamera);
		setVariable("FlxObject", FlxObject);
		setVariable("FlxTypedGroup", FlxTypedGroup);
		setVariable("FlxGroup", FlxGroup);
		setVariable("FlxBar", FlxBar);

		// OpenFL Classes
		setVariable("Lib", Lib);

		// Engine Classes
		setVariable("Paths", Paths);
		setVariable("FlxColor", ColorScript);

		// Engine Special One
		setVariable("quickChange", QuickChange.instance);
		setVariable("game", PlayState.instance);
		setVariable("add", PlayState.instance.add);
		setVariable("remove", PlayState.instance.remove);
		setVariable("insert", PlayState.instance.insert);
		setVariable("addMulti", PlayState.instance.addMulti);
		setVariable("removeMulti", PlayState.instance.removeMulti);

		// Haxe Function
		setVariable('trace', function(value:Dynamic)
		{
			trace(value);
		});
		setVariable("this", this);

		// Joalor64GH Code
		setVariable('import', function(daClass:String, ?asDa:String)
		{
			final splitClassName:Array<String> = [for (e in daClass.split('.')) e.trim()];
			final className:String = splitClassName.join('.');
			final daClass:Class<Dynamic> = Type.resolveClass(className);
			final daEnum:Enum<Dynamic> = Type.resolveEnum(className);

			if (daClass == null && daEnum == null)
				Lib.application.window.alert('Class / Enum at $className does not exist.', 'Hscript Error!');
			else
			{
				if (daEnum != null)
				{
					var daEnumField = {};
					for (daConstructor in daEnum.getConstructors())
						Reflect.setField(daEnumField, daConstructor, daEnum.createByName(daConstructor));

					if (asDa != null && asDa != '')
						setVariable(asDa, daEnumField);
					else
						setVariable(splitClassName[splitClassName.length - 1], daEnumField);
				}
				else
				{
					if (asDa != null && asDa != '')
						setVariable(asDa, daClass);
					else
						setVariable(splitClassName[splitClassName.length - 1], daClass);
				}
			}
		});

		if (execute)
			this.execute(file);
	}

	public function executeCode(stringDa:String):Void
	{
		try
		{
			interp.execute(parser.parseString(stringDa));
		}
		catch (e)
		{
			#if hl
			trace("execute error!\n" + e);
			#else
			Lib.application.window.alert(e.message, 'Hscript Error!');
			#end
		}
	}

	public function execute(file:String, ?executeCreate:Bool = true):Void
	{
		try
		{
			interp.execute(parser.parseString(File.getContent(file)));
		}
		catch (e)
		{
			executeError(e.message);
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
		catch (e)
		{
			executeError(e.message);
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
		catch (e)
		{
			executeError(e.message);
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
		catch (e)
		{
			executeError(e.message);
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
		catch (e)
		{
			executeError(e.message);
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
			catch (e)
			{
				executeError(e.message);
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
	function executeError(errorText:String, ?title:String = "Error!")
	{
		Lib.application.window.alert(errorText, title);
		trace(title + " Hscript Code\n" + errorText);
	}
}