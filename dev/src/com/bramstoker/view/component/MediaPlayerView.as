package com.bramstoker.view.component
{
	import com.bramstoker.controller.events.BloodEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.model.XMLDataModel;
	import com.greensock.TweenMax;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mrflvhead.MisterFLVHead;
	import mrflvhead.parts.LoadProgress;
	import mrflvhead.parts.PauseButton;
	import mrflvhead.parts.PlayProgress;
	
	
	//import org.osmf.media.MediaPlayer;
	
	public class MediaPlayerView extends Sprite
	{
		private var customPlayer:CustomVideoPlayer;
		private var flvPlayer:MisterFLVHead;
		private var inkblotPlayer:MisterFLVHead;
		private var buttonsContainer:Sprite;
		private var blood_transition:BloodTransition;
		private var media_xml:XMLList;
		private var id:Number = 0;
		private var video_folder:File = File.documentsDirectory.resolvePath("stoker_manuscript/videos/");
		private var image_folder:File = File.documentsDirectory.resolvePath("stoker_manuscript/images/");
		
		private var tc_holder0:Sprite = new Sprite();
		private var tc_holder1:Sprite = new Sprite();
		private var tc_holder2:Sprite = new Sprite();
		private var tc_holder3:Sprite = new Sprite();
		private var tc_arr:Array;
		private var tc_prev:Sprite;
		
		private var flv_media:String;
		private var flv_timer:Timer;
		private var title_card:Sprite;
		private var media_arr:Array;
		private var flv_timer_was_running:Boolean = false;
		
		private static const MAX_BUTTON:Number = 4;
		
		
		public function MediaPlayerView()
		{
			//player for the blood transitions
			/*inkblotPlayer = new MisterFLVHead(1920, 1080);
			addChild(inkblotPlayer);
			inkblotPlayer.x = 0;
			inkblotPlayer.y = 0;
			inkblotPlayer.addEventListener("VIDEO_COMPLETE", showVideo);*/
			
			//add the blood/ink transition class
			blood_transition = new BloodTransition();
			addChild(blood_transition);
			//blood_transition.addEventListener(BloodTransition.FORWARD);
			
			//temp artwork
			customPlayer = new CustomVideoPlayer();
			addChild(customPlayer);
			customPlayer.x = 519;
			customPlayer.y = 156;
			
			tc_holder0 = new Sprite();
			customPlayer.title_card.addChild(tc_holder0);
			
			tc_holder1 = new Sprite();
			customPlayer.title_card.addChild(tc_holder1);
			
			tc_holder2 = new Sprite();
			customPlayer.title_card.addChild(tc_holder2);
			
			tc_holder3 = new Sprite();
			customPlayer.title_card.addChild(tc_holder3);
			
			title_card = customPlayer.title_card;
			
			tc_arr = [tc_holder0, tc_holder1, tc_holder2, tc_holder3];
			
			flv_timer = new Timer(4000, 1);
			flv_timer.addEventListener(TimerEvent.TIMER, loadVideo);
			
			//container for media buttons
			buttonsContainer = new Sprite();
			customPlayer.addChild(buttonsContainer);
			buttonsContainer.x = 0;
			buttonsContainer.y = 560;
			
			//add mr flv
			flvPlayer = new MisterFLVHead(907,510);
			customPlayer.addChild(flvPlayer);
			flvPlayer.x = 1;
			flvPlayer.y = 1;
			
			var scrubber:Sprite = new VideoSlider();
			
			//add the controls
			var pause_button:PauseButton = flvPlayer.addPauseButton(new pauseBtn(), new playBtn());
			customPlayer.addChild(pause_button);
			pause_button.x = 0.55;
			pause_button.y = 511.5;
			
			var load_progress:LoadProgress = flvPlayer.addLoadProgress({color:0xC7C1B1, w:838, h:10});
			customPlayer.addChild(load_progress);
			
			var play_scrub:PlayProgress = flvPlayer.addPlayProgress({color:0xA8221D, w:838, h:10}, scrubber);
			customPlayer.addChild(play_scrub);
			
			customPlayer.addChild(scrubber);
			scrubber.y = 518;
			scrubber.x = 42;
			scrubber.mouseEnabled = false;
			
			load_progress.x = play_scrub.x = 54;
			load_progress.y = play_scrub.y = 526;
			
			initListeners();
			init();
		}
		
		public function init():void
		{
			//buildButtons();
			customPlayer.alpha = 0.0;
			customPlayer.visible = false;
			visible = false;
		}
	
		//initializes all the buttons that came in with the customPlayer artwork
		private function initListeners():void
		{
			customPlayer.closeBtn.addEventListener(MouseEvent.MOUSE_DOWN, closePlayer, false, 0, true);
			customPlayer.closeBtn.buttonMode = true;
			customPlayer.closeBtn2.addEventListener(MouseEvent.MOUSE_DOWN, closePlayer, false, 0, true);
			customPlayer.closeBtn2.buttonMode = true;
			customPlayer.block.mouseChildren = false;
			customPlayer.addEventListener("BLOOD_SPILLED", showVideo);
		}
		//waits for the blood spill animation to play and then builds the buttons
		private function showVideo(e:Event):void
		{
			//trace("GOT THE BLOOD");
			buildButtons();
		}
		private function disableAllButtons():void
		{
			if( !media_arr ) return;	// sanity check
			
			for(var i:uint = 0; i<4; i++){
				if(media_arr[i]){
					media_arr[i].killActive();
				}
			}
		}
		//removes all the media select buttons
		private function removeAllButtons():void
		{
			//trace("REMOVING ALL THE BUTTONS");
			while(buttonsContainer.numChildren > 0){
				buttonsContainer.removeChildAt(0);
			}
		}
		//builds out the media buttons for the specific video player
		private function buildButtons():void
		{	
			media_arr = new Array();
			var media_btn:MediaPlayerButtonView;
			var media_btn_folder:String = media_xml.@folder;
			buttonsContainer.visible = false;
			buttonsContainer.alpha = 0;
			//trace(id);
			//each player has only 4 buttons
			for(var i:uint=0; i<MAX_BUTTON; i++){
				media_btn = new MediaPlayerButtonView(i);
				//trace("some paths " + media_xml.artifact.video[i].@path);
				media_btn.path = video_folder.url + "/" + media_btn_folder + "/" + media_xml.video[i].@path;
				buttonsContainer.addChild(media_btn);
				//trace(media_xml.video[i]);
				media_btn.title = media_xml.video[i];
				media_btn.x = i*(media_btn.width - 13);
				media_arr.push(media_btn);
				media_btn.id = i;
				
				//we only set the thumbnails for the last 3, the first thumbnail is always the default intro guy
				//if(i>0){
				media_btn.img_preview = image_folder.url + "/_sfm_h_sm_thumbnails/_bw/" + media_xml.video[i].@thumb;
				//}
				media_btn.img_overlay = image_folder.url + "/_sfm_h_sm_thumbnails/_tinted/" + media_xml.video[i].@thumb;
			}
			media_btn = null;
			
			//update the model so it knows which section is first
			var ready_event:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.READY);
			ready_event.mediaArray = media_arr;
			dispatchEvent(ready_event);
			
			//sets the first tab to the on position
			media_arr[0].on();
			flv_media = media_arr[0].path;
			//
			loadMedia(0);
			TweenMax.to(buttonsContainer, 0.5, {autoAlpha:1});
			dispatchEvent(new Event("ENABLE_HELP"));
		}
		//dispatches an event to the Mediator to close the video when the USER CLICKS
		private function closePlayer(e:MouseEvent):void
		{
			//blood_transition.reset();
			//trace("closing the video");
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.CLOSE));
		}
		//
		private function loadMedia(id:Number):void
		{
			TweenMax.killAll();
			//if not the default (default is 0)
			if(id > -1){
				if(tc_prev){
					TweenMax.to(tc_prev, 0.0, {autoAlpha:0.0});
				}
				
				//yep id-1 (offset by the auto intro title card in the swc
				TweenMax.to(tc_arr[(id)], 0.0, {autoAlpha:1.0});
				tc_prev = tc_arr[(id)];
			}else{//must be the default
				//hide whatever was the previous
				if(tc_prev){
					TweenMax.to(tc_prev, 0.0, {autoAlpha:0.0});
				}
			}
			flv_timer.start();
		}
		//
		private function loadVideo(e:TimerEvent):void
		{
			flvPlayer.alpha = 0;
			TweenMax.to(flvPlayer, 0.5, {alpha:1.0});
			flvPlayer.loadVideo(flv_media);
		}
		//
		private function switchContent(e:MouseEvent):void
		{
			var mpe:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.SWITCH_CONTENT);
			mpe.currentMedia = MediaPlayerButtonView(e.currentTarget);
			dispatchEvent(mpe);
		}
		//sets the video xml data
		public function setMediaXML(xml:XMLList):void
		{
			media_xml = xml;
		}
		//
		public function show(_id:Number):void
		{
			
			setTitleCards();
			flvPlayer.ppReset();
			TweenMax.to(title_card, 0.5, {autoAlpha:1.0});
			//sets it all to visible
			visible = true;
			//plays the blood transition
			blood_transition.forward();
			blood_transition.addEventListener(BloodEvent.FORWARD_COMPLETE, finishShow);
			//
			id = _id;
		}
		
		private function clearTitleCards():void
		{
			if(tc_holder1.numChildren > 0){
				tc_holder0.removeChildAt(0);
				tc_holder1.removeChildAt(0);
				tc_holder2.removeChildAt(0);
				tc_holder3.removeChildAt(0);
			}
		}
		
		private function setTitleCards():void
		{
			clearTitleCards();
			
			var loader0:Loader = new Loader();
			var loader1:Loader = new Loader();
			var loader2:Loader = new Loader();
			var loader3:Loader = new Loader();
			for each( var ldr:Loader in [loader0,loader1,loader2,loader3] ) {
				ldr.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, titleCardIOError, false, 0, true );
			}

			loader0.load(new URLRequest(image_folder.url + "/_sfm_stoker_title_cards/" + media_xml.video[0].@title_card));
			tc_holder0.addChild(loader0);
			tc_holder0.visible = true;
			
			loader1.load(new URLRequest(image_folder.url + "/_sfm_stoker_title_cards/" + media_xml.video[1].@title_card));
			tc_holder1.addChild(loader1);
			tc_holder1.visible = false;
			
			loader2.load(new URLRequest(image_folder.url + "/_sfm_stoker_title_cards/" + media_xml.video[2].@title_card));
			tc_holder2.addChild(loader2);
			tc_holder2.visible = false;
			
			loader3.load(new URLRequest(image_folder.url + "/_sfm_stoker_title_cards/" + media_xml.video[3].@title_card));
			tc_holder3.addChild(loader3);
			tc_holder3.visible = false;
		}
		
		private function titleCardIOError( e:IOErrorEvent ) :void {
			trace("** titleCardIOError: Could not load", e);
		}
		
		//
		private function finishShow(e:BloodEvent):void
		{	
			blood_transition.removeEventListener(BloodEvent.FORWARD_COMPLETE, finishShow);
			dispatchEvent(new BloodEvent(BloodEvent.FORWARD_COMPLETE));
			TweenMax.to(customPlayer, 0.5, {autoAlpha:1.0, onComplete:buildButtons});
		}
		//
		public function hide():void
		{
			//trace("hiding the video");
			//video fades without delay
			//kill the video immediately
			disableAllButtons();
			flv_timer.reset();
			flvPlayer.killVideo(false);
			clearTitleCards();
			TweenMax.to(title_card, 0.0, {autoAlpha:0.0});
			TweenMax.to(customPlayer, 0.5, {autoAlpha:0.0, onComplete:finishHide});
			
		}
		//
		private function finishHide():void
		{
			//resets so there are not buttons
			removeAllButtons();
			
			//start the blood transition once it finished it will call the finish hide
			blood_transition.backward();
			blood_transition.addEventListener(BloodEvent.BACK_COMPLETE, superFinishHide);
			
		}
		//
		private function superFinishHide(e:BloodEvent):void
		{
			//don't listen for this complete anymore
			blood_transition.removeEventListener(BloodEvent.BACK_COMPLETE, superFinishHide);
			
			//hide the big guys so doesn't block buttons
			visible = false;
			
			//THIS DISPATCH IS FOR OPTIMIZING PERFORMANCE REGARDING THE ARTIFACTS
			dispatchEvent(new BloodEvent(BloodEvent.ENGAGE_ARTIFACTS));
		}
		
		public function forceClose():void
		{
			blood_transition.reset();
		}
		
		public function stop():void
		{
			flvPlayer.stop();
		}
		
		public function pause():void
		{
			//trace("pausing video");
			if(flv_timer.running)
			{
				flv_timer.stop();
				flv_timer_was_running = true;
				
			}
			flvPlayer.pause();
		}
		public function play():void
		{
			//trace("unpausing video");
			if(flv_timer_was_running)
			{
				flv_timer.start();
				flv_timer_was_running = false;
			}
			flvPlayer.unpause();
		}
		
		//changes the media player content
		public function update(btn_on:MediaPlayerButtonView, btn_off:MediaPlayerButtonView):void
		{
			flv_timer.reset();
			flvPlayer.killVideo();
			if(btn_on != btn_off){
				btn_on.on();
				btn_off.off();
				//trace("loading " + btn_on.path);
				flv_media = btn_on.path;
				loadMedia(btn_on.id);
			}
		}
	}
}