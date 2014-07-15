package starlingEngine.transitions 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayerTransitionIn extends EngineStateTransition implements IAbstractLayerTransitionIn
	{
		
		public function EngineLayerTransitionIn() 
		{
			super();
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		override public function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{
			super.doTransition(object1, object2);
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 * @param	customParams
		 */
		override public function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject,customParams:Object = null):void
		{	
			super.onTransitionComplete(object1, object2, customParams);
		}
		
	}

}