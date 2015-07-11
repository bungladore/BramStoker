package com.bramstoker.view.component
{
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GoogleView extends Sprite
	{
		public var tracker:AnalyticsTracker;
		public function GoogleView()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			tracker = new GATracker( this, "UA-1881045-9", "AS3", false );
		}
		
		public function track(str:String):void
		{
			str = str.toUpperCase();
			trace("HORROR_TOUCHSCREEN/BRAMSTOKER_MANUSCRIPT/" + str );
			tracker.trackPageview("HORROR_TOUCHSCREEN/BRAMSTOKER_MANUSCRIPT/" + str );
		}
	}
}