package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.model.ArtifactModel;
	import com.bramstoker.model.MediaPlayerModel;
	import com.bramstoker.model.XMLLayoutModel;
	import com.bramstoker.view.component.ArtifactContainerView;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.robotlegs.mvcs.Mediator;
	import org.swiftsuspenders.injectionresults.InjectClassResult;
	
	public class ArtifactContainerViewMediator extends Mediator
	{
		[Inject]
		public var artifactContainerView:ArtifactContainerView;
		
		[Inject]
		public var mediaPlayerModel:MediaPlayerModel;
		
		[Inject]
		public var artifactModel:ArtifactModel;
		
		[Inject]
		public var xmlLayoutModel:XMLLayoutModel;
		
		override public function onRegister():void
		{
			//listen for the update from the model
			//eventMap.mapListener(eventDispatcher, ArtifactEvent.SHOW_VIDEO, hideAll);
			//listen for the update from the model
			eventMap.mapListener(eventDispatcher, ArtifactEvent.READY_ARTS, userEngaged);
			//listens to robot legs close commands
			//eventMap.mapListener(eventDispatcher, MediaPlayerEvent.CLOSE_COMPLETE, showAll);
			//listens to robot legs close commands
			eventMap.mapListener(eventDispatcher, ArtifactEvent.LAYOUT_READY, init);
			
			eventMap.mapListener(eventDispatcher, ArtifactEvent.LAYOUT_RESET, reset);
			
			eventMap.mapListener(eventDispatcher, ArtifactEvent.ADD_TO_TOP, addToTop);
			//listen for the update from the model
			addContextListener(ArtifactEvent.UPDATE_ARTIFACT, updateArtifact);
			//listens for the initial artifacts to finsish loading and displays the first
			addViewListener(ArtifactEvent.READY, startUp);
			addViewListener(ArtifactEvent.FINISHED_TRANSITION, finishTrans);
			//
			//addViewListener(ArtifactEvent.CHANGE_ARTIFACT, enableArtifact);
			//creates the artifacts
			artifactContainerView.createChildren();
			
		}
		
		/*
		*	dispatch the select artifact event to robotlegs
		*/
		private function enableArtifact(e:ArtifactEvent):void
		{
			//trace("UPDATING THE MODEL");
			//check if video player is open
			//if is… then close video player
			//then goto section
			//else
			//just goto the section
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT);
			ae.currentArtifact = e.currentArtifact;
			dispatch(ae);
		}
		
		private function addToTop(e:ArtifactEvent):void
		{
			artifactContainerView.addTop(e.randomArtifact);
		}
		
		private function finishTrans(e:ArtifactEvent):void
		{
			dispatch(new ArtifactEvent(ArtifactEvent.FINISHED_TRANSITION));
		}
		
		private function init(e:ArtifactEvent):void
		{
			trace("resetting the model");
			artifactContainerView.init(xmlLayoutModel.xml.layout.(@type=='default'));//xmlLayoutModel.xml.layout.(@type==e.currentArtifact.id)
		}
		
		private function reset(e:ArtifactEvent):void
		{
			trace("resetting the model");
			artifactContainerView.init(xmlLayoutModel.xml.layout.(@type=='default'), artifactModel.currentArtifact);//xmlLayoutModel.xml.layout.(@type==e.currentArtifact.id)
		}
		
		private function userEngaged(e:ArtifactEvent):void
		{
			artifactContainerView.engage(xmlLayoutModel.xml.layout.(@type==1));
		}
		
		/*private function hideAll(e:ArtifactEvent):void
		{
			artifactContainerView.hide();
		}
		
		private function showAll(e:MediaPlayerEvent):void
		{
			//trace("SHOWING ALL");
			artifactContainerView.show();
		}*/
		
		private function startUp(e:ArtifactEvent):void
		{
			trace("doing the old startup");
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.READY);
			ae.currentArtifact = e.currentArtifact;
			ae.artifactsArray = e.artifactsArray;
			//initializes first tab selected and updates model
			dispatch(ae);
			//sets the first tab to the on position
			//artifactContainerView.enable(e.artifactsArray[0], xmlLayoutModel.xml.layout.(@type==1));//xmlDataModel.xml.artifact.(@id==(e.currentArtifact.id)
			//trace("XML Layout Model " + xmlLayoutModel.xml);
		}
		private function updateArtifact(e:ArtifactEvent):void
		{
			//updates a new tab and artifact -- places on top of stack
			//trace("UPDATE " + xmlLayoutModel.xml.layout.(@type==e.currentArtifact.id));
			artifactContainerView.disable(e.previousArtifact);
			artifactContainerView.enable(e.currentArtifact, xmlLayoutModel.xml.layout.(@type==(e.currentArtifact.id + 1)));//xmlLayoutModel.xml.layout.(@type==e.currentArtifact.id)
		}
	}
}