package;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.io.Path;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.media.Sound;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Paths
{
	public static var currentTrackerGraphic:Map<String, FlxGraphic> = [];
	public static var currentTrackerSounds:Map<String, Sound> = [];
	public static var currentTrackerFile:Map<String, String> = [];
	public static var DEFAULT_FOLDER:String = File.getContent("systemContent/pathsToDefault.txt");

	inline public static function getAllScripts(folders:String = "data", ?extension:String = ".hxs")
	{
		folders = DEFAULT_FOLDER + "data/";
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
	static public function file(file:String, folder:String = "assets/"):String
	{
		// folder = DEFAULT_FOLDER; // for sumthing
		trace(DEFAULT_FOLDER + folder + file);
		if (FileSystem.exists(DEFAULT_FOLDER + folder) && (folder != null && folder != DEFAULT_FOLDER + folder))
			return DEFAULT_FOLDER + folder + file;
		return "assets/" + folder + file;
	}

	public static function image(path:String):FlxGraphic
	{
		var fileKey:String = file(path + ".png", "images/");

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
	public static function getSparrowAtlas(name:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(image(name), File.getContent(file(name + ".xml", "images/")));
	}

	public static function sounds(path:String):Sound
	{
		var fileKey:String = file(path + ".ogg", "sounds/");

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

	public static function music(path:String):Sound
	{
		var fileKey:String = file(path + ".ogg", "music/");

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