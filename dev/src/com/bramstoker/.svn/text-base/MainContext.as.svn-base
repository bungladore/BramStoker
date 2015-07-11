/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/01/11 
* ContextView manages communication between Model, View and Controllers
* Initializes and adds elements to the stage.
*/
package com.bramstoker
{
	//COMMANDS
	import com.bramstoker.controller.commands.*;
	import com.bramstoker.controller.events.*;
	import com.bramstoker.model.*;
	import com.bramstoker.view.component.*;
	import com.bramstoker.view.mediator.*;
	import com.greensock.TweenMax;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public var THRESHOLD:Number = 90;
		private var activator:Sprite;
		private var nativeApp:NativeApplication;
		private var documents_data:File = File.documentsDirectory.resolvePath("stoker_manuscript/data/");
		private var media_player:MediaPlayerView;
		private var initialize:Initialize;
		private var titleView:TitleView;
		private var hotspots:HotspotsView;
		private var googleView:GoogleView;
		
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			
			var bg:Background = new Background();
			contextView.addChild(bg);
			
			//maps or mediators to their views
			mediatorMap.mapView(ArtifactView, ArtifactViewMediator);
			mediatorMap.mapView(ArtifactContainerView, ArtifactContainerViewMediator);
			mediatorMap.mapView(MediaPlayerView, MediaPlayerViewMediator);
			mediatorMap.mapView(MediaPlayerButtonView, MediaPlayerButtonViewMediator);
			mediatorMap.mapView(TitleView, TitleViewMediator);
			mediatorMap.mapView(TopNavigationView, TopNavigationViewMediator);
			mediatorMap.mapView(HotspotsView, HotspotsViewMediator);
			mediatorMap.mapView(ClickSoundAudio, ClickSoundAudioMediator);
			mediatorMap.mapView(GoogleView, GoogleViewMediator);
			
			//makes our model a singleton
			injector.mapSingleton(ArtifactModel);
			injector.mapSingleton(MediaPlayerModel);
			injector.mapSingleton(XMLDataModel);
			injector.mapSingleton(XMLLayoutModel);
			
			//fires once, sets the first section as active and updates the model
			commandMap.mapEvent(ArtifactEvent.READY, StartArtifactsCommand, ArtifactEvent, true);
			//updates the model when the user clicks different sections
			commandMap.mapEvent(ArtifactEvent.CHANGE_ARTIFACT, UpdateArtifactsCommand, ArtifactEvent);
			//fires once, sets the first section as active and updates the model
			commandMap.mapEvent(MediaPlayerEvent.READY, StartMediaPlayerCommand, MediaPlayerEvent);
			//switches the user content in the media player (videos/images)
			commandMap.mapEvent(MediaPlayerEvent.SWITCH_CONTENT, SwitchMediaContentCommand, MediaPlayerEvent);
			
			
			
			//setups up the listener for user inactivity
			nativeApp = NativeApplication.nativeApplication;
			nativeApp.idleThreshold = THRESHOLD;
			
			googleView = new GoogleView();
			contextView.addChild(googleView);
			
			
			//nativeApp.addEventListener(Event.USER_PRESENT, userActiveHandler);
			hotspots = new HotspotsView();
			contextView.addChild(hotspots);
			
			//creates the artfiacts
			var artifact_container:ArtifactContainerView = new ArtifactContainerView();
			contextView.addChild(artifact_container);
			//artifact_container.x = 610;
			//artifact_container.y = -720;
			
			//creates the video player - currently the blood splatter is in the video player
			media_player = new MediaPlayerView();
			contextView.addChild(media_player);
			media_player.x = 0;
			media_player.y = 0;
			
			var global_click:ClickSoundAudio = new ClickSoundAudio();
			contextView.addChild(global_click);
			
			//listens to robot legs close commands
			contextView.addEventListener(IdleEvent.ENABLE_IDLE, enableIdle);
			contextView.addEventListener(IdleEvent.DISABLE_IDLE, disableIdle);
			
			contextView.addChild(hotspots);
			
			
			//creates the titles
			titleView = new TitleView();
			contextView.addChild(titleView);
			titleView.x = 0;
			titleView.y = -100;
			titleView.hideTitle();
			titleView.hideInstruct();
			
			//creates the top right navigation buttons (help and credits)
			var top_navigation:TopNavigationView = new TopNavigationView();
			contextView.addChild(top_navigation);
			top_navigation.hide();
			
			//replaces the USER_PRESENT of the nativatApp events because it keeps firing when video plays
			activator = new Sprite();
			activator.graphics.beginFill(0x000000, 0.0);
			activator.graphics.drawRect(0, 0, 1920, 1080);
			activator.graphics.endFill();
			contextView.addChild(activator);
			
			//
			var title_card:TitleCard = new TitleCard();
			activator.addChild(title_card);
			title_card.y = 256;
			
			//i have no idea what this does
			mediatorMap.createMediator(contextView);
			
			//
			contextView.addEventListener(BloodEvent.BLOOD_LOADED, addUserIdle);
			//
			var media_xml:URLLoader = new URLLoader();
			media_xml.addEventListener(Event.COMPLETE, setXMLData);
			var xml_url:URLRequest = new URLRequest(documents_data.url + "/stoker_video.xml");
			media_xml.load(xml_url);
			//
			var layout_xml:URLLoader = new URLLoader();
			layout_xml.addEventListener(Event.COMPLETE, setXMLLayout);
			var layout_url:URLRequest = new URLRequest(documents_data.url + "/layout.xml");
			layout_xml.load(layout_url);
			
			//attaches the init art from the assets swc
			initialize = new Initialize();
			contextView.addChild(initialize);
			initialize.x = 1920/2 - initialize.width/2;
			initialize.y = 450;
			
		}
		
		private function setXMLData(e:Event):void
		{
			commandMap.execute(XMLDataCommand, new XML(e.target.data), XML, 'dataXML');
		}
		
		private function setXMLLayout(e:Event):void
		{
			commandMap.execute(XMLLayoutCommand, new XML(e.target.data), XML, 'layoutXML');
		}
		
		/*
		*	handles the attract mode when the user is inactive
		*/
		public function addUserIdle(e:BloodEvent):void
		{
			//trace("add native app event");
			enableIdle();
			activator.addEventListener(MouseEvent.MOUSE_DOWN, userActiveHandler);
			activator.buttonMode = true;
			//TweenMax.to(initialize, 0.5, {alpha:0.0, delay:1.0, onComplete:function():void{initialize.visible = false;}});
			initialize.visible = false;
			//userActiveHandler();
		}
		public function enableIdle(e:IdleEvent = null):void
		{
			//trace("ENABLED IDLE");
			if(!nativeApp.hasEventListener(Event.USER_IDLE)){
				nativeApp.addEventListener(Event.USER_IDLE, userIdleHandler);
				//trace("ACTUALLY ENABLED IDLE");
			}
		}
		public function disableIdle(e:IdleEvent):void
		{
			//trace("DISABLED IDLE");
			if(nativeApp.hasEventListener(Event.USER_IDLE)){
				nativeApp.removeEventListener(Event.USER_IDLE, userIdleHandler);
				//trace("ACTUALLY DISABLED IDLE");
			}
		}
		private function userIdleHandler(e:Event):void
		{
			//trace("USER IDLE");
			activator.visible = true;
			commandMap.execute(AutoPilotCommand);
		}
		private function userActiveHandler(e:MouseEvent = null):void
		{
			//trace("USER ACTIVE");
			activator.visible = false;
			commandMap.execute(ManualPilotCommand);
		}
	}
}