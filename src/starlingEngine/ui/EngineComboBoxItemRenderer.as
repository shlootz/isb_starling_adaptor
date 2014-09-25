package starlingEngine.ui 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import starling.display.Image;
	import starling.textures.Texture;
	import starlingEngine.elements.EngineImage;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineComboBoxItemRenderer implements IAbstractComboBoxItemRenderer
	{
		
		private var _text:String;
		private var _thumbnail:IAbstractImage;
		private var _data:Object;
		
		public function EngineComboBoxItemRenderer(text:String, data:Object = null) 
		{
			_text = text;
			_data = data;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		
		
	}

}