package starlingEngine.transitions 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import com.greensock.TweenLite;
	import starlingEngine.elements.EngineDisplayObject;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineStateTransition implements IAbstractStateTransition
	{
		
		private var _onTransitionComplete:Function = null;
		
		/**
		 * 
		 */
		public function EngineStateTransition() 
		{
			
		}
		/**
		 * 
		 * @param	fct
		 */
		public function injectOnTransitionComplete(fct:Function):void
		{
			_onTransitionComplete = fct;
		}
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		public function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{
			TweenLite.to(object1, 1, { alpha:.5 } );
			
			TweenLite.to(object2, 1, { x:30, onComplete: onTransitionComplete, onCompleteParams:[object1, object2]})
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		public function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{	
			if (_onTransitionComplete != null)
			{
				_onTransitionComplete.apply(null, [object1, object2]);
				_onTransitionComplete.call();
			}
		}
		
	}

}