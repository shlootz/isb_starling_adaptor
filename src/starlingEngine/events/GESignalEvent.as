package starlingEngine.events 
{
import bridge.abstract.events.IAbstractSignalEvent;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class GESignalEvent implements IAbstractSignalEvent
	{
		
		private var _eventName:String;
		private var _engineEvent:Object;
		private var _params:Object;
		
		public function GESignalEvent() 
		{
			
		}
		
		public function set eventName(val:String):void
		{
			_eventName = val;
		}
		
		public function get eventName():String 
		{
			return _eventName;
		}
		
		public function set engineEvent(val:Object):void
		{
			_engineEvent = val;
		}
		
		public function get engineEvent():Object 
		{
			return _engineEvent;
		}
		
		public function set params(val:Object):void
		{
			_params = val;
		}
		
		public function get params():Object
		{
			return _params;
		}
		
	}

}