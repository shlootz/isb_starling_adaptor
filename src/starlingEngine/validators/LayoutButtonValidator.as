package starlingEngine.validators 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.LabelProperties;
	import bridge.IEngine;
	import flash.geom.Point;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLayerLayoutElementVo;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LayoutButtonValidator 
	{
		
		public function LayoutButtonValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractButton
		{
			var btn:IAbstractButton = engine.requestButton();
			var upSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.resource));
			var upStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.upState));
			var overStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.overState));
			var pressedStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.pressedState));
			var disabledStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.disabledState));
						
			btn.idName = element.name;
						
			btn.upSkin_ = upSkin;
			btn.hoverSkin_ = overStateSkin;
			btn.downSkin_ = pressedStateSkin;
			btn.disabledSkin_ = disabledStateSkin;
						
			btn.x = Number(element.x);
			btn.y = Number(element.y);
					
			btn.width = Number(element.width);
			btn.height = Number(element.height);
						
			btn.name =element.name;
							
			if (element.label != "")
				{
					var labelText:IAbstractTextField = engine.requestTextField(int(element.labelWidth), int(element.labelHeight),element.label, element.font, element.labelFontSize, element.labelFontColor);
					var label:IAbstractLabel = engine.requestLabelFromTextfield(labelText);
							
					labelText.autoScale = true;
							
					labelText.hAlign = LabelProperties.ALIGN_CENTER;
						
					if (element.labelX != 0 || element.labelY != 0)
						{
							btn.addCustomLabel(label, LabelProperties.ALIGN_CUSTOM, new Point(element.labelX, element.labelY));
						}
						else
						{
							btn.addCustomLabel(label, LabelProperties.ALIGN_CENTER);
						}
					}
						
			return btn
		}
		
	}

}