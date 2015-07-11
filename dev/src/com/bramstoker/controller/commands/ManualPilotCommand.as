package com.bramstoker.controller.commands
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.TitleEvent;
	import com.bramstoker.controller.events.GoogleEvent;
	import com.bramstoker.model.ArtifactModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ManualPilotCommand extends Command
	{
		[Inject]
		public var artifactModel:ArtifactModel;
		
		override public function execute():void
		{
			artifactModel.manual();
			dispatch(new TitleEvent(TitleEvent.SHOW_INSTRUCT));
			dispatch(new ArtifactEvent(ArtifactEvent.READY_ARTS));
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "MANUAL_MODE";
			dispatch(ge);
		}
	}
}