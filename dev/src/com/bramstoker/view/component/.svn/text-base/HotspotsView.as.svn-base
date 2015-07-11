package com.bramstoker.view.component
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.view.component.ArtifactView;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	public class HotspotsView extends Sprite
	{
		private var currentArtifact:ArtifactView;
		private var holder:Sprite;
		private var hotspots_arr:Array;
		private var hotspots_dic:Dictionary;
		private var artifacts_arr:Array;
		private var hotspots:Hotspots;
		private var prev_hotspot:Sprite;
		
		public function HotspotsView()
		{
			super();
		}
		
		public function createChildren(art_arr:Array):void
		{

			//trace("creating hotspots children");
			artifacts_arr = art_arr;
			//trace("we got a length of " + artifacts_arr.length);
			
			hotspots = new Hotspots();
			addChild(hotspots);
			hotspots.x = 610;
			hotspots.y = -720;
			
			hotspots_arr = [hotspots.hotspot1, hotspots.hotspot2, hotspots.hotspot3, hotspots.hotspot4, hotspots.hotspot5, hotspots.hotspot6,
				hotspots.hotspot7, hotspots.hotspot8, hotspots.hotspot9, hotspots.hotspot10, hotspots.hotspot11, hotspots.hotspot12];
			hotspots_dic = new Dictionary();
			
			//populate our dictionary look up so we can display the right layout
			for(var i:uint = 0; i<hotspots_arr.length; i++)
			{
				hotspots_dic[hotspots_arr[i]] = [artifacts_arr[i], (i)];
				hotspots_arr[i].addEventListener(MouseEvent.MOUSE_DOWN, doUp);
				hotspots_arr[i].buttonMode = true;
			}
		}
		public function showAll():void
		{
			if(prev_hotspot)
			{
				prev_hotspot.visible = true;
			}
			hotspots.gotoAndStop(1);
			show();
		}
		
		private function doUp(e:MouseEvent):void
		{
			
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT);
			ae.currentArtifact = hotspots_dic[e.currentTarget][0];
			//trace("FROM HOTSPOTS " + ae.currentArtifact);
			if(prev_hotspot)
			{
				prev_hotspot.visible = true;
			}
			e.currentTarget.visible = false;
			prev_hotspot = Sprite(e.currentTarget);
			dispatchEvent(ae);
			hotspots.gotoAndStop((hotspots_dic[e.currentTarget][1] + 1));
			hide();
			
		}
		public function hide():void
		{
			visible = false;
		}
		public function show():void
		{
			visible = true;
		}
	}
}