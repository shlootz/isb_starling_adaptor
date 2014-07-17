package starlingEngine.validators 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import bridge.abstract.ui.LabelProperties;
	import bridge.IEngine;
	import flash.geom.Point;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLayerLayoutElementVo;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LayoutSliderValidator 
	{
		
		public function LayoutSliderValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractSlider
		{
			var sliderTextField:IAbstractTextField = engine.requestTextField(element.labelWidth, element.labelHeight, element.label, element.font, element.labelFontSize, element.labelFontColor);
			var sliderLabel:IAbstractLabel = engine.requestLabelFromTextfield(sliderTextField, "label");
			var slider:IAbstractSlider = engine.requestSlider(
																					engine.requestImage(assetsManager.getTexture(element.thumbUpSkin)), 
																					engine.requestImage(assetsManager.getTexture(element.thumbDownSkin)),
																					engine.requestImage(assetsManager.getTexture(element.trackUpSkin)),
																					engine.requestImage(assetsManager.getTexture(element.trackDownSkin)),
																					engine.requestImage(assetsManager.getTexture(element.background)),
																					sliderLabel,
																					element.name
																					);
			
			slider.x = element.x;
			slider.y = element.y;
			slider.sliderComponentX = element.sliderX;
			slider.sliderComponentY = element.sliderY;
			
			//if (element.label != "")
			//{
					//var labelText:IAbstractTextField = engine.requestTextField(int(element.labelWidth), int(element.labelHeight),element.label, element.font, element.labelFontSize, element.labelFontColor);
					//var label:IAbstractLabel = engine.requestLabelFromTextfield(labelText);
					//
					//label.name = "label"+element.name;
					//
					//labelText.autoScale = true;
							//
					//labelText.hAlign = LabelProperties.ALIGN_CENTER;
						//
					//if (element.labelX != 0 || element.labelY != 0)
					//{
						//btn.addCustomLabel(label, LabelProperties.ALIGN_CENTER);
						//label.x += element.labelX;
						//label.y += element.labelY;
					//}
					//else
					//{
						//btn.addCustomLabel(label, LabelProperties.ALIGN_CENTER);
					//}
			//}
						
			return slider
		}
		
	}

}