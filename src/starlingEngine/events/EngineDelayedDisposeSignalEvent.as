package starlingEngine.events 
{
import bridge.abstract.IAbstractDisplayObject;
import bridge.abstract.IAbstractDisplayObjectContainer;

import starlingEngine.signals.Signals;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineDelayedDisposeSignalEvent extends GESignalEvent
	{
		
		private var _child:IAbstractDisplayObject;
		private var _parent:IAbstractDisplayObjectContainer;
		private var _recycle:Boolean = false;
		
		/**
		 * 
		 * @param	child
		 * @param	container
		 */
		public function EngineDelayedDisposeSignalEvent(child:IAbstractDisplayObject, container:IAbstractDisplayObjectContainer, recycle:Boolean = false) 
		{
			_child  = child;
			_parent = container;
			_recycle = recycle;
			
			updateEvent(child, container, recycle);
			
			eventName = Signals.REMOVE_AND_DISPOSE;
		}
		
		/**
		 * 
		 * @param	child
		 * @param	container
		 */
		public function updateEvent(child:IAbstractDisplayObject, container:IAbstractDisplayObjectContainer, recycle:Boolean = false):void
		{
			params = { target:child, parent:container, recycle:recycle };
		}
		
	}

}