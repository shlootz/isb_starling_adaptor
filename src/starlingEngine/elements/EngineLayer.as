package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractLayer;
	import flash.utils.Dictionary;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayer extends EngineState implements IAbstractLayer
	{	
		private var _layerName:String;
		private var _layerDepth:uint = 0;
		private var _layout:XML;
		private var _layoutDictionary:Dictionary = new Dictionary(true);
		private var _layoutElements:Dictionary = new Dictionary(true);
		private var _addToStage:Boolean = false;
		
		/**
		 * 
		 * @param	layerName
		 */
		public function EngineLayer(name:String, depth:uint = 0, layout:XML = null, addToStage:Boolean = true ) 
		{
			_layerName = name;
			_layerDepth = depth;
			_addToStage = addToStage;
			this.name = name;
			
			if (layout != null)
			{
				_layout = layout;
				parseLayout();
			}
		}
		
		/**
		 * 
		 * @param	child
		 * @return
		 */
		override public function addNewChild(child:Object):IAbstractDisplayObject
		{
			_layoutElements[(child as IAbstractDisplayObject).name] = child as IAbstractDisplayObject;
			return super.addNewChild(child);
		}
		
		/**
		 * 
		 * @param	child
		 * @param	index
		 * @return
		 */
		override public function addNewChildAt(child:IAbstractDisplayObject, index:int):IAbstractDisplayObject
		{
			_layoutElements[(child as IAbstractDisplayObject).name] = child as IAbstractDisplayObject;
			return super.addChildAt(child as DisplayObject, index) as IAbstractDisplayObject;
		}
		
	/**
	 * 
	 */
		public function set layerName(name:String):void
		{
			_layerName = name;
		}
		
		/**
		 * 
		 */
		public function get layerName():String
		{
			return _layerName;
		}
		
		/**
		 * 
		 */
		public function get layerDepth():uint
		{
			return _layerDepth;
		}
		
		/**
		 * 
		 */
		public function set layerDepth(val:uint ):void
		{
			_layerDepth = val;
		}
		
		/**
		 * 
		 * @param	layout
		 */
		public function injectLayout(layout:XML, applyNow:Boolean = false):void
		{
			_layout = layout;
			
			if (applyNow)
			{
				applyLayout();
			}
		}
		
		/**
		 * 
		 */
		public function applyLayout():void
		{
			parseLayout();
		}
		
		/**
		 * 
		 */
		public function get layout():Dictionary
		{
			return _layoutDictionary;
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		public function getElement(name:String):IAbstractDisplayObject
		{
			return _layoutElements[name] as IAbstractDisplayObject
		}
		
		/**
		 * 
		 */
		private function parseLayout():void
		{
			for (var i:uint = 0; i < _layout.children().length(); i++)
			{
				var layerX:String = String(_layout.child("Element")[i].attribute("layerX"));
				var layerY:String = String(_layout.child("Element")[i].attribute("layerY"));
				var name:String = String(_layout.child("Element")[i].attribute("name"));
				var type:String = _layout.child("Element")[i].attribute("type");
				var onStage:String = _layout.child("Element")[i].attribute("onStage");
				var x:String = _layout.child("Element")[i].attribute("x");
				var y:String = _layout.child("Element")[i].attribute("y");
				var w:String = _layout.child("Element")[i].attribute("width");
				var h:String = _layout.child("Element")[i].attribute("height");
				var fps:uint = uint(_layout.child("Element")[i].attribute("fps"));
				var depth:String = _layout.child("Element")[i].attribute("depth");
				var resource:String = _layout.child("Element")[i].attribute("resource");
				var upState:String = _layout.child("Element")[i].attribute("upState");
				var overState:String = _layout.child("Element")[i].attribute("overState");
				var pressedState:String = _layout.child("Element")[i].attribute("pressedState");
				var disabledState:String = _layout.child("Element")[i].attribute("disabledState");
				var loop:String = _layout.child("Element")[i].attribute("loop");
				var labelWidth:String = _layout.child("Element")[i].attribute("labelWidth");
				var labelHeight:String = _layout.child("Element")[i].attribute("labelHeight");
				var font:String = _layout.child("Element")[i].attribute("labelFont");
				var label:String = _layout.child("Element")[i].attribute("label");
				var labelFontSize:String = _layout.child("Element")[i].attribute("labelFontSize");
				var labelFontColor:String = _layout.child("Element")[i].attribute("labelFontColor");
				var labelX:String = _layout.child("Element")[i].attribute("labelX");
				var labelY:String = _layout.child("Element")[i].attribute("labelY");
				var flipped:String = _layout.child("Element")[i].attribute("flipped");
				
				var o:EngineLayerLayoutElementVo = new EngineLayerLayoutElementVo();
				o.layerX = Number(layerX);
				o.layerY = Number(layerY);
				o.name = name;
				o.resource = resource;
				o.upState = upState;
				o.overState = overState;
				o.pressedState = pressedState;
				o.disabledState = disabledState;
				o.type = type;
				o.onStage = onStage;
				o.x = Number(x);
				o.y = Number(y);
				o.width = Number(w);
				o.height = Number(h);
				o.fps = fps;
				o.layerDepth = Number(depth)
				o.labelWidth = Number(labelWidth);
				o.labelHeight = Number(labelHeight);
				o.font = font;
				o.label = label;
				o.labelFontSize = Number(labelFontSize);
				o.labelFontColor = uint(labelFontColor);
				o.labelX = Number(labelX)
				o.labelY = Number(labelY)
				
				if (flipped == "true")
				{
					o.flipped = true;
				}
				else
				{
					o.flipped = false;
				}
				
				if (loop == "true")
				{
					o.loop = true;
				}
				else
				{
					o.loop = false;
				}
				
				_layoutDictionary[name] = o;
			}
		}
		
		/**
		 * 
		 */
		public function get addToStage():Boolean
		{
			return _addToStage;
		}
		
		/**
		 * 
		 */
		override public function destroyAll():void
		{
			while (this.numChildren > 0)
			{
				var c:IAbstractDisplayObject;
				c = this.removeChildAndDispose(this.getChildAtIndex(0), true);
				c.removeFromParent(true);
				c.dispose();
			}
			
			super.dispose();
			super.killAllObjects();
		}
	}
	
}