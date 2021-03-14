package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class DeathState extends FlxState
{
	var menusprite:FlxSprite;

	override public function create()
	{
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			//	FlxG.sound.playMusic("assets/music/intromusic.mp3", 1, true);
		}

		var playButton:FlxButton;

		var menusprite = new FlxSprite(0, 0).loadGraphic("assets/images/MenuImage.png");
		add(menusprite);
		menusprite.setGraphicSize(500);
		menusprite.screenCenter();

		var text = new FlxText(100, 10, 300, "You Died :(", 20);
		add(text);
		text.screenCenter();
		text.y -= 100;

		playButton = new FlxButton(0, 0, "Play Again", clickPlay);
		add(playButton);
		playButton.screenCenter();

		super.create();
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
