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

	public static function image(path:String, folders:String = "assets/images/"):FlxGraphic
	{
		var fileKey:String = folders + path;
		if (!fileKey.endsWith(".png"))
		{
			fileKey = folders + path + ".png";
		}
		else
		{
			fileKey = folders + path;
		}

		try
		{
			if (FileSystem.exists(fileKey))
			{
				if (!currentTrackerAssets.exists(fileKey))
				{
					var bitmap = BitmapData.fromFile(fileKey);
					var graphic = FlxGraphic.fromBitmapData(bitmap);
					graphic.persist = true;
					currentTrackerAssets.set(fileKey, graphic);
				}
				return currentTrackerAssets.get(fileKey);
			}
			return currentTrackerAssets.get(fileKey);
		}
		catch (e)
		{
			trace(e.message);
			return null;
		}
	}
}