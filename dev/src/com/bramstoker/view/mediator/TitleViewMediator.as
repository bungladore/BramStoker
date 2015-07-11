package com.bramstoker.view.mediator
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.BloodEvent;
	import com.bramstoker.controller.events.TitleEvent;
	import com.bramstoker.model.ArtifactModel;
	import com.bramstoker.model.XMLDataModel;
	import com.bramstoker.view.component.TitleView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TitleViewMediator extends Mediator
	{
		[Inject]
		public var titleView:TitleView;
		
		[Inject]
		public var artifactModel:ArtifactModel;
		
		[Inject]
		public var xmlDataModel:XMLDataModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArtifactEvent.UPDATE_ARTIFACT, changeTitle);
			eventMap.mapListener(eventDispatcher, BloodEvent.BLOOD_LOADED, hideInit);
			eventMap.mapListener(eventDispatcher, TitleEvent.SHOW_INSTRUCT, showInstruct);
			eventMap.mapListener(eventDispatcher, TitleEvent.HIDE_INSTRUCT, hideInstruct);
			eventMap.mapListener(eventDispatcher, TitleEvent.HIDE_TITLE, hideTitle);
		}
		
		private function changeTitle(e:ArtifactEvent):void
		{
			var data:XMLList = xmlDataModel.xml.artifact.(@id==e.currentArtifact.id);
			titleView.update(data);
		}
		private function showInstruct(e:TitleEvent):void
		{
			titleView.showInstruct();
		}
		private function hideTitle(e:TitleEvent):void
		{
			titleView.hideTitle();
		}
		private function hideInstruct(e:TitleEvent):void
		{
			titleView.hideInstruct();
		}
		private function hideInit(e:BloodEvent):void
		{
			titleView.hideInit();
		}
	}
}