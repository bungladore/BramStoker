package com.bramstoker.controller.commands
{
	import com.bramstoker.model.XMLLayoutModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class XMLLayoutCommand extends Command
	{
		[Inject]
		public var xmlLayoutModel:XMLLayoutModel;
		
		[Inject(name="layoutXML")]
		public var xml_data:XML;
		
		override public function execute():void
		{
			//sets the current artfact with the new artifact clicked
			xmlLayoutModel.xml = xml_data;
			
		}
	}
}