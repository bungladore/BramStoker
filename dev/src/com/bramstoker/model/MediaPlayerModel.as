package com.bramstoker.model
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.view.component.MediaPlayerButtonView;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MediaPlayerModel extends Actor
	{
		private var _currentMedia:MediaPlayerButtonView;
		private var _previousMedia:MediaPlayerButtonView;
		private var _mediaArr:Array;
		private var _autoTimer:Timer;
		private var _videoTimer:Timer;
		private var _videoToggle:Number;
		private var _active:Boolean = false;
		
		public function init(media_arr:Array):void
		{
			//returns the current artifact
			//trace("init MEDIA PLAYER MODEL");
			_mediaArr = media_arr;
			_currentMedia = media_arr[0];
			
			//timer for auto picking an artifact
			//_autoTimer = new Timer(20000, 0);
			//_autoTimer.addEventListener(TimerEvent.TIMER, randomArtifact);
			
			//timer for auto diplaying the video
			//_videoTimer = new Timer(5000, 2);
			//_videoTimer.addEventListener(TimerEvent.TIMER, callVideo);
		}
		
		public function get previousMedia():MediaPlayerButtonView
		{
			//returns the current artifact
			return _previousMedia;
		}
		
		public function get currentMedia():MediaPlayerButtonView
		{
			//returns the current artifact
			return _currentMedia;
		}
		
		public function set active(act:Boolean):void
		{
			
			_active = act;
		}
		
		public function get active():Boolean
		{
			
			return _active;
		}
		
		public function set currentMedia(enable_media:MediaPlayerButtonView):void
		{
			//set the current artifact
			_previousMedia = currentMedia;
			_currentMedia = enable_media;
			
			//create the event update artifact
			var media_event:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.UPDATE_CONTENT);
			
			//set the new artifact to be updated
			media_event.currentMedia = currentMedia;
			
			//the old artifact to be disabled
			media_event.previousMedia = previousMedia;
			
			//dispatch the event to robot legs
			dispatch(media_event);
		}
	}
}