package mrflvhead.events

{

import flash.events.Event;

public class ScrubEvent extends Event
{
	public static const DEFAULT_NAME:String = "mrflvhead.events.ScrubEvent";
	
	// event constants
	public static const ON_SCRUB_HERE:String = "onScrubHere";
	
	public var params:Object;

    public function ScrubEvent($type:String, $params:Object, $bubbles:Boolean = false, $cancelable:Boolean = false)
    {
        super($type, $bubbles, $cancelable);
        this.params = $params;
    }

    public override function clone():Event
    {
        return new ScrubEvent(type, this.params, bubbles, cancelable);
    }
   
    public override function toString():String
    {
        return formatToString("ScrubEvent", "params", "type", "bubbles", "cancelable");
    }
}

}


