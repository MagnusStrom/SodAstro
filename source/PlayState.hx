package;

import flixel.FlxG;
import flixel.FlxObject;
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
	var yesHit:FlxTypedGroup<TheGood>;
	var text:FlxText;
	var text2:FlxText;

	public static var isFlying:Bool = false;

	var asteroid:TheBad;
	var soda:TheGood;
	var emitter:FlxEmitter;
	var scoreText:FlxText;
	var crash:FlxSound;
	var sip:FlxSound;
	var funnybg:FlxBackdrop;

	public static var score = 0;

	override public function create()
	{
		crash = FlxG.sound.load("assets/sounds/BAM.mp3", 1, false);
		sip = FlxG.sound.load("assets/sounds/SLURP.mp3", 0.5, false);
		score = 0;
		isFlying = false;
		super.create();
		var boppinTunes:FlxSound;
		boppinTunes = FlxG.sound.load("assets/music/damusic.mp3", 1, true);
		funnybg = new FlxBackdrop("assets/images/spacebg.png", 0, 3, true, true);
		add(funnybg);
		player = new Player(20, 20);
		add(player);

		scoreText = new FlxText(20, 20, 0, "SCORE: 0", 10);
		add(scoreText);
		player.screenCenter();
		player.y += 175;
		player.animation.play("idle");

		text = new FlxText(100, 10, 300, "X: Poop Fart", 20);
		//	add(text);
		//	text.visible = false;
		text2 = new FlxText(100, 50, 300, "Y: Poop Fart 2", 20);
		//	add(text2);
		//	text2.visible = false;

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
			emitter.acceleration.start.min.y = 1000;
			emitter.acceleration.start.max.y = 1200;
			emitter.acceleration.end.min.y = 1000;
			emitter.acceleration.end.max.y = 1200;
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
		yesHit = new FlxTypedGroup<TheGood>();
		add(yesHit);
	}

	// LETS FUCKING GOOOOOOOOO
	function collideWithSoda(item1:FlxObject, item2:FlxObject)
	{
		if (item2.visible == true)
		{
			sip.play();
			score = score + 100;
			item2.visible = false;
		}
	}

	// LETS FUCKING GOOOOOOOOO
	function collideWithRock(item1:FlxObject, item2:FlxObject)
	{
		player.canMove = false;
		funnybg.velocity.y = 0;
		item2.velocity.y = 0;
		crash.play();
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			FlxG.switchState(new DeathState());
		});
	}

	override public function update(elapsed:Float)
	{
		//-100, 600
		if (player.x < -100)
		{
			player.x = 600;
		}
		if (player.x > 600)
		{
			player.x = -50;
		}
		// SHIT CODE
		if (isFlying)
		{
			emitter.x = player.x + 48;
			emitter.y = player.y + 50;
		}
		if (FlxG.random.int(1, 500) < 6 && isFlying)
		{
			asteroid = new TheBad(FlxG.random.int(1, 500), -100);
			asteroid.velocity.y = 300;
			asteroid.setGraphicSize(100);
			asteroid.updateHitbox();
			asteroid.scale.set(2.5, 2.5);
			noHit.add(asteroid);
		}
		if (FlxG.random.int(1, 500) < 6 && isFlying)
		{
			soda = new TheGood(FlxG.random.int(1, 500), -100);
			soda.velocity.y = 300;
			soda.setGraphicSize(50);
			soda.updateHitbox();
			// asteroid.scale.set(2, 2);
			yesHit.add(soda);
		}
		if (player.y < 250)
		{
			player.velocity.y = 0;
			player.isMoving2TheMiddle = false;
		}
		FlxG.overlap(player, noHit, collideWithRock);
		FlxG.overlap(player, yesHit, collideWithSoda);

		/*	if (isFlying && player.canMove)
			{
				score++;
		}*/
		text.text = "X: " + player.x;
		text2.text = "Y: " + player.y;
		scoreText.text = "SCORE: " + Std.string(score);
		super.update(elapsed);
	}
}
