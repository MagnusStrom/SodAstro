package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var menusprite:FlxSprite;
	var introImg:FlxSprite;

	override public function create()
	{
		var bgSprite:FlxSprite = new FlxSprite(-700, -300).loadGraphic("assets/images/MenuBG.png");
		add(bgSprite);
		bgSprite.scale.set(0.5, 0.5);
		introImg = new FlxSprite(-700, -400).loadGraphic("assets/images/introimg.png");
		// introImg.setGraphicSize(500);
		add(introImg);
		introImg.scale.set(0.2, 0.2);
		var boppinTunes:FlxSound;
		boppinTunes = FlxG.sound.load("assets/music/intromusic.mp3", 1, true);
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			boppinTunes.play();
			//	FlxG.sound.playMusic("assets/music/intromusic.mp3", 1, true);
		}

		var playButton:FlxButton;
		var creditsButton:FlxButton;

		var menusprite = new FlxSprite(0, 0).loadGraphic("assets/images/MenuImage.png");
		add(menusprite);
		menusprite.setGraphicSize(500);
		menusprite.screenCenter();

		/*	var text = new FlxText(100, 10, 300, "Sodastro", 20);
			add(text);
			text.screenCenter();
			text.y -= 100; */

		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.scale.set(2, 2);
		add(playButton);
		playButton.screenCenter();

		creditsButton = new FlxButton(0, 0, "About", clickOptions);
		creditsButton.scale.set(2, 2);
		add(creditsButton);
		creditsButton.screenCenter();
		creditsButton.y += 50;

		super.create();
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function clickOptions()
	{
		FlxG.switchState(new OptionsState());
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed([SEVEN]))
		{
			if (introImg.graphic.key == "assets/images/introimg.png")
			{
				introImg.loadGraphic("assets/images/introimg2.png");
			}
			else
			{
				introImg.loadGraphic("assets/images/introimg.png");
			}
		}
		super.update(elapsed);
	}
}
