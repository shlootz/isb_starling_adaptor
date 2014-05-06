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
			return _layers[layerName] as IAbstractLayer;
		}
		
		/**
		 * 
		 */
		public function get layers():Dictionary
		{
			return _layers
		}
		
	}

}