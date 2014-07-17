package starlingEngine.elements 
{
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractLayer;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayerVO implements IAbstractEngineLayerVO
	{
		
		private var _layers:Dictionary = new Dictionary(true);
		private var _layersRecycle:Dictionary = new Dictionary(true);
		
		public function EngineLayerVO() 
		{
			
		}
		
		/**
		 * 
		 * @param	layerName
		 */
		public function addLayer(layerName:String, depth:uint = 0, xml:XML = null, addToStage:Boolean = true):void
		{
			_layers[layerName] = new EngineLayer(layerName, depth, xml, addToStage);
		}
		
		/**
		 * 
		 * @param	layerName
		 * @return
		 */
		public function retrieveLayer(layerName:String):IAbstractLayer
		{
			var layer:IAbstractLayer;
			if (_layers[layerName])
			{
				layer = _layers[layerName];
				_layersRecycle[layerName] = layer;
			}
			else
			{
				layer = _layersRecycle[layerName];
				_layers[layerName] = _layersRecycle[layerName];
			}
			return _layers[layerName] as IAbstractLayer;
		}
		
		/**
		 * 
		 */
		public function get layers():Dictionary
		{
			return _layers
		}
		
		public function set layers(val:Dictionary):void
		{
			_layers = val;
		}
		
	}

}