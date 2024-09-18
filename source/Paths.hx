package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import haxe.io.Path;
import openfl.Assets;
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
	inline public static function getImage(path:String, folders:String = "assets/"):FlxGraphic
	{
		var pathes = path + ".png";
		if (Assets.exists(pathes, IMAGE))
		{
			if (!currentTrackerAssets.exists(pathes))
			{
				var newGraphic:FlxGraphic = FlxG.bitmap.add(pathes, false, pathes);
				newGraphic.persist = true;
				currentTrackerAssets.set(pathes, newGraphic);
			}
			return currentTrackerAssets.get(pathes);
		}
		return null;
	}
}