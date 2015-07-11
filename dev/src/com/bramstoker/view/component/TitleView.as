/*
 * Created by Jed Bursiek - 06/10/11 
 * Class to manages the title assets for the bram stoker manuscript application.
 * Assets are pulled form the libraty libaray assets.swc
 */
package com.bramstoker.view.component
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//import mx.containers.Tile;
	
	public class TitleView extends Sprite
	{
		private var title_holder:Title;
		private var instruction:Instruction;
		private var kern_field:TextField;
		
		public function TitleView()
		{
			//attaches the title art from the assets swc
			title_holder = new Title();
			addChild(title_holder);
			title_holder.y = 546;
			title_holder.x = -2;
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.letterSpacing = 2;
			title_holder.title.defaultTextFormat = titleFormat;
			
			var contentFormat:TextFormat = new TextFormat();
			contentFormat.letterSpacing = 0.5;
			contentFormat.leading = 3;
			contentFormat.italic = true;
			title_holder.content.defaultTextFormat = contentFormat;

			//title.scaleX = title.scaleY = 3;
			
			instruction = new Instruction();
			addChild(instruction);
			instruction.x = -85;
			instruction.y = 650;
		
		}
		//updates the title
		public function update(xml:XMLList):void
		{
			//trace("TITLE VIEW XML DATA " + xml);
			var title_str:String = xml.@title;
			title_str = title_str.toUpperCase();
			
			title_holder.title.text = title_str;
			//title_holder.title.l
			title_holder.flag.x = title_holder.title.textWidth - 455;
			
			title_holder.content.embedFonts = true;
			title_holder.content.multiline = true;
			title_holder.content.wordWrap = true;
			title_holder.content.htmlText = xml.content[0];
			title_holder.content.alpha = 0;
			showTitle();
			TweenMax.to(title_holder.content, 0.5, {alpha:1.0});
			hideInstruct();
			//title.gotoAndStop(id);
		}
		//shows the instructions
		public function showInstruct():void
		{
			instruction.visible = true;
		}
		//hides the instructions
		public function hideInstruct():void
		{
			instruction.visible = false;
		}
		public function hideTitle():void
		{
			title_holder.visible = false;
		}
		public function showTitle():void
		{
			title_holder.visible = true;
		}
		//hides the initialize window
		public function hideInit():void
		{
			
		}
	}
}