/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/10/11 
* Class to manages the events and updates individual artifacts
*/
package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.model.ArtifactModel;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.robotlegs.mvcs.Mediator;
	import org.swiftsuspenders.injectionresults.InjectClassResult;
	import com.bramstoker.view.component.ArtifactView;
	
	public class ArtifactViewMediator extends Mediator
	{
		[Inject]
		public var artifactView:ArtifactView;
		
		/*
		*	adds listeners to the view
		*/
		override public function onRegister():void
		{
			//addViewListener(ArtifactEvent.CHANGE_ARTIFACT, enableArtifact);
			addViewListener(ArtifactEvent.SHOW_VIDEO, showVideo);
		}
		
		/*
		*	dispatch the select artifact event to robotlegs
		*/
		//private function enableArtifact(e:ArtifactEvent):void
		//{
			//trace("UPDATING THE MODEL");
		//	var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT);
		//	ae.currentArtifact = artifactView;
		//	dispatch(ae);
		//}
		
		/*
		*	dispatch the show video event to robotlegs
		*/
		private function showVideo(e:ArtifactEvent):void
		{
			
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.SHOW_VIDEO);
			ae.currentArtifact = e.currentArtifact;
			dispatch(ae);
			
		}
	}
}