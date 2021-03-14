package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class TheBad extends FlxSprite
{
	static inline var SPEED:Float = 400;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic("assets/images/donthit.png", false);
	}

	function updateMovement()
	{
		if (y > 500)
		{
			kill();
			visible = false;
		}
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
