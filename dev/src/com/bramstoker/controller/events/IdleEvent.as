package com.bramstoker.controller.events
{
	import flash.events.Event;
	
	public class IdleEvent extends Event
	{
		private static const NAME:String = "Idle_";
		public static const ENABLE_IDLE:String = NAME + "ENABLE_IDLE";
		public static const DISABLE_IDLE:String = NAME + "DISABLE_IDLE";
		
		public function IdleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}