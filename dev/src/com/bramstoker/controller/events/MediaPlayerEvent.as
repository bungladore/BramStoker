package com.bramstoker.controller.events
{
	import com.bramstoker.view.component.MediaPlayerButtonView;
	
	import flash.events.Event;
	
	public class MediaPlayerEvent extends Event
	{
		private static const NAME:String = "MediaPlayerEvent_";
		public static const DISPLAY_VIDEO:String = NAME + "DISPLAY_VIDEO";
		public static const CLOSE:String = NAME + "CLOSE";
		public static const CLOSE_AND_UPDATE:String = NAME + "CLOSE_AND_UPDATE";
		public static const CLOSE_COMPLETE:String = NAME + "CLOSE_COMPLETE";
		public static const SWITCH_CONTENT:String = NAME + "SWITCH_CONTENT";
		public static const UPDATE_CONTENT:String = NAME + "UPDATE_CONTENT";
		public static const READY:String = NAME + "READY";
		public static const PAUSE_VIDEO:String = NAME + "PauseVideo";
		public static const PLAY_VIDEO:String = NAME + "PlayVideo";
		
		public var currentMedia:MediaPlayerButtonView;
		public var previousMedia:MediaPlayerButtonView;
		public var mediaArray:Array;
		
		public function MediaPlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}