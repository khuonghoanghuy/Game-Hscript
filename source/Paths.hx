package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import haxe.io.Path;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import sys.FileSystem;

using StringTools;

class Paths
{
	public static var currentTrackerAssets:Map<String, FlxGraphic> = [];

	inline public static function getAllScripts(folders:String = "data", ?extension:String = ".hxs")
	{
		var folderToRead = FileSystem.readDirectory(folders);
		for (file in folderToRead)
		{
			if (file.endsWith(extension))
			{
				var scriptPath = Path.join([folders, file]);
				PlayState.ayoScripts.push(new GameScript(scriptPath));
			}
		}
	}
	public static function getFile(key:String, defaultFolders:String = "assets/")
	{
		if (key != null)
		{
			if (FileSystem.exists(key))
			{
				return key;
			}
		}
		return defaultFolders + key;
	}

	inline public static function getImage(key:String):FlxGraphic
	{
		/*var graphic:FlxGraphic = returnGraphic(key);
			return graphic; */
		returnGraphic(key);
		var graphical = FlxG.bitmap.get(key);
		return graphical;
	}

	public static function returnGraphic(path:String, folders:String = "assets/images/"):FlxGraphic
	{
		trace("Images return: " + currentTrackerAssets.toString());

		try
		{
			var readToPath = getFile(path, folders);
			if (FileSystem.exists(readToPath))
			{
				if (!currentTrackerAssets.exists(readToPath))
				{
					var bitmap = BitmapData.fromFile(readToPath);
					var graphic = FlxGraphic.fromBitmapData(bitmap);
					graphic.persist = true;
					FlxG.bitmap.add(graphic);
					currentTrackerAssets.set(readToPath, graphic);
				}
				return FlxG.bitmap.get(readToPath);
			}
			return null;
		}
		catch (e)
		{
			trace(e.message);
			return null;
		}
	}
}