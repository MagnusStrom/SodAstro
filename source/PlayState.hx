package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.helpers.FlxRange;
import flixel.util.helpers.FlxRangeBounds;

class PlayState extends FlxState
{
	var player:Player;
	var noHit:FlxTypedGroup<TheBad>;

	public static var isFlying:Bool = false;

	var asteroid:TheBad;
	var emitter:FlxEmitter;
	var scoreText:FlxText;

	public static var score = 0;

	override public function create()
	{
		score = 0;
		isFlying = false;
		super.create();
		var boppinTunes:FlxSound;
		boppinTunes = FlxG.sound.load("assets/music/damusic.mp3", 1, true);
		var funnybg:FlxBackdrop = new FlxBackdrop("assets/images/spacebg.png", 0, 3, true, true);
		add(funnybg);
		player = new Player(20, 20);
		add(player);

		scoreText = new FlxText(20, 20, 0, "Score: 0", 8);
		add(scoreText);
		player.screenCenter();
		player.y += 175;
		player.animation.play("idle");

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			player.animation.play("ready");
		});

		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			player.animation.play("launch");
		});
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			isFlying = true;
			emitter = new FlxEmitter(player.x, player.y);
			emitter.launchMode = FlxEmitterMode.CIRCLE;
			emitter.launchAngle.set(70, 100);
			emitter.acceleration.start.min.y = 800;
			emitter.acceleration.start.max.y = 1000;
			emitter.acceleration.end.min.y = 800;
			emitter.acceleration.end.max.y = 1000;
			for (i in 0...5000)
			{
				var p = new FlxParticle();
				p.makeGraphic(2, 2, FlxColor.BROWN);
				p.setGraphicSize(30);
				p.angle = 90;
				p.exists = false;
				p.lifespan = 0.3;
				emitter.add(p);
			}

			// Add emitter to stage
			add(emitter);
			emitter.start(false, 0.005, 0);
			player.canMove = true;
			funnybg.velocity.y = 1000;
			player.velocity.y = -100;
			player.isMoving2TheMiddle = true;
			boppinTunes.play();
		});

		/*	new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				player.canMove = true;
				funnybg.velocity.y = 1000;
				player.velocity.y = -100;
				player.isMoving2TheMiddle = true;
		});*/
		noHit = new FlxTypedGroup<TheBad>();
		add(noHit);
	}

	override public function update(elapsed:Float)
	{
		// SHIT CODE
		if (isFlying)
		{
			emitter.x = player.x + 47;
			emitter.y = player.y + 50;
		}
		if (FlxG.random.int(1, 500) < 6 && isFlying)
		{
			asteroid = new TheBad(FlxG.random.int(1, 500), -100);
			asteroid.velocity.y = 300;
			asteroid.setGraphicSize(100);
			asteroid.updateHitbox();
			asteroid.scale.set(2, 2);
			noHit.add(asteroid);
		}
		if (player.y < 250)
		{
			player.velocity.y = 0;
			player.isMoving2TheMiddle = false;
		}
		trace(player.y);

		if (FlxG.collide(player, noHit))
		{
			FlxG.switchState(new DeathState());
		}

		if (isFlying)
		{
			score++;
		}
		scoreText.text = Std.string(score);
		super.update(elapsed);
	}
}
