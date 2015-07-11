package com.bramstoker.controller.events
{
	import flash.events.Event;
	
	public class TitleEvent extends Event
	{
		private static const NAME:String = "Title_";
		public static const SHOW_INSTRUCT:String = NAME + "SHOW_INSTRUCT";
		public static const HIDE_INSTRUCT:String = NAME + "HIDE_INSTRUCT";
		public static const SHOW_TITLE:String = NAME + "SHOW_TITLE";
		public static const HIDE_TITLE:String = NAME + "HIDE_TITLE";
		
		public function TitleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}