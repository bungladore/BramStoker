package com.bramstoker.controller.commands
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.controller.events.NavigationEvent;
	import com.bramstoker.controller.events.TitleEvent;
	import com.bramstoker.controller.events.GoogleEvent;
	import com.bramstoker.model.ArtifactModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AutoPilotCommand extends Command
	{
		[Inject]
		public var artifactModel:ArtifactModel;
		
		override public function execute():void
		{
			artifactModel.autoPilot();
			dispatch(new TitleEvent(TitleEvent.HIDE_INSTRUCT));
			dispatch(new TitleEvent(TitleEvent.HIDE_TITLE));
			dispatch(new ArtifactEvent(ArtifactEvent.LAYOUT_RESET));
			dispatch(new NavigationEvent(NavigationEvent.RESET));
			dispatch(new MediaPlayerEvent(MediaPlayerEvent.CLOSE));
			
			var ge:GoogleEvent = new GoogleEvent(GoogleEvent.CLICK_EVENT);
			ge.event_type = "ATTRACT_MODE";
			dispatch(ge);
		}
	}
}