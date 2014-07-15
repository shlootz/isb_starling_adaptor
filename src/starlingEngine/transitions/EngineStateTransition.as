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
		private var _animationFunction:Function = null;
		
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
		 * @param	func
		 */
		public function injectAnimation(func:Function):void
		{
			_animationFunction = func;
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		public function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{
			if (_animationFunction != null)
			{
				_animationFunction.apply(null, [object1, object2]);
			}
			else
			{
				onTransitionComplete(object1, object2);
			}
		}
		
	/**
	 * 
	 * @param	object1
	 * @param	object2
	 * @param	customParams
	 */
		public function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject, customParams:Object = null):void
		{	
			if (_onTransitionComplete != null)
			{
				if (customParams)
				{
					_onTransitionComplete.apply(null, [object1, object2, customParams]);
				}
				else
				{
					_onTransitionComplete.apply(null, [object1, object2]);
				}
			}
		}
		
	}

}