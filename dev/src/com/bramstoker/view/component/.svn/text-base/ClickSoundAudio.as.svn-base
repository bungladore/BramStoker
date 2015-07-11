package com.bramstoker.view.component
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class ClickSoundAudio extends Sprite
	{
		private var global_click:Sound;
		private var global_channel:SoundChannel;
		public function ClickSoundAudio()
		{
			global_click = new GlobalClick();
			global_channel = new SoundChannel();
		}
		public function play():void{
			//trace("play the sounds");
			global_channel = global_click.play();
		}
	}
}