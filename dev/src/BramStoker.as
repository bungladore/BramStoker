package
{
	import com.bramstoker.MainContext;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import net.hires.debug.Stats;
	import flash.events.ErrorEvent;
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import mx.controls.Alert;
	import flash.desktop.NativeApplication;
	
	/**
	 * @author angrybuddha
	 */
	
	[SWF( width='1920', height='1080', frameRate='30', backgroundColor='#8F8C8D' )]
		
	public class BramStoker extends Sprite
	{
		private var main_context:MainContext;
		private var toggle_mouse:Boolean = true;
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function BramStoker()
		{
			
			//checks for updates on the server
			//checkForUpdate();
			
			this.scrollRect = new Rectangle(0, 0, 1920, 1080);
			
			var border:Sprite = new Sprite();
			border.graphics.beginFill(0xFFFFFF, 1.0);
			border.graphics.drawRect(0, 0, 1920, 1080);
			border.graphics.endFill();
			addChild(border);
			
			main_context = new MainContext(this);
			
			/*var border:Sprite = new Sprite();
			border.graphics.beginFill(0x000000, 0.0);
			border.graphics.lineStyle(20, 0x8F8C8D);
			border.graphics.drawRect(0, 0, 1960, 1120);
			
			border.graphics.endFill();
			addChild(border);*/
			
			stage.addEventListener(KeyboardEvent.KEY_UP, toggleMouse);
			
			//var stats:Stats = new Stats();
			//addChild(stats);
			
			doFullScreen();
			Mouse.hide();	// **********************
			
		}
		
		private function checkForUpdate():void {
			setApplicationVersion(); // Find the current version so we can show it below
			appUpdater.updateURL = "http://www.angrybuddha.com/bwco/update.xml"; // Server-side XML file describing update
			appUpdater.isCheckForUpdateVisible = false; // We won't ask permission to check for an update
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate); // Once initialized, run onUpdate
			appUpdater.addEventListener(ErrorEvent.ERROR, onError); // If something goes wrong, run onError
			appUpdater.initialize(); // Initialize the update framework
		}
		
		private function onError(event:ErrorEvent):void {
			Alert.show(event.toString());
		}
		
		private function onUpdate(event:UpdateEvent):void {
			appUpdater.checkNow(); // Go check for an update now
		}
		
		// Find the current version for our Label below
		private function setApplicationVersion():void {
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXML.namespace();
		}
		
		//UTILITY FUNCTIONS---------------
		private function doFullScreen():void
		{
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		private function toggleMouse(e:KeyboardEvent):void
		{
			
			if(e.keyCode == 77){
				if(toggle_mouse){
					Mouse.hide();
					toggle_mouse = false;
				}else{
					Mouse.show();
					toggle_mouse = true;
				}
			}		
		}
	}
}