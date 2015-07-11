package com.bramstoker.controller.commands
{
	import com.bramstoker.model.MediaPlayerModel;
	import org.robotlegs.mvcs.Command;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	
	public class SwitchMediaContentCommand extends Command
	{
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		[Inject]
		public var event:MediaPlayerEvent;
		
		override public function execute():void
		{
			//trace("EXECUTING THE COMMAND" + event.currentMedia);
			mediaPlayerModel.currentMedia = event.currentMedia;
			
		}
	}
}