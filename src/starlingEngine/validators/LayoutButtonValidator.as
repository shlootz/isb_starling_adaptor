package starlingEngine.validators 
{
import bridge.IEngine;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.ui.IAbstractButton;
import bridge.abstract.ui.IAbstractLabel;

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
			var upSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.resource), element.resource);
			upSkin.name = element.resource;
			var upStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.upState), element.upState);
			upStateSkin.name = element.upState;
			var overStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.overState), element.overState);
			overStateSkin.name = element.overState;
			var pressedStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.pressedState), element.pressedState);
			pressedStateSkin.name = element.pressedState;
			var disabledStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.disabledState),  element.disabledState);
			disabledStateSkin.name = element.disabledState;
			var hasIcon:Boolean = false;
			var icon:IAbstractImage;
			
			upSkin.width = Math.round(element.width);
			upSkin.height = Math.round(element.height);

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

            btn.upSkin_.name =  upSkin.name;
            btn.hoverSkin_.name =  overStateSkin.name;
            btn.downSkin_.name =  pressedStateSkin.name;
            btn.disabledSkin_.name =  disabledStateSkin.name;

			btn.x = Math.round(Number(element.x));
			btn.y = Math.round(Number(element.y));
					
			btn.width = Math.round(Number(element.width))
			btn.height = Math.round(Number(element.height));
						
			btn.name = element.name;
			
			if (element.icon != "")
			{
				hasIcon = true;
				icon = engine.requestImage(assetsManager.getTexture(element.icon), element.icon);
				icon.width = Math.round(element.iconWidth);
				icon.height = Math.round(element.iconHeight);
				btn.upIcon_ = icon;
				btn.hoverIcon_ = icon;
				btn.downIcon_ = icon;
				btn.disabledIcon_ = icon;

                btn.upIcon_.name = icon.name;
                btn.hoverIcon_.name = icon.name;
                btn.downIcon_.name = icon.name;
                btn.disabledIcon_.name = icon.name;

				btn.iconOffsetX = Math.round(element.iconOffsetX);
				btn.iconOffsetY = Math.round(element.iconOffsetY);
			}
			
			if (element.label != "")
			{
					var labelText:IAbstractTextField = engine.requestTextField(int(element.labelWidth), int(element.labelHeight),element.label, element.font, element.labelFontSize, element.labelFontColor);
					var label:IAbstractLabel = engine.requestLabelFromTextfield(labelText);
					var labelAlign:String = "center";
					
					if (element.labelAlign != "")
					{
						labelAlign = element.labelAlign;
					}
					
					label.name = "label"+element.name;
					
					labelText.autoScale = true;
						
					if (element.labelX != 0 || element.labelY != 0)
					{
						btn.addCustomLabel(label,  "center");
						label.x += element.labelX;
						label.y += element.labelY;
						
						label.x = Math.round(label.x);
						label.y = Math.round(label.y);
					}
					else
					{
						btn.addCustomLabel(label, "center");
					}
					
					labelText.hAlign = labelAlign;
					
					if (element.filters != "")
					{
						labelText.nativeFilters = LayoutTextFieldValidator.parseFilters(element.filters);
						
					}
			}
						
			return btn
		}
		
	}

}