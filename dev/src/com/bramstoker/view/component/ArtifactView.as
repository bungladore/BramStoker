/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/10/11 
* Class to manage the animation and state of individual artifacts
* Assets are pulled form the libraty libaray assets.swc
*/
package com.bramstoker.view.component
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.model.ArtifactModel;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ArtifactView extends Sprite
	{
		
		private var artifact_mc:MovieClip;
		private var splot:MovieClip;
		//private var fake_text:Sprite;
		private var highlight:MovieClip;
		public var tab:MovieClip;
		public var page:MovieClip;
		public var hit:MovieClip;
		private var fake:Sprite;
		
		private var targety:Number;
		private var starty:Number;
		public var origy:Number;
		public var origx:Number;
		private var minY:Number;
		private var maxY:Number;
		private var doc_drag:Sprite;
		public var doc:Sprite;
		private var _id:Number;
		public var drag_tab:Sprite;
		public var title:String;
		public var origy_tab:Number;
		private var origx_tab:Number;
		
		private var _artifacts_id:Array = ["Sunlight", "Reflection", "Sexual Power", "Native Soil",
			"Garlic", "Contagion", "Immortality", "Wooden Stake",
			"Holy Symbols", "Blood Sucking", "Invitation", "Shape Shifting"
		];
		
		public function ArtifactView(artifact:MovieClip, section_id:Number)
		{
			//attach the page
			artifact_mc = artifact;
			addChild(artifact_mc);
			
			//set the movieclips and sprites to private var in the page
			tab = artifact_mc.tab;
			splot = artifact_mc.artifact.splot;
			highlight = artifact_mc.artifact.highlight;
			page = artifact_mc.artifact;
			doc = artifact_mc.artifact.doc;
			drag_tab = artifact_mc.artifact.drag_tab;
			origy = 0;

			//
			page.mouseEnabled = false;
			doc.mouseEnabled = false;
			
			doc_drag = artifact_mc.artifact.doc_drag;
			hit = artifact_mc.hit;
			
			drag_tab.visible = false;
			drag_tab.mouseEnabled = false;
			
			//sets the section id text
			title = _artifacts_id[section_id];// + section_id;
			_id = section_id;
			
			//sets variables for resetting and containing scrolling
			//origy = page.y;
			//maxY = tab.y;
			//minY = tab.y - page.height + 100;
			
			addMouseListeners();
			//trace("PAGE Y" + page.y);
			
			reset();
		}
		
		/*
		*	sets all the document parts back to their original state
		*/
		private function reset():void
		{
			//TweenMax.to(splot, 0.0, {autoAlpha:0.0});
			//fake_text.alpha = 0.2;
			TweenMax.to(highlight, 0.0, {autoAlpha:1.0});
			highlight.gotoAndStop(1);
			//splot.gotoAndStop(1);
			page.y = origy;
			
			//trace(page.y, " ", origy, " ", starty);
		}
		
		/*
		*	adds listeners for tabs and blood spots
		*/
		private function addMouseListeners():void
		{
			/*tab.addEventListener(MouseEvent.MOUSE_UP, enableArtifact, false, 0, true);
			tab.mouseChildren = false;
			tab.buttonMode = true;*/
			
			splot.addEventListener(MouseEvent.MOUSE_DOWN, showVideo, false, 0, true);
			splot.buttonMode = true;
			
			//page.mouseEnabled = false;
			
			doc_drag.buttonMode = true;
		}
		
		/*
		*	dispatch the tab and media clicked event to the mediator
		*/
		//private function enableArtifact(e:MouseEvent):void
		//{
		//	dispatchEvent(new ArtifactEvent(ArtifactEvent.CHANGE_ARTIFACT, true));
		//}
		private function showVideo(e:MouseEvent):void
		{
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.SHOW_VIDEO, true);
			ae.currentArtifact = this;
			dispatchEvent(ae);
		}
		
		/*
		* 	handle drag even within the artifact
		*/
		private function doDrag(e:MouseEvent):void
		{

			//follow the mouse movement on the page/artfiact
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragMe, false, 0, true);
			//set so no matter where the user lifts the page stops dragging
			stage.addEventListener(MouseEvent.MOUSE_UP, noDrag, false, 0, true);
			//set the start position for our page
			starty = stage.mouseY - page.y;
			
			//origx_tab = tab.x;
			//page.addChildAt(tab, 0);
			//tab.y = origy_tab - origy;
			//tab.x = origx_tab - origx;
			
			//
			TweenMax.to(highlight, 0.5, {alpha:0.0});
			//
			/*var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.DRAG_ARTIFACT, true);
			ae.currentArtifact = this;
			dispatchEvent(ae);*/
		}
		/*
		* 	handles the page movement
		*/
		private function dragMe(e:MouseEvent):void
		{
			targety = stage.mouseY - starty;
			
			/*if(targety <= minY)
			{
				targety = minY;
			}else if(targety >= maxY){
				targety = maxY;
			}*/
			
			TweenMax.to(page, 0.5, {y:targety, onUpdate:setTab});
		}
		private function setTab():void
		{
			tab.y = origy_tab + page.y - origy;
			//tab.x = origx_tab + page.x;
		}
		/*
		* 	stops dragging and slide document into position
		*/
		private function noDrag(e:MouseEvent):void
		{
			//trace("NO DRAG");
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragMe);
			stage.removeEventListener(MouseEvent.MOUSE_UP, noDrag);
			targety = origy;
			TweenMax.to(page, 0.5, {y:targety, onComplete:noDragComplete, onUpdate:setTab});
			TweenMax.to(highlight, 0.5, {alpha:1.0, delay:0.5});
			//
			/*var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.STOP_DRAG_ARTIFACT, true);
			ae.currentArtifact = this;
			dispatchEvent(ae);*/
		}
		private function noDragComplete():void
		{
			//artifact_mc.addChildAt(tab, 0);
			tab.y = origy_tab;
			//tab.x = origx_tab;
		}
		
		/*
		*	enables this tab clicked
		*/
		public function enable():void
		{
			//trace("ENABLED");
			//sets the tab to the gray
			tab.gotoAndStop(2);
			tab.y = origy_tab;
		}

		//completes enable animation
		public function completeEnable():void
		{
			//TweenMax.to(fake_text, 0.5, {alpha:0.2, delay:0.5});
			//TweenMax.to(splot, 0.0, {alpha:1.0, delay:1.0, onComplete:function():void{splot.gotoAndPlay(2);}});
			//TweenMax.to(splot
			
			//TweenMax.to(highlight, 0.5, {autoAlpha:1.0, delay:0.5});
			highlight.gotoAndPlay(2);
			//enables dragging
			doc_drag.addEventListener(MouseEvent.MOUSE_DOWN, doDrag, false, 0, true);
			doc_drag.buttonMode = true;
			
			drag_tab.visible = true;
			
			
		}
		//disables this tab clicked
		public function disable():void
		{
			//kill all tweens running
			TweenMax.killAll();
			
			//set the tab to white
			tab.gotoAndStop(1);
			
			//reenables the tab mouse listeners
			//tab.addEventListener(MouseEvent.MOUSE_UP, enableArtifact, false, 0, true);
			//tab.buttonMode = true;
			
			//removes dragging capability
			doc_drag.removeEventListener(MouseEvent.MOUSE_DOWN, doDrag);
			doc_drag.buttonMode = false;
			
			drag_tab.visible = false;
			
			//set this document to it's inactive state
			reset();
		}
		
		/*
		*	returns the id, used to update the titles
		*/
		public function get id():Number
		{
			return _id;
		}
	}
}