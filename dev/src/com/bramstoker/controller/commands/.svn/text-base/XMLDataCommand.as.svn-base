package com.bramstoker.controller.commands
{
	import com.bramstoker.model.XMLDataModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class XMLDataCommand extends Command
	{
		[Inject]
		public var xmlDataModel:XMLDataModel;
		
		[Inject(name="dataXML")]
		public var xml_data:XML;
		
		override public function execute():void
		{
			//sets the current artfact with the new artifact clicked
			//trace(xml_data);
			xmlDataModel.xml = xml_data;
			
		}
	}
}