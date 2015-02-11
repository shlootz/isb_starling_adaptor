package starlingEngine.events 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import signals.Signals;
	/**
	 * ...
	 * @author Eu
	 */
	public class EngineDelayedDisposeSignalEvent extends GESignalEvent
	{
		
		private var _child:IAbstractDisplayObject;
		private var _parent:IAbstractDisplayObjectContainer;
		
		/**
		 * 
		 * @param	child
		 * @param	container
		 */
		public function EngineDelayedDisposeSignalEvent(child:IAbstractDisplayObject, container:IAbstractDisplayObjectContainer) 
		{
			_child  = child;
			_parent = container;
			
			updateEvent(child, container);
			
			eventName = Signals.REMOVE_AND_DISPOSE;
		}
		
		/**
		 * 
		 * @param	child
		 * @param	container
		 */
		public function updateEvent(child:IAbstractDisplayObject, container:IAbstractDisplayObjectContainer):void
		{
			params = { target:child, parent:container };
		}
		
	}

}