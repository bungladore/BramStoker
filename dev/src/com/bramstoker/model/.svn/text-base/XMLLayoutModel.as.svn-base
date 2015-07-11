package com.bramstoker.model
{
	import com.bramstoker.controller.events.ArtifactEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class XMLLayoutModel extends Actor
	{
		private var _xml:XML;
		public function XMLLayoutModel()
		{
			super();
		}
		
		public function get xml():XML
		{
			//returns the current artifact
			return _xml;
		}
		
		public function set xml(xml_data:XML):void
		{
			//returns the current artifact
			_xml = xml_data;
			dispatch(new ArtifactEvent(ArtifactEvent.LAYOUT_READY));
			//trace(xml_data);
		}
	}
}
