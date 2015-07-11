package com.bramstoker.view.component
{
	import com.bramstoker.MainContext;
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.view.component.ArtifactView;
	import com.google.analytics.debug._Style;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	public class ArtifactContainerView extends Sprite
	{
		private var currentArtifact:ArtifactView;
		private var artifacts_arr:Array;
		private var fake_artifacts:Bitmap;
		private var fake_artifacts_bmd:BitmapData;
		private var holder:Sprite;
		private var hotspots_arr:Array;
		private var hotspots_dic:Dictionary;
		private var contextView:MainContext;
		private var first:Boolean = true;
		private var counter:Number;
		private var layout_xml:XMLList;
		private var new_artifact:ArtifactView;
		private var bg:FakeBG;
		
		public function ArtifactContainerView()
		{
			super();
		}
		public function createChildren():void
		{
			bg = new FakeBG();
			addChild(bg);
			
			holder = new Sprite();
			addChild(holder);
			//holder.x = -100;
			
			//add all the artifacts and default the first section
			var art_01:ArtifactView = new ArtifactView(new Page01, 0);
			holder.addChild(art_01);

			//
			var art_02:ArtifactView = new ArtifactView(new Page02, 1);
			holder.addChild(art_02);

			//
			var art_03:ArtifactView = new ArtifactView(new Page03, 2);
			holder.addChild(art_03);

			//
			var art_04:ArtifactView = new ArtifactView(new Page04, 3);
			holder.addChild(art_04);

			//
			var art_05:ArtifactView = new ArtifactView(new Page05, 4);
			holder.addChild(art_05);

			//
			var art_06:ArtifactView = new ArtifactView(new Page06, 5);
			holder.addChild(art_06);

			//
			var art_07:ArtifactView = new ArtifactView(new Page07, 6);
			holder.addChild(art_07);

			//
			var art_08:ArtifactView = new ArtifactView(new Page08, 7);
			holder.addChild(art_08);

			//
			var art_09:ArtifactView = new ArtifactView(new Page09, 8);
			holder.addChild(art_09);

			//
			var art_10:ArtifactView = new ArtifactView(new Page10, 9);
			holder.addChild(art_10);

			//
			var art_11:ArtifactView = new ArtifactView(new Page11, 10);
			holder.addChild(art_11);

			//
			var art_12:ArtifactView = new ArtifactView(new Page12, 11);
			holder.addChild(art_12);

			
			artifacts_arr = [art_01, art_02, art_03, art_04, art_05, art_06, art_07, art_08, art_09, art_10, art_11, art_12];
			//artifacts_arr = [art_01, art_12];
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				artifacts_arr[i].x = 610;
				artifacts_arr[i].y = -720;
			}
			
			//update the model so it knows which section is first
			var ready_event:ArtifactEvent = new ArtifactEvent(ArtifactEvent.READY);
			ready_event.artifactsArray = artifacts_arr;
			dispatchEvent(ready_event);
			
			//addEventListener(ArtifactEvent.DRAG_ARTIFACT, dragFake);
			//addEventListener(ArtifactEvent.STOP_DRAG_ARTIFACT, dragFake);
			
			initFake();
			
			//for performance... we are only showing the top artifact, the rest will be fake bitmap images
			
		}
		
		public function init(_layout_xml:XMLList, art:ArtifactView = null):void
		{
			
			bg.visible = true;
			layout_xml = _layout_xml;
			if(art){
				holder.addChild(art);
			}
			sort();
			
			//TweenMax.to(holder, 0, {autoAlpha:0});
			//TweenMax.to(holder, 0.5, {autoAlpha:1.0});
			
			resetFake();
			
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				var arty:ArtifactView = artifacts_arr[i];
				arty.page.x = (Number(layout_xml.artifact.(@id==(arty.id)).@x));
				arty.page.y = (Number(layout_xml.artifact.(@id==(arty.id)).@y));
				arty.page.rotation = layout_xml.artifact.(@id==(arty.id)).@r;
				//var z_id:Number = layout_xml.artifact.(@id==(arty.id)).@z;
				holder.addChild(arty);
				//holder.swapChildrenAt(holder.getChildIndex(arty), z_id);
				
				arty.page.doc.smoothing = true;

				
				//trace("ARTY " + arty.x, arty.page.x, arty.doc.x, arty.page.y);
				//trace(holder.x, holder.y, holder.width);
				arty.tab.visible = false;
				arty.drag_tab.visible = false;

				//reset the tabs
				arty.disable();
				//
			}
			
			holder.x = -500;
			holder.y = 450;
		}
		//
		public function engage(_layout_xml:XMLList):void
		{
			bg.visible = false;
			TweenMax.killAll();
			//set thexml
			layout_xml = _layout_xml;
			//reorder them based on zindex
			sort();
			//place them
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				var arty:ArtifactView = artifacts_arr[i];
				
				var x_id:Number = layout_xml.artifact.(@id==(arty.id)).@x;
				var y_id:Number = layout_xml.artifact.(@id==(arty.id)).@y;
				var rot:Number = layout_xml.artifact.(@id==(arty.id)).@r;
				var z_id:Number = layout_xml.artifact.(@id==(arty.id)).@z;
				//
				//TweenMax.to(arty.page, 0.5, {x:x_id, y:y_id, delay:i/2});
				arty.page.y = y_id;
				arty.page.x = x_id;
				arty.page.rotation = rot;
				arty.alpha = 1.0;
				arty.visible = true;
				
				arty.page.doc.smoothing = false;
				
				//lazy public var
				arty.origy = y_id;
				arty.origx = x_id;
				//arty.page.rotation = 
				//holder.swapChildrenAt(holder.getChildIndex(arty), z_id);
				holder.addChild(arty);
				
				
				//arty.shiftPosition(x_id, y_id, rot);
				
				
				//
				arty.tab.x = layout_xml.tab.(@id==(arty.id)).@x;
				arty.tab.y = layout_xml.tab.(@id==(arty.id)).@y;
				arty.tab.rotation = layout_xml.tab.(@id==(arty.id)).@r;

				//
				arty.tab.visible = true;
				//arty.hit.visible = true;
				//
				
			}
			holder.x = 0;
			holder.y = 0;
			showFake();
		}
		//initializes a fake background for performance enhancement
		private function initFake():void
		{
			fake_artifacts = new Bitmap();
			addChild(fake_artifacts);
			//fake_artifacts.x = -100;
			
			fake_artifacts_bmd = new BitmapData(1920, 1080, true, 0x00000000);
			fake_artifacts.bitmapData = fake_artifacts_bmd;
		}

		//shows the fake background when the video transition plays
		private function showFake():void
		{
			//trace("showing fake");
			
			//copy the holder
			fake_artifacts_bmd.draw(holder);
			//show the fake version
			fake_artifacts.visible = true;
			//hide the other elements
			holder.visible = false;
			//
		}
		//shows the fake background when the video transition plays
		private function hideFake(art:ArtifactView):void
		{
			//trace("hide fake");
			//show the holder
			holder.visible = true;
			//hide the fake bitmap
			fake_artifacts.visible = false;
			//clear the fake bitmap for the next guy
			fake_artifacts_bmd.fillRect(fake_artifacts_bmd.rect, 0);
			//put the drag artifact into the holder
			holder.addChild(art);
		}
		//shows the fake background when the video transition plays
		private function resetFake():void
		{
			//trace("hide fake");
			//show the holder
			holder.visible = true;
			//hide the fake bitmap
			fake_artifacts.visible = false;
			//clear the fake bitmap for the next guy
			fake_artifacts_bmd.fillRect(fake_artifacts_bmd.rect, 0);
		}
		//
		public function enable(artifact:ArtifactView, _layout_xml:XMLList):void
		{
			//addChild(artifact);
			//holder.addChild(artifact);
			layout_xml = _layout_xml;
			//holder.addChild(artifact);
			sort();
			
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				var arty:ArtifactView = artifacts_arr[i];
				//
				
				var x_id:Number = layout_xml.artifact.(@id==(arty.id)).@x;
				var y_id:Number = layout_xml.artifact.(@id==(arty.id)).@y;
				var rot:Number = layout_xml.artifact.(@id==(arty.id)).@r;
				var z_id:Number = layout_xml.artifact.(@id==(arty.id)).@z;
				//arty.page.rotation = 
				
				//arty.doc.visible = false;
				//trace("HERE IS WHERE THE ERROR HAPPENS " + arty, artifacts_arr, artifacts_arr.length);
				holder.addChild(arty);
				//holder.swapChildrenAt(holder.getChildIndex(arty), z_id);
				/*if(z_id == 11){
					TweenMax.to(arty.page, 0.5, {x:x_id, y:y_id, rotation:rot, delay:0.1, onComplete:function():void{showFake();artifact.enable();}});
				}else if(z_id > 8){
					arty.shiftPosition(x_id, y_id, rot);
				}*/
				//
				var y_tab:Number = layout_xml.tab.(@id==(arty.id)).@y;
				
				
				arty.origy = y_id;
				arty.origx = x_id;
				
				if(i == 11){
					addChild(artifact);
					showFake();
					arty.origy_tab = y_tab;
					artifact.enable();
					TweenMax.to(arty.page, 0.5, {x:x_id, y:y_id, rotation:rot, delay:0.1, onComplete:function():void{artifact.completeEnable(); enableHotspots();}});
				}else{
					arty.page.x = x_id;
					arty.page.y = y_id;
					//arty.page.z = z_id;
					arty.page.rotation = rot;
				}
				
				arty.tab.x = layout_xml.tab.(@id==(arty.id)).@x;
				arty.tab.y = y_tab;
				arty.tab.rotation = layout_xml.tab.(@id==(arty.id)).@r;
				//
			}
		}
		public function addTop(art:ArtifactView):void
		{
			//trace("adding top " + art);
			if(art)
			{
				if(holder.getChildIndex(art) < 10){
				//trace(holder.getChildIndex(art));
				TweenMax.to(art, 0.5, {autoAlpha:0.0, onComplete:function():void{holder.addChild(art);}});
				TweenMax.to(art, 0.5, {autoAlpha:1.0, delay:0.8});
				}
			}
		}
		private function sort():void
		{
			var temp_arr:Array = new Array(12);
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				//trace("LAOYOUT " + layout_xml);
				var z_id:Number = layout_xml.artifact.(@id==(artifacts_arr[i].id)).@z;
				//trace("Z " + z_id);
				temp_arr[z_id] = artifacts_arr[i];
				////trace("HERE IS MY ARTIFACT " + artifacts_arr[i].id);
			}
			artifacts_arr = temp_arr;
			//displaySort();
		}
		private function displaySort():void
		{
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				trace(artifacts_arr[i].id);
			}
		}
		/*public function enable(_new_artifact:ArtifactView, _layout_xml:XMLList):void
		{
			//trace("enabling only");
			new_artifact = _new_artifact;
			new_artifact.enable();
			layout_xml = _layout_xml;
			counter = 0;
			sort();
			addEventListener(Event.ENTER_FRAME, adjustArtifacts);
		}
		private function sort():void
		{
			for(var i:uint=0; i<artifacts_arr.length; i++)
			{
				var z_id:Number = layout_xml.artifact.(@id==(i+1)).@z;
				artifacts_arr[z_id] = artifacts_arr[i];
			}
		}
		private function adjustArtifacts(e:Event):void
		{
			adjustOne(counter);
			counter++;
			if(counter >= artifacts_arr.length){
				removeEventListener(Event.ENTER_FRAME, adjustArtifacts);
			}
		}
		private function adjustOne(num:Number):void
		{
			var arty:ArtifactView = artifacts_arr[num];
			//
			
			var x_id:Number = layout_xml.artifact.(@id==(num+1)).@x;
			var y_id:Number = layout_xml.artifact.(@id==(num+1)).@y;
			var rot:Number = layout_xml.artifact.(@id==(num+1)).@r;
			//var z_id:Number = layout_xml.artifact.(@id==(num+1)).@z;
			
			holder.addChildAt(arty, num);
			
			if(num == 11){
				addChild(new_artifact);
				TweenMax.to(new_artifact.page, 0.5, {x:x_id, y:y_id, rotation:rot, delay:0.1, onComplete:function():void{new_artifact.completeEnable(); enableHotspots(); showFake();}});
			}else{
				arty.page.x = x_id;
				arty.page.y = y_id;
				//arty.page.z = z_id;
				arty.page.rotation = rot;
			}
			
			arty.tab.x = layout_xml.tab.(@id==(num+1)).@x;
			arty.tab.y = layout_xml.tab.(@id==(num+1)).@y;
			arty.tab.rotation = layout_xml.tab.(@id==(num+1)).@r;
			
			arty.origy = y_id;
		}*/
		
		//dispatchs event to the hotspots to reveal themselves again
		private function enableHotspots():void
		{
			dispatchEvent(new ArtifactEvent(ArtifactEvent.FINISHED_TRANSITION));
		}
		
		/*public function hide():void
		{
			showFake();
			//holder.visible = false;
		}
		
		public function show():void
		{
			//holder.visible = true;
			hideFake();
		}*/
		
		/*private function shuffle():void
		{
			for(var i:uint=0; i<5; i++)
			{
				var rand:Number = Math.floor(1 - Math.random()*2);
				TweenMax.to(artifacts_arr[i], 0.5, {rotationZ:rand});
			}
		}*/
		
		public function disable(previous:ArtifactView):void
		{
			hideFake(previous);
			previous.disable();
		}
	}
}