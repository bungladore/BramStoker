package com.bramstoker.controller.events
{
	import flash.events.Event;
	
	public class BloodEvent extends Event
	{
		
		private static const NAME:String = "BloodEvent_";
		public static const BACK_COMPLETE:String = NAME + "BACK_COMPLETE";
		public static const FORWARD_COMPLETE:String = NAME + "FORWARD_COMPLETE";
		public static const ENGAGE_ARTIFACTS:String = NAME + "ENGAGE_ARTIFACTS";
		public static const BLOOD_LOADED:String = NAME + "BLOOD_LOADED";

		public function BloodEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}