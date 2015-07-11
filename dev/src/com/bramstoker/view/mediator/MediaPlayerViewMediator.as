package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.BloodEvent;
	import com.bramstoker.controller.events.GoogleEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.controller.events.SoundEvent;
	import com.bramstoker.model.MediaPlayerModel;
	import com.bramstoker.model.XMLDataModel;
	import com.bramstoker.view.component.MediaPlayerButtonView;
	import com.bramstoker.view.component.MediaPlayerView;
	
	import flash.events.Event;
	
	import org.osmf.media.MediaPlayer;
	import org.robotlegs.mvcs.Mediator;
	
	public class MediaPlayerViewMediator extends Mediator
	{
		[Inject]
		public var mediaPlayerView:MediaPlayerView;
		
		[Inject]
		public var xmlDataModel:XMLDataModel;
		
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		private var media_state:String = "play";
		
		override public function onRegister():void
		{
			//listen for the update from the model
			eventMap.mapListener(eventDispatcher, ArtifactEvent.SHOW_VIDEO, showVideo);
			//listens to robot legs close commands
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.CLOSE, hideVideo);
			//listen for the update from the model
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.UPDATE_CONTENT, updateContent);
			//listens for when help screen is enabled
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.PAUSE_VIDEO, pauseVideo);
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.PLAY_VIDEO, playVideo);
			
			//listens for when user clicks
			addViewListener(MediaPlayerEvent.CLOSE, closeVideo);
			addViewListener(MediaPlayerEvent.READY, startUp);
			addViewListener(BloodEvent.BLOOD_LOADED, bloodReady);
			addViewListener(BloodEvent.ENGAGE_ARTIFACTS, finishClose);
			addViewListener(SoundEvent.MAKE_SOUND, makeIt);
			addViewListener(BloodEvent.FORWARD_COMPLETE, payItForward);
			addViewListener(BloodEvent.BACK_COMPLETE, payItBackward);
			addViewListener("GOOGLE_SCRUB", vidScrub);
			
			addViewListener("VIDEO_PAUSED", vidPaused);
			addViewListener("VIDEO_UNPAUSED", vidPlay);
			
			addViewListener("USER_PAUSED", pauseState);
			addViewListener("USER_UNPAUSED", playState);
			addViewListener("ENABLE_HELP", enableHelp);
			//addViewListener("VIDEO_COMPLETE", completeVideo);
			//addViewListener(MediaPlayerEvent.SWITCH_CONTENT, switchContent);
		}
		
		private function enableHelp(e:Event):void
		{
			dispatch(new Event("ENABLE_HELP"));
		}
		private function payItForward(e:BloodEvent):void
		{
			dispatch(new BloodEvent(BloodEvent.FORWARD_COMPLETE));
		}
		
		private function payItBackward(e:BloodEvent):void
		{
			dispatch(new BloodEvent(BloodEvent.BACK_COMPLETE));
		}
		
		private function completeVideo(e:Event):void
		{
			trace("what to do what to do?");
			mediaPlayerView.stop();
		}
		
		private function vidPaused(e:Event):void
		{
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "VIDEO_PAUSED";
			dispatch(ge);
		}
		
		private function vidScrub(e:Event):void
		{
			mediaPlayerModel.active = true;
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "VIDEO_SCRUBBED";
			dispatch(ge);
		}
		
		private function pauseState(e:Event):void
		{
			media_state = "pause";
		}
		private function playState(e:Event):void
		{
			media_state = "play";
		}
		private function vidPlay(e:Event):void
		{
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "VIDEO_PLAY";
			dispatch(ge);
		}
		private function finishClose(e:BloodEvent):void
		{
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.CLOSE_COMPLETE));
		}
		private function makeIt(e:SoundEvent):void
		{
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
		}
		//close video
		private function closeVideo(e:MediaPlayerEvent):void
		{
			//dispatchs the event to the system
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.CLOSE));
			dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
			media_state = "play";
		}
		private function pauseVideo(e:MediaPlayerEvent):void
		{
			mediaPlayerView.pause();	
		}
		private function playVideo(e:MediaPlayerEvent):void
		{
			trace("get media state " + media_state);
			if(media_state == "play"){
				mediaPlayerView.play();
			}
		}
		//blood imgages are in memory
		private function bloodReady(e:BloodEvent):void
		{
			//dispatchs the event to the system
			dispatch(new BloodEvent(BloodEvent.BLOOD_LOADED));
		}
		//autoplays the first video and selects the first media button
		private function startUp(e:MediaPlayerEvent):void
		{
			//trace("DISPATCHING READY EVENT FROM MEDIATOR");
			var mpe:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.READY);
			mpe.mediaArray = e.mediaArray;
			//initializes first tab selected and updates model
			
			dispatch(mpe);
		}
		//displays the blood splat and video player
		private function showVideo(e:ArtifactEvent):void
		{
			//shows the media player
			//trace(e.currentArtifact);
			if(!mediaPlayerModel.active){
				mediaPlayerModel.active = true;
				mediaPlayerView.setMediaXML(xmlDataModel.xml.artifact.(@id==(e.currentArtifact.id)));
				mediaPlayerView.show(e.currentArtifact.id);
				dispatch(new SoundEvent(SoundEvent.MAKE_SOUND));
			}
		}
		//hides the video player
		private function hideVideo(e:MediaPlayerEvent):void
		{
			if(mediaPlayerModel.active)
			{
				mediaPlayerModel.active = false;
				mediaPlayerView.hide();
			}else{
				
				mediaPlayerView.forceClose();
			}
		}
		//updates based on the user click on the media button
		private function updateContent(e:MediaPlayerEvent):void
		{
			//trace("updating the content for Media Player" + e.currentMedia);
			mediaPlayerView.update(e.currentMedia, e.previousMedia);
		}
	}
}