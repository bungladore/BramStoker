package com.bramstoker.view.component
{
	
	import com.bramstoker.controller.events.BloodEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class BloodTransition extends Sprite
	{
		
		private var image_path:String = "images/inkblot/";	
		private var current:Sprite;
		private var previous:Sprite;
		private var inkblot_arr:Array = [];
		private var loader:Loader;
		private var dir:Number = 1;
		private var pointer:Number = 0;
		private var quick_set:Array = ["inkblot1_00000.png", "inkblot1_00001.png", 
									   "inkblot1_00002.png", "inkblot1_00003.png",
									   "inkblot1_00004.png", "inkblot1_00005.png",
									   "inkblot1_00006.png", "inkblot1_00007.png", 
									   "inkblot1_00008.png", "inkblot1_00009.png",
									   "inkblot1_00010.png", "inkblot1_00011.png", 
									   "inkblot1_00012.png", "inkblot1_00013.png",
									   "inkblot1_00014.png", "inkblot1_00015.png",
									   "inkblot1_00016.png", "inkblot1_00017.png",
									   "inkblot1_00018.png", "inkblot1_00019.png",
									   "inkblot1_00020.png",
									   "inkblot2_00000.png", "inkblot2_00001.png", 
									   "inkblot2_00002.png", "inkblot2_00003.png",
									   "inkblot2_00004.png", "inkblot2_00005.png",
									   "inkblot2_00006.png", "inkblot2_00007.png", 
									   "inkblot2_00008.png", "inkblot2_00009.png",
									   "inkblot2_00010.png", "inkblot2_00011.png", 
									   "inkblot2_00012.png", "inkblot2_00013.png",
									   "inkblot2_00014.png", "inkblot2_00015.png",
									   "inkblot2_00016.png", "inkblot2_00017.png",
									   "inkblot2_00018.png", "inkblot2_00019.png",
									   "inkblot2_00020.png",
									   "inkblot3_00000.png", "inkblot3_00001.png", 
									   "inkblot3_00002.png", "inkblot3_00003.png",
									   "inkblot3_00004.png", "inkblot3_00005.png",
									   "inkblot3_00006.png", "inkblot3_00007.png", 
									   "inkblot3_00008.png", "inkblot3_00009.png",
									   "inkblot3_00010.png", "inkblot3_00011.png", 
									   "inkblot3_00012.png", "inkblot3_00013.png",
									   "inkblot3_00014.png", "inkblot3_00015.png",
									   "inkblot3_00016.png", "inkblot3_00017.png",
									   "inkblot3_00018.png", "inkblot3_00019.png",
									   "inkblot3_00020.png",
									   "inkblot4_00000.png", "inkblot4_00001.png", 
									   "inkblot4_00002.png", "inkblot4_00003.png",
									   "inkblot4_00004.png", "inkblot4_00005.png",
									   "inkblot4_00006.png", "inkblot4_00007.png", 
									   "inkblot4_00008.png", "inkblot4_00009.png",
									   "inkblot4_00010.png", "inkblot4_00011.png", 
									   "inkblot4_00012.png", "inkblot4_00013.png",
									   "inkblot4_00014.png", "inkblot4_00015.png",
									   "inkblot4_00016.png", "inkblot4_00017.png",
									   "inkblot4_00018.png", "inkblot4_00019.png",
									   "inkblot4_00020.png",
									   "inkblot5_00000.png", "inkblot5_00001.png", 
									   "inkblot5_00002.png", "inkblot5_00003.png",
									   "inkblot5_00004.png", "inkblot5_00005.png",
									   "inkblot5_00006.png", "inkblot5_00007.png", 
									   "inkblot5_00008.png", "inkblot5_00009.png",
									   "inkblot5_00010.png", "inkblot5_00011.png", 
									   "inkblot5_00012.png", "inkblot5_00013.png",
									   "inkblot5_00014.png", "inkblot5_00015.png",
									   "inkblot5_00016.png", "inkblot5_00017.png",
									   "inkblot5_00018.png", "inkblot5_00019.png",
									   "inkblot5_00020.png"
										];
		private var count:Number;
		private var forward_timer:Timer;
		private var backward_timer:Timer;
		private var delay_timer:Timer;
		private var ink_bmp:Bitmap;
		private var ink_bmd:BitmapData;
		private var time:Number = 21;
		private var version:Number = 5;
		
		public function BloodTransition()
		{
			init();
		}
		//
		private function init():void
		{	
			
			count = 0;
			forward_timer = new Timer(30, 0);
			forward_timer.addEventListener(TimerEvent.TIMER, playF);
			
			backward_timer = new Timer(30, 0);
			backward_timer.addEventListener(TimerEvent.TIMER, playR);
			
			//delay_timer = new Timer(500, 1);
			//delay_timer.addEventListener(TimerEvent.TIMER, delayCompleteCall);
			
			ink_bmp = new Bitmap(ink_bmd);
			ink_bmd = new BitmapData(1920, 1080, true);
			addChild(ink_bmp);
			loadNext();
			
		}
		//
		public function forward():void
		{
			//forward_timer.reset();
			dir = 1;
			//generates a random number between 0 and 1
			pointer = pointer + 1;//pickRandom();//Math.floor(Math.random()*version);
			if(pointer > 4)
			{
				pointer = 0;
			}
			//trace("RANDOM POINTER " + pointer);
			//trace("Forwards " + pointer);
			//sets the count to this number multiplied by the number of frames
			count = pointer*time + 1;
			forward_timer.start();
		}
		
		private function pickRandom():Number
		{
			var random:Number = Math.floor(Math.random()*version);
			if(pointer == random)
			{
				pickRandom();
			}
			return random;
		}
		
		public function backward():void
		{
			//backward_timer.reset();
			dir = -1;
			count = (pointer + 1)*time - 1;
			//trace("Backwards " + pointer);
			backward_timer.start();
		}
		//
		public function reset():void
		{
			
			//trace("RESET");
			count = 0;
			ink_bmp.bitmapData = inkblot_arr[0];
			//forward_timer.reset();
		}
		
		private function playF(e:TimerEvent):void
		{
			
			ink_bmp.bitmapData = inkblot_arr[count];
			//trace("PLAYING THIS FRAME FORWARD " + count, time);
			count+=dir;
			//trace("count " + count);
			//count can only be zero on the way back because of the += 
			if(count >= (pointer+1)*time){
				//trace("RESET BLOOD SPURT");
				//reset();
				//delay_timer.start();
				forward_timer.stop();
				dispatchEvent(new BloodEvent(BloodEvent.FORWARD_COMPLETE));
			}
		}
		//
		private function playR(e:TimerEvent):void
		{
			
			ink_bmp.bitmapData = inkblot_arr[count];
			//trace("PLAYING THIS FRAME REVERSE " + count);
			count+=dir;
			//trace("count " + count);
			//count can only be zero on the way back because of the += 
			if(count < (pointer*time-1)){
				//trace("back complete");
				backward_timer.stop();
				reset();
				dispatchEvent(new BloodEvent(BloodEvent.BACK_COMPLETE, true));
				//delay_timer.start();
			}
		}
		//plays once to fire the engage all artifacts call -- heavy call so needs delay to fire alone
		//private function delayCompleteCall(e:TimerEvent):void
		//{
		//	dispatchEvent(new BloodEvent(BloodEvent.BACK_COMPLETE));
		//}
		
		//calls to loads a single image
		private function loadNext():void
		{
			if(count < quick_set.length){
				//trace("loading " + image_path + quick_set[count]);
				loadImage(image_path + quick_set[count]);
				count++;
			}else{
				count = 0;
				//trace("FINISHED LOADING ALL BLOOD IMAGES");
				dispatchEvent(new BloodEvent(BloodEvent.BLOOD_LOADED, true));
			}
			
		}
		//loads the image
		private function loadImage(path:String):void
		{
			loader = null;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, bloodTransitionIOError, false, 0, true );
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.load(new URLRequest(path));
		}
		
		private function bloodTransitionIOError( e:IOErrorEvent ) :void {
			trace("** bloodTransitionIOError: Could not load", e);
		}
		
		//adds the image to the bitmap data array
		private function loadComplete(e:Event):void
		{
			var ink_data:BitmapData = new BitmapData(1920, 1080, true, 0x000000);
			//trace(loader.content);
			ink_data.draw(loader.content);
			
			inkblot_arr.push(ink_data);
			loadNext();
		}
	}
}