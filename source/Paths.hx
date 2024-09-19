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
	inline public static function getImage(key:String):FlxGraphic
	{
		var graphic:FlxGraphic = returnGraphic(key);
		return graphic;
	}

	public static function returnGraphic(path:String, folders:String = "assets/images/"):FlxGraphic
	{
		trace(currentTrackerAssets.toString());
		var folderToRead = FileSystem.readDirectory(folders + path + ".png");
		for (file in folderToRead)
			{
			var imagePath = Path.join([folders, file]);
			var bitmapData:BitmapData = BitmapData.fromFile(imagePath);
			if (bitmapData != null)
			{
				var graphic = FlxGraphic.fromBitmapData(bitmapData);
				currentTrackerAssets.set(imagePath, graphic);
				return currentTrackerAssets.get(imagePath);
			}
		}
		// If the image is embedded, try to load it using the original method
		var graphic = FlxGraphic.fromAssetKey(path);
		if (graphic != null)
		{
			currentTrackerAssets.set(path, graphic);
			return currentTrackerAssets.get(path);
		}
		return null;
	}
}