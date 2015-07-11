package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.view.component.MediaPlayerButtonView;
	
	import org.robotlegs.mvcs.Mediator;
	import org.swiftsuspenders.injectionresults.InjectClassResult;
	
	public class MediaPlayerButtonViewMediator extends Mediator
	{
		[Inject]
		public var mpbView:MediaPlayerButtonView;
		
		override public function onRegister():void
		{
			addViewListener(MediaPlayerEvent.SWITCH_CONTENT, switchContent);
			//addViewListener(ArtifactEvent.SHOW_VIDEO, showVideo);
		}
		
		private function switchContent(e:MediaPlayerEvent):void
		{
			//trace("UPDATING THE MODEL");
			var mpe:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.SWITCH_CONTENT);
			mpe.currentMedia = mpbView;
			dispatch(mpe);
		}
	}
}