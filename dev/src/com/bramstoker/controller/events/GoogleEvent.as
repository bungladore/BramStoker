package com.bramstoker.controller.events
{
	import flash.events.Event;
	
	public class GoogleEvent extends Event
	{
		private static const NAME:String = "GoogleEvent_";
		public static const CLICK_EVENT:String = NAME + "CLICK_EVENT";
		public var event_type:String;
		
		public function GoogleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}