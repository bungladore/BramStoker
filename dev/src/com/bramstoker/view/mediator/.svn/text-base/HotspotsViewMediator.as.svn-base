package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.controller.events.BloodEvent;
	import com.bramstoker.model.ArtifactModel;
	import com.bramstoker.model.MediaPlayerModel;
	import com.bramstoker.model.XMLLayoutModel;
	import com.bramstoker.view.component.ArtifactContainerView;
	import com.bramstoker.view.component.ArtifactView;
	import com.bramstoker.view.component.HotspotsView;
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	import org.robotlegs.mvcs.Mediator;
	import org.swiftsuspenders.injectionresults.InjectClassResult;
	
	public class HotspotsViewMediator extends Mediator
	{
		[Inject]
		public var hotspotView:HotspotsView;
		
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		[Inject]
		public var artifactModel:ArtifactModel;
		
		private var delayed_call:Boolean = false;
		private var artifact_delay:ArtifactView;
		
		
		override public function onRegister():void
		{
			//listens to robot legs close commands
			eventMap.mapListener(eventDispatcher, ArtifactEvent.HOTSPOTS, init);
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.CLOSE_COMPLETE, adjustArtifact);
			eventMap.mapListener(eventDispatcher, MediaPlayerEvent.CLOSE, disable);
			addViewListener(ArtifactEvent.CHANGE_ARTIFACT, updateArtifact);
			eventMap.mapListener(eventDispatcher, ArtifactEvent.READY_ARTS, showAll);
			eventMap.mapListener(eventDispatcher, ArtifactEvent.FINISHED_TRANSITION, enable);
			eventMap.mapListener(eventDispatcher, ArtifactEvent.SHOW_VIDEO,  disable);
			eventMap.mapListener(eventDispatcher, BloodEvent.FORWARD_COMPLETE, enable);
			eventMap.mapListener(eventDispatcher, BloodEvent.BACK_COMPLETE, enable);
		}
		private function init(e:ArtifactEvent):void
		{
			//trace("we heard the ready over here");
			//creates the hotspots with artifacts
			hotspotView.createChildren(e.artifactsArray);
		}
		private function updateArtifact(e:ArtifactEvent):void
		{
			//trace("UPDATING THE MODEL");
			//trace("from the hotspot " + );
			TweenMax.killAll();
			if(mediaPlayerModel.active)
			{
				//trace("closing player");
				delayed_call = true;
				artifact_delay = e.currentArtifact;
				dispatch(new MediaPlayerEvent(MediaPlayerEvent.CLOSE));
			}else{
				//trace("player is closed");
				var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT);
				ae.currentArtifact = e.currentArtifact;
				dispatch(ae);
			}
			
		}
		private function enable(e:Event):void
		{
			hotspotView.show();
		}
		private function disable(e:Event):void
		{
			hotspotView.hide();
		}
		private function showAll(e:ArtifactEvent):void
		{
			hotspotView.showAll();
			trace("SHOW ALL");
		}
		private function adjustArtifact(e:MediaPlayerEvent):void
		{
			if(delayed_call)
			{
				delayed_call = false;
				var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT);
				ae.currentArtifact = artifact_delay;
				dispatch(ae);
			}
		}
	}
}