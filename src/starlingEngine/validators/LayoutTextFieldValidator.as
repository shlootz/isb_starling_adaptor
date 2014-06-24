package starlingEngine.validators 
{
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.IEngine;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLayerLayoutElementVo;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LayoutTextFieldValidator 
	{
		
		public function LayoutTextFieldValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractLabel
		{
			var tField:IAbstractTextField = engine.requestTextField(element.width, element.height, element.label, element.font, element.labelFontSize, element.labelFontColor);
			var tLabel:IAbstractLabel = engine.requestLabelFromTextfield(tField, element.name);
			tLabel.x = element.x;
			tLabel.y = element.y;
			
			return tLabel;
		}
		
	}

}