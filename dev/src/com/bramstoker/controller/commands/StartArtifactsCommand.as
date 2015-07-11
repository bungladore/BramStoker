package com.bramstoker.controller.commands
{
	import com.bramstoker.model.ArtifactModel;
	import org.robotlegs.mvcs.Command;
	import com.bramstoker.controller.events.ArtifactEvent;
	
	public class StartArtifactsCommand extends Command
	{
		[Inject]
		public var artifactModel:ArtifactModel;
		
		[Inject]
		public var event:ArtifactEvent;
		
		override public function execute():void
		{
			artifactModel.init(event.artifactsArray);
		}
	}
}