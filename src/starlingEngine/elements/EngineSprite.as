package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractSprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineSprite extends Sprite implements IAbstractSprite
	{
		private var _onClick:Boolean = false;
		private var _onHover:Boolean = false;
		private var _onEnded:Boolean = false;
		private var _onMoved:Boolean = false;
		private var _onStationary:Boolean = false;
		private var _layers:Dictionary;
		
		private var _signalsHub:SignalsHub;
		/**
		 * 
		 */
		public function EngineSprite() 
		{
			super();
		}
		
		/**
		 * 
		 * @param	onClick
		 * @param	onHover
		 * @param	onEnded
		 * @param	onMoved
		 * @param	onStationary
		 * @return
		 */
		public function updateMouseGestures(signalsManager:Object = null, 
																		onClick:Boolean = false, 	
																		onHover:Boolean = false, 
																		onEnded:Boolean = false, 
																		onMoved:Boolean = false, 
																		onStationary:Boolean = false):void
		{
			_signalsHub = signalsManager as SignalsHub;
			_onClick = onClick;
			_onHover = onHover;
			_onEnded = onEnded;
			_onMoved = onMoved;
			_onStationary = onStationary;
			
			if (_onClick || _onHover || _onEnded || _onMoved || _onStationary)
			{
				this.addEventListener(TouchEvent.TOUCH, spriteTouched);
			}
			else
			{
				this.removeEventListener(TouchEvent.TOUCH, spriteTouched);
			}
		}
		
		/**
		 * 
		 * @param	event
		 */
		private function spriteTouched(event:TouchEvent):void
		{
			var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchHover:Touch = event.getTouch(this, TouchPhase.HOVER);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			var touchStationary:Touch = event.getTouch(this, TouchPhase.STATIONARY);
			
			var localPos:Point;
			var obj:Object = new Object();
			
			if (touchBegan && _onClick )
			{
				localPos = touchBegan.getLocation(this);
				obj = {
					phase:TouchPhase.BEGAN,
					event:event
				}
				_signalsHub.dispatchSignal(Signals.DISPLAY_OBJECT_TOUCHED, TouchPhase.BEGAN, obj);
			}
			
			if (touchHover && _onHover)
			{
				obj = {
					phase:TouchPhase.HOVER,
					event:event
				}
				localPos = touchHover.getLocation(this);
				_signalsHub.dispatchSignal(Signals.DISPLAY_OBJECT_TOUCHED, TouchPhase.HOVER, obj);
			}
			
			if (touchEnded && _onEnded)
			{
				obj = {
					phase:TouchPhase.ENDED,
					event:event
				}
				localPos = touchEnded.getLocation(this);
				_signalsHub.dispatchSignal(Signals.DISPLAY_OBJECT_TOUCHED, TouchPhase.ENDED, obj);
			}
			
			if (touchMoved && _onMoved)
			{
				obj = {
					phase:TouchPhase.MOVED,
					event:event
				}
				 localPos = touchMoved.getLocation(this);
				_signalsHub.dispatchSignal(Signals.DISPLAY_OBJECT_TOUCHED, TouchPhase.MOVED, obj);
			}
			
			if (touchStationary && _onStationary)
			{
				obj = {
					phase:TouchPhase.STATIONARY,
					event:event
				}
				 localPos = touchStationary.getLocation(this);
				_signalsHub.dispatchSignal(Signals.DISPLAY_OBJECT_TOUCHED, TouchPhase.STATIONARY, obj);
			}
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
		
		/**
		 * 
		 */
		public function get layers():Dictionary
		{
			if (!_layers)
			{
				_layers = new Dictionary(true);
			}
			
			return _layers;
		}
		
		/**
		 * 
		 */
		public function set layers(val:Dictionary):void
		{
			 _layers = val;
		}
	}

}