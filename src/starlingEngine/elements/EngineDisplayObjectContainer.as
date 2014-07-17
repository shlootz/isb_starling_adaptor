package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineDisplayObjectContainer extends EngineDisplayObject implements IAbstractDisplayObjectContainer
	{
		
		private var _layers:Dictionary;
		
		public function EngineDisplayObjectContainer() 
		{
			
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