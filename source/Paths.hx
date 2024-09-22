package;

import flixel.graphics.FlxGraphic;
import haxe.io.Path;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.media.Sound;
import sys.FileSystem;

using StringTools;

class Paths
{
	public static var currentTrackerGraphic:Map<String, FlxGraphic> = [];
	public static var currentTrackerSounds:Map<String, Sound> = [];

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
				if (!currentTrackerGraphic.exists(fileKey))
				{
					var bitmap = BitmapData.fromFile(fileKey);
					var graphic = FlxGraphic.fromBitmapData(bitmap);
					graphic.persist = true;
					currentTrackerGraphic.set(fileKey, graphic);
				}
				return currentTrackerGraphic.get(fileKey);
			}
			return currentTrackerGraphic.get(fileKey);
		}
		catch (e)
		{
			trace(e.message);
			return null;
		}
	}

	public static function sounds(path:String, folders:String = "assets/sounds/"):Sound
	{
		var fileKey:String = folders + path;
		if (!fileKey.endsWith(".ogg"))
		{
			fileKey = folders + path + ".ogg";
		}
		else
		{
			fileKey = folders + path;
		}

		try
		{
			if (FileSystem.exists(fileKey))
			{
				if (!currentTrackerSounds.exists(fileKey))
				{
					currentTrackerSounds.set(fileKey, Sound.fromFile(fileKey));
				}
				return currentTrackerSounds.get(fileKey);
			}
			return currentTrackerSounds.get(fileKey);
		}
		catch (e)
		{
			trace(e.message);
			return null;
		}
	}
}