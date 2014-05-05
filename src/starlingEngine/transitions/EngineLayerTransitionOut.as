package starlingEngine.transitions 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayerTransitionOut extends EngineStateTransition implements IAbstractLayerTransitionOut
	{
		
		public function EngineLayerTransitionOut() 
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
			TweenLite.to(object1, 1, { x:200,  onComplete: onTransitionComplete, onCompleteParams:[object1, object2] } );
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