package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.GoogleEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.view.component.GoogleView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class GoogleViewMediator extends Mediator
	{
		[Inject]
		public var tracker:GoogleView;
		
		override public function onRegister():void
		{
			//listen for the update from the model
			eventMap.mapListener(eventDispatcher, ArtifactEvent.CHANGE_ARTIFACT, trackClick1);
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.SWITCH_CONTENT, trackClick2);
			eventMap.mapListener(eventDispatcher, GoogleEvent.CLICK_EVENT, trackClick3);
			//eventMap.mapListener(eventDispatcher, TitleEvent.HIDE_INSTRUCT, hideInstruct);
		}
		private function trackClick1(e:ArtifactEvent):void
		{
			tracker.track(e.currentArtifact.title);
		}
		private function trackClick2(e:MediaPlayerEvent):void
		{
			//trace("tracked media");
			tracker.track("VIDEO_" + e.currentMedia.title);
		}
		private function trackClick3(e:GoogleEvent):void
		{
			//trace("tracked media");
			tracker.track(e.event_type);
		}
	}
}