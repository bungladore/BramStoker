package com.bramstoker.view.component
{
	import com.bramstoker.controller.events.NavigationEvent;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TopNavigationView extends Sprite
	{
		private var helpBtn:HelpBtn;
		private var creditsBtn:CreditsBtn;
		private var help1:Help1;
		private var help2:Help2;
		private var credits:Credits;
		
		public function TopNavigationView()
		{
			helpBtn = new HelpBtn();
			creditsBtn = new CreditsBtn();
			
			addChild(helpBtn);
			addChild(creditsBtn);
			
			help1 = new Help1();
			help1.addEventListener(MouseEvent.MOUSE_DOWN, closeHelp, false, 0, true);
			
			help2 = new Help2();
			help2.addEventListener(MouseEvent.MOUSE_DOWN, closeHelp, false, 0, true);
			
			credits = new Credits();
			credits.addEventListener(MouseEvent.MOUSE_DOWN, closeCredits, false, 0, true);
			
			addChild(help1);
			addChild(help2);
			addChild(credits);
			
			credits.alpha = help2.alpha = help1.alpha = 0;
			credits.visible = help2.visible = help1.visible = false
			
			helpBtn.x = 58;
			creditsBtn.x = 137;
			
			helpBtn.y = 1036;
			creditsBtn.y = 1036;
			
			initMouseListeners();
		}
		public function enable():void
		{
			initMouseListeners();
		}
		public function disable():void
		{
			disableMouseListeners();
		}
		private function closeCredits(e:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.CLOSE_CREDITS));
		}
		
		private function closeHelp(e:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.CLOSE_HELP));
		}
		
		private function initMouseListeners():void
		{
			trace("ENABLE MOUSE LISTENERS FOR TOP NAVIGATION");
			helpBtn.addEventListener(MouseEvent.MOUSE_DOWN, getHelp, false, 0, true);
			//helpBtn.buttonMode = true;
			creditsBtn.addEventListener(MouseEvent.MOUSE_DOWN, getCredits, false, 0, true);
			//creditsBtn.buttonMode = true;
		}
		
		private function disableMouseListeners():void
		{
			trace("DISABLE MOUSE LISTENERS FOR TOP NAVIGATION");
			helpBtn.removeEventListener(MouseEvent.MOUSE_DOWN, getHelp);
			//helpBtn.buttonMode = true;
			creditsBtn.removeEventListener(MouseEvent.MOUSE_DOWN, getCredits);
			//creditsBtn.buttonMode = true;
		}
		
		public function hide():void
		{
			visible = false;
		}
		
		public function show():void
		{
			visible = true;
		}
		
		public function showHelp1(num:Number):void
		{
			//if media player is active
			//else
			help1.gotoAndStop(num);
			TweenMax.to(help1, 0.5, {autoAlpha:1.0});
		}
		
		public function showHelp2():void{
			TweenMax.to(help2, 0.5, {autoAlpha:1.0});
		}
		
		public function showCredits():void
		{
			TweenMax.to(credits, 0.5, {autoAlpha:1.0});
		}
		
		public function hideHelp():void
		{
			TweenMax.to(help1, 0.5, {autoAlpha:0.0});
			TweenMax.to(help2, 0.5, {autoAlpha:0.0});
		}
		
		public function hideCredits():void
		{
			TweenMax.to(credits, 0.5, {autoAlpha:0.0});
		}
		
		private function getHelp(e:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.SHOW_HELP));
		}
		private function getCredits(e:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.SHOW_CREDITS));	
		}
	}
}