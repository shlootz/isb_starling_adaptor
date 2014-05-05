package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractSprite;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineSprite extends Sprite implements IAbstractSprite
	{
		/**
		 * 
		 */
		public function EngineSprite() 
		{
			super();
		}
		/**
		 * 
		 * @param	child
		 * @return
		 */
		public function addNewChild(child:Object):IAbstractDisplayObject
		{
			return super.addChild(child as DisplayObject) as IAbstractDisplayObject;
		}
		/**
		 * 
		 * @param	child
		 * @param	index
		 * @return
		 */
		public function addNewChildAt (child:IAbstractDisplayObject, index:int) : IAbstractDisplayObject
		{
			return super.addChildAt(child as DisplayObject, index) as IAbstractDisplayObject;
		}
		/**
		 * 
		 * @param	child
		 * @return
		 */
		public function containsChild (child:IAbstractDisplayObject) : Boolean
		{
			return super.contains(child as DisplayObject);
		}
		/**
		 * 
		 * @param	targetSpace
		 * @param	resultRect
		 * @return
		 */
		public function getChildBounds (targetSpace:IAbstractDisplayObject, resultRect:Rectangle = null) : Rectangle
		{
			return super.getBounds(targetSpace as DisplayObject, resultRect);
		}
		/**
		 * 
		 * @param	index
		 * @return
		 */
		public function getChildAtIndex (index:int) : IAbstractDisplayObject
		{
			return super.getChildAt(index) as IAbstractDisplayObject;
		}
		/**
		 * 
		 * @param	name
		 * @return
		 */
		public function getChildByNameStr (name:String) : IAbstractDisplayObject
		{
			return super.getChildByName(name) as IAbstractDisplayObject;
		}
		/**
		 * 
		 * @param	child
		 * @return
		 */
		public function getChildIndexNr (child:IAbstractDisplayObject) : int
		{
			return super.getChildIndex(child as DisplayObject);
		}
		/**
		 * 
		 * @param	child
		 * @param	dispose
		 * @return
		 */
		public function removeChildAndDispose (child:IAbstractDisplayObject, dispose:Boolean = false) : IAbstractDisplayObject
		{
			return super.removeChild(child as DisplayObject, dispose) as IAbstractDisplayObject;
		}
		
		/**
		 * 
		 * @param	index
		 * @param	dispose
		 * @return
		 */
		public function removeChildAtIndex (index:int, dispose:Boolean = false) : IAbstractDisplayObject
		{
			return super.removeChildAt(index, dispose) as IAbstractDisplayObject;
		}
		/**
		 * 
		 * @param	beginIndex
		 * @param	endIndex
		 * @param	dispose
		 */
		public function removeChildrenFromTo (beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void
		{
			return super.removeChildren(beginIndex, endIndex, dispose);
		}
		/**
		 * 
		 * @param	child
		 * @param	index
		 */
		public function setChildIndexNr (child:IAbstractDisplayObject, index:int) : void
		{
			super.setChildIndex(child as DisplayObject, index);
		}
		/**
		 * 
		 * @param	compareFunction
		 */
		public function sortChildrenBy (compareFunction:Function) : void
		{
			super.sortChildren(compareFunction);
		}
		/**
		 * 
		 * @param	child1
		 * @param	child2
		 */
		public function swapChildrenF (child1:IAbstractDisplayObject, child2:IAbstractDisplayObject) : void
		{
			super.swapChildren(child1 as DisplayObject, child2 as DisplayObject);
		}
		/**
		 * 
		 * @param	index1
		 * @param	index2
		 */
		public function swapChildrenAtIndex (index1:int, index2:int) : void
		{
			super.swapChildrenAt(index1, index2);
		}
		
	}

}