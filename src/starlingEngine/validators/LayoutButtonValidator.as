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
			var hasIcon:Boolean = false;
			var icon:IAbstractImage;
			
			upSkin.width = element.width;
			upSkin.height = element.height;

			btn.idName = element.name;
			
			if (element.flipped)
			{
				upSkin.pivotX = upSkin.width;
				upSkin.scaleX = -1;
				
				upStateSkin.pivotX = upStateSkin.width;
				upStateSkin.scaleX = -1;
				
				overStateSkin.pivotX = overStateSkin.width;
				overStateSkin.scaleX = -1;
				
				pressedStateSkin.pivotX = pressedStateSkin.width;
				pressedStateSkin.scaleX = -1;
				
				disabledStateSkin.pivotX = disabledStateSkin.width;
				disabledStateSkin.scaleX = -1;
			}
			
			btn.upSkin_ = upSkin;
			btn.hoverSkin_ = overStateSkin;
			btn.downSkin_ = pressedStateSkin;
			btn.disabledSkin_ = disabledStateSkin;
						
			btn.x = Number(element.x);
			btn.y = Number(element.y);
					
			btn.width = Number(element.width);
			btn.height = Number(element.height);
						
			btn.name = element.name;
			
			if (element.icon != "")
			{
				hasIcon = true;
				icon = engine.requestImage(assetsManager.getTexture(element.icon));
				icon.width = element.iconWidth;
				icon.height = element.iconHeight;
				btn.upIcon_ = icon;
				btn.hoverIcon_ = icon;
				btn.downIcon_ = icon;
				btn.disabledIcon_ = icon;
				btn.iconOffsetX = element.iconOffsetX;
				btn.iconOffsetY = element.iconOffsetY;
			}
			
			if (element.label != "")
			{
					var labelText:IAbstractTextField = engine.requestTextField(int(element.labelWidth), int(element.labelHeight),element.label, element.font, element.labelFontSize, element.labelFontColor);
					var label:IAbstractLabel = engine.requestLabelFromTextfield(labelText);
					
					label.name = "label"+element.name;
					
					labelText.autoScale = true;
							
					labelText.hAlign = LabelProperties.ALIGN_CENTER;
						
					if (element.labelX != 0 || element.labelY != 0)
					{
						btn.addCustomLabel(label, LabelProperties.ALIGN_CENTER);
						label.x += element.labelX;
						label.y += element.labelY;
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