package starlingEngine.validators 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
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
	public class LayoutToggleButtonValidator 
	{
		
		public function LayoutToggleButtonValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractToggle
		{
			var btn:IAbstractToggle = engine.requestToggleButton();
			var upSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.resource));
			var upStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.upState));
			var overStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.overState));
			var pressedStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.pressedState));
			var disabledStateSkin:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.disabledState));
			var hasIcon:Boolean = false;
			var iconOn:IAbstractImage;
			var iconOff:IAbstractImage;
						
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
						
			btn.x = Math.round(Number(element.x));
			btn.y = Math.round(Number(element.y));
					
			btn.width = Math.round(Number(element.width));
			btn.height = Math.round(Number(element.height));
						
			btn.name = element.name;
			
			hasIcon = true;
			iconOn = engine.requestImage(assetsManager.getTexture(element.iconOn));
			btn.toggleTrueImage = iconOn;
			
			iconOff = engine.requestImage(assetsManager.getTexture(element.iconOff));
			btn.toggleFalseImage = iconOff;
	
			
			btn.hoverIcon_ = btn.upIcon_;
			btn.downIcon_ = btn.upIcon_;
			btn.selectedDownIcon_ = btn.selectedUpIcon_;
			btn.selectedHoverIcon_ = btn.selectedUpIcon_;
			
			
			iconOn.width = Math.round(element.iconWidth);
			iconOn.height = Math.round(element.iconHeight);
			
			iconOff.width = Math.round(element.iconWidth);
			iconOff.height = Math.round(element.iconHeight);
			
			btn.iconOffsetX =Math.round(element.iconOffsetX);
			btn.iconOffsetY = Math.round(element.iconOffsetY);
			
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
						btn.addCustomLabel(label, "center");
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
			}
						
			return btn
		}
		
	}

}