package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.controller.events.SoundEvent;
	import com.bramstoker.view.component.ClickSoundAudio;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ClickSoundAudioMediator extends Mediator
	{
		[Inject]
		public var clickAudio:ClickSoundAudio;
		
		override public function onRegister():void
		{
			//listen for the update from the model
			eventMap.mapListener(eventDispatcher, ArtifactEvent.CHANGE_ARTIFACT, playClick);
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.SWITCH_CONTENT, playClick);
			eventMap.mapListener(eventDispatcher, SoundEvent.MAKE_SOUND, playClick);
			//eventMap.mapListener(eventDispatcher, TitleEvent.HIDE_INSTRUCT, hideInstruct);
		}
		private function playClick(e:Event = null):void
		{
			//trace("got hotspots");
			clickAudio.play();
		}
	}
}