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
			
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		override public function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{
			object1.alpha = 0;
			TweenLite.to(object1, 1, { alpha:1,  onComplete: onTransitionComplete, onCompleteParams:[object1, object2] } );
		}
		
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		override public function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		{	
			super.onTransitionComplete(object1, object2);
		}
		
	}

}