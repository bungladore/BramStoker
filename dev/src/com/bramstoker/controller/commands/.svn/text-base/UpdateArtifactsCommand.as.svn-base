/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/01/11 
* Commands the artifact model to update it's state and notify the artifactContainer view
*/
package com.bramstoker.controller.commands
{
	import com.bramstoker.model.ArtifactModel;
	import com.bramstoker.view.component.MediaPlayerButtonView;
	import org.robotlegs.mvcs.Command;
	import com.bramstoker.controller.events.ArtifactEvent;
	
	public class UpdateArtifactsCommand extends Command
	{
		[Inject]
		public var artifactModel:ArtifactModel;
		
		[Inject]
		public var event:ArtifactEvent;
		
		override public function execute():void
		{
			//sets the current artfact with the new artifact clicked
			artifactModel.currentArtifact = event.currentArtifact;
			
		}
	}
}