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
	inline public static final DEFAULT_FOLDER:String = 'assets';

	static public function getPath(folder:Null<String>, file:String)
	{
		if (folder == null)
			folder = DEFAULT_FOLDER;
		return folder + '/' + file;
	}

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
	static public function file(file:String, folder:String = DEFAULT_FOLDER):String
	{
		trace(folder + file);
		/*return File.getContent(defaultFolders + key);*/
		if (#if sys FileSystem.exists(folder) && #end (folder != null && folder != DEFAULT_FOLDER))
			return getPath(folder, file);
		return getPath(null, file);
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
	public static function getSparrowAtlas(name:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(image(name + ".png"), File.getContent(file(name + ".xml", "assets/images/")));
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