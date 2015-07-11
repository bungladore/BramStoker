package com.bramstoker.view.component
{
	import com.bramstoker.controller.events.MediaPlayerEvent;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	//import org.osmf.media.MediaPlayer;
	
	public class MediaPlayerButtonView extends SelectMediaButton
	{
		private var _path:String;
		private var _id:Number;
		private var _title:String;
		
		public function MediaPlayerButtonView(num:Number)
		{
			addEventListener(MouseEvent.MOUSE_DOWN, switchContent, false, 0, true);
			buttonMode = true;
			//title.text = "CLIP " + (num + 1);
			overlay.visible = false;
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.letterSpacing = 1.4;
			clip_title.defaultTextFormat = titleFormat;
			
		}
		private function switchContent(e:MouseEvent):void
		{
			var mpe:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.SWITCH_CONTENT);
			mpe.currentMedia = this;
			dispatchEvent(mpe);
		}
		public function set path(str:String):void
		{
			_path = str;
		}
		public function get path():String
		{
			return _path;	
		}
		public function set id(num:Number):void
		{
			_id = num;	
		}
		public function get id():Number
		{
			return _id;
		}
		public function set title(ct:String):void
		{
			//trace("CLIP TITLTE " + ct);
			_title = ct;
			clip_title.embedFonts = true;
			clip_title.multiline = true;
			clip_title.wordWrap = true;
			clip_title.autoSize = TextFieldAutoSize.CENTER;
			clip_title.htmlText = ct;
			clip_title.y = align.y + (align.height - clip_title.textHeight)/2 - 4;
		}
		public function get title():String
		{
			return _title;
		}
		//sets the thumbnail for the video player select media button (gray)
		public function set img_preview(str:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, imgPreviewIOError, false, 0, true );
			loader.load(new URLRequest(str));
			preview.addChild(loader);
			loader.y = 12;
			loader.x = 4;
		}
		
		private function imgPreviewIOError( e:IOErrorEvent ) :void {
			trace("** imgPreviewIOError: Could not load", e);
		}
		
		//sets the overlay image for the video button (red) on state
		public function set img_overlay(str:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, imgOverlayIOError, false, 0, true );
			loader.load(new URLRequest(str));
			overlay.addChild(loader);
			//loader.y = 12;
			loader.x = 0;
		}
		
		private function imgOverlayIOError( e:IOErrorEvent ) :void {
			trace("** imgOverlayIOError event:", e);
		}
		
		public function killActive():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, switchContent);
		}
		public function on():void
		{
			gotoAndStop(2);
			clip_title.textColor = 0x000000;
			overlay.visible = true;
			removeEventListener(MouseEvent.MOUSE_DOWN, switchContent);
			
		}
		public function off():void
		{
			gotoAndStop(1);
			clip_title.textColor = 0xC7C1B1;
			overlay.visible = false;
			addEventListener(MouseEvent.MOUSE_DOWN, switchContent, false, 0, true);
		}
	}
}