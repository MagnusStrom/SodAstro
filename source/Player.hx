package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 400;

	public var canMove:Bool = false;
	public var isMoving2TheMiddle:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		// frames = FlxAtlasFrames.fromSparrow("assets/images/limoDancer.png", 'assets/images/limoDancer.xml');
		// animation.addByPrefix("vibe", "bg dancer sketch PINK", 30, true);
		// setGraphicSize(100);
		//	updateHitbox();
		loadGraphic("assets/images/char.png", true, 32, 32);
		animation.add("idle", [0], 1, false);
		animation.add("ready", [1], 1, false);
		animation.add("launch", [2], 1, true);
		animation.add("fly", [7, 8, 9], 10, true);
		setGraphicSize(100);
		//	updateHitbox();
		// makeGraphic(16, 16, FlxColor.GRAY);
	}

	function updateMovement()
	{
		if (isMoving2TheMiddle)
		{
			drag.x = drag.y = 0;
		}
		else
		{
			drag.x = drag.y = 2400;
		}
		var left:Bool = false;
		var right:Bool = false;
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		if (canMove)
		{
			if (left || right)
			{
				if (left)
				{
					velocity.x = -SPEED;
				}
				if (right)
				{
					velocity.x = SPEED;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		updateHitbox();
		super.update(elapsed);
	}
}
