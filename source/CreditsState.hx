package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CreditsState extends FlxState
{
	var menusprite:FlxSprite;

	override public function create()
	{
		var boppinTunes:FlxSound;
		boppinTunes = FlxG.sound.load("assets/music/intromusic.mp3", 1, true);
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			boppinTunes.play();
			//	FlxG.sound.playMusic("assets/music/intromusic.mp3", 1, true);
		}

		var playButton:FlxButton;

		var menusprite = new FlxSprite(0, 0).loadGraphic("assets/images/MenuImage.png");
		add(menusprite);
		menusprite.setGraphicSize(500);
		menusprite.screenCenter();

		var text = new FlxText(100, 10, 300, "Coming Soon", 20);
		add(text);
		text.screenCenter();
		text.y -= 100;

		playButton = new FlxButton(0, 0, "Back To Menu", clickPlay);
		playButton.scale.set(2, 2);
		add(playButton);
		playButton.screenCenter();

		super.create();
	}

	function clickPlay()
	{
		FlxG.switchState(new MenuState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
