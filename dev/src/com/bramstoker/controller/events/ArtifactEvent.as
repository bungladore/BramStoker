/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/01/11 
* Events for the Artifacts
*/
package com.bramstoker.controller.events
{
	import com.bramstoker.view.component.ArtifactView;
	
	import flash.events.Event;
	
	public class ArtifactEvent extends Event
	{

		private static const NAME:String = "ArtifactEvent_";
		//calls model to update it's state
		public static const CHANGE_ARTIFACT:String = NAME + "CHANGE_ARTIFACT";
		//calls view to update it's state
		public static const UPDATE_ARTIFACT:String = NAME + "UPDATE_ARTIFACT";
		//show the media player
		public static const SHOW_VIDEO:String = NAME + "SHOW_VIDEO";
		//artifacts have been built and are ready to be displayed
		public static const READY:String = NAME + "READY";
		//switch to autopilot mode
		public static const AUTO_PILOT:String = NAME + "AUTO_PILOT";
		//
		public static const LAYOUT_READY:String = NAME + "LAYOUT_READY";
		public static const LAYOUT_RESET:String = NAME + "LAYOUT_RESET";
		//
		public static const READY_ARTS:String = NAME + "READY_ARTS";
		//
		public static const DRAG_ARTIFACT:String = NAME + "DRAG_ARTIFACT";
		//
		public static const STOP_DRAG_ARTIFACT:String = NAME + "STOP_DRAG_ARTIFACT";
		//
		public static const HOTSPOTS:String = NAME + "HOTSPOTS";
		//
		public static const FINISHED_TRANSITION:String = NAME + "FINISHED_TRANSITION";
		
		public static const ADD_TO_TOP:String = NAME + "ADD_TO_TOP";
		
		
		//parameters passed to the model
		public var currentArtifact:ArtifactView;
		public var previousArtifact:ArtifactView;
		public var randomArtifact:ArtifactView;
		//all the artifacts
		public var artifactsArray:Array;

		public function ArtifactEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}