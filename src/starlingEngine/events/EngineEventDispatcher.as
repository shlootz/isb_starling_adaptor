package starlingEngine.events 
{
	import bridge.abstract.events.IAbstractEvent;
	import bridge.abstract.events.IAbstractEventDispatcher;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineEventDispatcher extends starling.events.EventDispatcher implements IAbstractEventDispatcher
	{
		
		public function EngineEventDispatcher() 
		{
			
		}
		
		/// Registers an event listener at a certain object.
		override public function addEventListener (type:String, listener:Function) : void
		{
			super.addEventListener(type, listener);
		}

		/**
		 * Dispatches an event to all objects that have registered listeners for its type. 
		 * If an event with enabled 'bubble' property is dispatched to a display object, it will 
		 * travel up along the line of parents, until it either hits the root object or someone
		 * stops its propagation manually.
		 */
		public function dispatchEvent_ (event:IAbstractEvent) : void
		{
			super.dispatchEvent(event as EngineEvent);
		}

		/**
		 * Dispatches an event with the given parameters to all objects that have registered 
		 * listeners for the given type. The method uses an internal pool of event objects to 
		 * avoid allocations.
		 */
		override public function dispatchEventWith (type:String, bubbles:Boolean = false, data:Object = null) : void
		{
			super.dispatchEventWith(type, bubbles, data);
		}

		/// Returns if there are listeners registered for a certain event type.
		override public function hasEventListener (type:String) : Boolean
		{
			super.hasEventListener(type);
		}

		/// Removes an event listener from the object.
		override public function removeEventListener (type:String, listener:Function) : void
		{
			super.removeEventListener(type, listener)
		}

		/**
		 * Removes all event listeners with a certain type, or all of them if type is null. 
		 * Be careful when removing all event listeners: you never know who else was listening.
		 */
		override public function removeEventListeners (type:String = null) : void
		{
			super.removeEventListeners(type, listener)
		}
		
	}

}