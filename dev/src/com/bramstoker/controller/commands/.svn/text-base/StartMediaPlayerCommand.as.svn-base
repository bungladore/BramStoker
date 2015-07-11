package com.bramstoker.controller.commands
{
	import com.bramstoker.model.MediaPlayerModel;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartMediaPlayerCommand extends Command
	{
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		[Inject]
		public var event:MediaPlayerEvent;
		
		override public function execute():void
		{
			//trace("EXUCUTING MEDIA START COMMAND");
			mediaPlayerModel.init(event.mediaArray);
		}
	}
}