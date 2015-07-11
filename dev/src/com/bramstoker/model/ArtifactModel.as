/*
* Created by Jed Bursiek (jed@moodrobot.com) - 06/01/11 
* ArtficatModel handles the management of artifact states. 
* Currently controls the auto pilot for random selection and display of artifacts. 
* (I MAY ABSTRACT THE AUTO CAPABILITY INTO IT'S OWN CLASS - CONTROLLER)
*/
package com.bramstoker.model
{
	import com.bramstoker.controller.events.ArtifactEvent;
	import com.bramstoker.controller.events.MediaPlayerEvent;
	import com.bramstoker.view.component.ArtifactView;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ArtifactModel extends Actor
	{
		private var _currentArtifact:ArtifactView;
		private var _previousArtifact:ArtifactView;
		private var _artifactsArr:Array;
		private var _autoTimer:Timer;
		private var _videoShowTimer:Timer;
		private var _videoHideTimer:Timer;
		private var _videoToggle:Number;
		
		
		public function get previousArtifact():ArtifactView
		{
			//returns the current artifact
			return _previousArtifact;
		}
		
		/*
		*	fired once at the beginning of the application... sets a default
		*/
		public function init(artifact_arr:Array):void
		{
			//returns the current artifact
			_artifactsArr = artifact_arr;
			_currentArtifact = artifact_arr[0];
			//trace(_currentArtifact);
			
			//timer for auto picking an artifact
			_autoTimer = new Timer(3000, 0);
			_autoTimer.addEventListener(TimerEvent.TIMER, randomArtifact);
			
			//timer for auto diplaying the video
			_videoShowTimer = new Timer(3000, 1);
			_videoShowTimer.addEventListener(TimerEvent.TIMER, showVideo);
			
			//timer for auto diplaying the video
			_videoHideTimer = new Timer(12000, 1);
			_videoHideTimer.addEventListener(TimerEvent.TIMER, hideVideo);
			
			var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.HOTSPOTS);
			ae.artifactsArray = _artifactsArr;
			//trace("length of the array " + _artifactsArr.length);
			dispatch(ae);
			//trace("dispatching the hotspots");
		}
		
		/*
		*	sets and selects the current artfiact
		*/
		public function get currentArtifact():ArtifactView
		{
			//returns the current artifact
			return _currentArtifact;
		}
		
		public function set currentArtifact(enable_artifact:ArtifactView):void
		{
			//set the current artifact
			_previousArtifact = currentArtifact;
			_currentArtifact = enable_artifact;
			
			//create the event update artifact
			var artifact_event:ArtifactEvent = new ArtifactEvent(ArtifactEvent.UPDATE_ARTIFACT);
			
			//set the new artifact to be updated
			artifact_event.currentArtifact = currentArtifact;
			
			//the old artifact to be disabled
			artifact_event.previousArtifact = previousArtifact;
			
			//dispatch the event to robot legs
			dispatch(artifact_event);
			//hideVideo();
		}
		
		//---------------------------- FUNCTIONS PERTAINING TO THE AUTO SELECTION OF ARTIFACTS WHEN THE USER IS IDLE ---------------------//
		
		/*
		*	this is called by the AutoPilot command when the user becomes idle
		*/
		public function autoPilot():void
		{
			_autoTimer.start();
			_previousArtifact = null;
			//hide any open video players
			//var ve:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.CLOSE);
			//dispatch(ve);
			
			//call it once to it fires without delay
			//selectRandom();
			
		}
		
		/*
		*	fired by the autoTimer event... picks a random artifact and resets the video timer/counter
		*/
		private function randomArtifact(e:TimerEvent):void
		{	
			selectRandom();
		}
		
		private function selectRandom():void
		{
			//selects a random artifact
			pickRandom();
			//sets timer for video display
			//_videoShowTimer.start();
			//_videoHideTimer.start();
		}
		
		/*
		*	selects a random artifact for display
		*/
		private function pickRandom():void
		{
			//pick random from array
			var random_artifact:Number = Math.floor(Math.random()*_artifactsArr.length);
			//check to see if this one is already selected
			//if(currentArtifact == _artifactsArr[random_artifact]){
				//if it is then pick again
			//	pickRandom();
			//}else{
				//set a ranndom artifact
				var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.ADD_TO_TOP);
				//trace("HERE's a RANDOM ONE" + _artifactsArr[random_artifact]);
				ae.randomArtifact = _artifactsArr[random_artifact];
				dispatch(ae);
			//}
		}
		
		/*
		*	dispatch video events for auto hide/show
		*/
		private function showVideo(e:TimerEvent):void
		{
			//var ae:ArtifactEvent = new ArtifactEvent(ArtifactEvent.SHOW_VIDEO);
			//ae.currentArtifact = _currentArtifact;
			//dispatch(ae);
		}
		//displays and then hides the video 
		private function hideVideo(e:TimerEvent = null):void
		{
			//var ve:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.CLOSE);
			//dispatch(ve);
		}
		
		//----------------------------- CLEARS THE TIMERS TO RESUME MANUAL/TOUCH INTERACTION ----------------------------//
		/*
		*	resets all timers to 0 and stops
		*/
		public function manual():void
		{
			_autoTimer.reset();
			//_videoShowTimer.reset();
			//_videoHideTimer.reset();

		}
	}
}