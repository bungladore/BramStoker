package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.GoogleEvent;
	import com.bramstoker.controller.events.BloodEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.controller.events.NavigationEvent;
	import com.bramstoker.controller.events.SoundEvent;
	import com.bramstoker.model.ArtifactModel;
	import com.bramstoker.model.MediaPlayerModel;
	import com.bramstoker.view.component.TopNavigationView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TopNavigationViewMediator extends Mediator
	{
		[Inject]
		public var topNavView:TopNavigationView;
		
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		[Inject]
		public var artifactModel:ArtifactModel;
		
		override public function onRegister():void
		{
			//listen for the update from the model
			addViewListener(NavigationEvent.SHOW_HELP, showHelp);
			addViewListener(NavigationEvent.SHOW_CREDITS, showCredits);
			addViewListener(NavigationEvent.CLOSE_CREDITS, closeCredits);
			addViewListener(NavigationEvent.CLOSE_HELP, closeHelp);
			
			eventMap.mapListener(eventDispatcher, ArtifactEvent.SHOW_VIDEO, disable);
			eventMap.mapListener(eventDispatcher, ArtifactEvent.READY_ARTS, show);
			eventMap.mapListener(eventDispatcher, NavigationEvent.RESET, hide);
			eventMap.mapListener(eventDispatcher, "ENABLE_HELP", enable);
			
			//eventMap.mapListener(eventDispatcher, TitleEvent.HIDE_INSTRUCT, hideInstruct);
		}
		private function enable(e:Event):void
		{
			topNavView.enable();
		}
		private function disable(e:Event):void
		{
			topNavView.disable();
		}
		private function show(e:ArtifactEvent):void
		{
			topNavView.show();
		}
		private function hide(e:NavigationEvent):void
		{
			topNavView.hide();
			topNavView.hideCredits();
			topNavView.hideHelp();
		}
		
		private function showHelp(e:NavigationEvent):void
		{
			if(mediaPlayerModel.active)
			{
				topNavView.showHelp2();
				dispatch(new MediaPlayerEvent(MediaPlayerEvent.PAUSE_VIDEO));
			}else{
				var id : Number = artifactModel.currentArtifact.id;
				if ( !artifactModel.previousArtifact )
					topNavView.showHelp1(1);
				else
					topNavView.showHelp1((artifactModel.currentArtifact.id + 2)); // Frames are 1-based and first frame is blank (no artifact selected), so start at 2
			}
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "SHOW_HELP";
			dispatch(ge);
			
			topNavView.hideCredits();
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
		}
		
		private function showCredits(e:NavigationEvent):void
		{
			topNavView.showCredits();
			topNavView.hideHelp();
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "SHOW_CREDITS";
			dispatch(ge);
			
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.PAUSE_VIDEO));
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
		}
		
		private function closeCredits(e:NavigationEvent):void
		{
			topNavView.hideCredits();
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "CLOSE_CREDITS";
			dispatch(ge);
			
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.PLAY_VIDEO));
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
		}
		private function closeHelp(e:NavigationEvent):void
		{
			topNavView.hideHelp();
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "CLOSE_HELP";
			dispatch(ge);
			
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.PLAY_VIDEO));
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
		}
	}
}