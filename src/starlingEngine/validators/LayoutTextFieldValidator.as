package starlingEngine.validators 
{
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.IEngine;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;
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
			
			tLabel.x = Math.round(element.x);
			tLabel.y = Math.round(element.y);
			
			if (element.filters != "")
			{
				tField.nativeFilters = parseFilters(element.filters);
			}
			
			if (element.labelAlign != "" && element.labelAlign != null)
			{
				tLabel.textField.hAlign = element.labelAlign;
			}
			else
			{
				tLabel.textField.hAlign = "center";
			}
			
			return tLabel;
		}
		
		/**
		 * 
		 * @param	inputFiltersString
		 * @return
		 */
		public static function parseFilters(inputFiltersString:String):Array
		{
			var tFieldFiltersString:String = inputFiltersString;
			var tFieldFiltersJSON:Object = JSON.parse(tFieldFiltersString);
			var tFieldFiltersArray:Array = new Array();
			var filterObj:Object;
			
			for (var i:String in tFieldFiltersJSON)
			{
				filterObj= tFieldFiltersJSON[i];
				switch(filterObj["name"])
				{
					case "glowFilter":
						var glowFilter:GlowFilter = new GlowFilter();
						setProperties(glowFilter, filterObj);
						tFieldFiltersArray.push(glowFilter);
						break;
					
					case "bevelFilter":
						var bevelFilter:BevelFilter = new BevelFilter();
						setProperties(bevelFilter, filterObj);
						tFieldFiltersArray.push(bevelFilter);
						break;
						
					case "dropShadowFilter":
						var dropShadowFilter:DropShadowFilter = new DropShadowFilter();
						setProperties(dropShadowFilter, filterObj);
						tFieldFiltersArray.push(dropShadowFilter);
						break;
						
					case "gradientBevelFilter":
						var gradientBevelFilter:GradientBevelFilter = new GradientBevelFilter();
						setProperties(gradientBevelFilter, filterObj);
						tFieldFiltersArray.push(gradientBevelFilter);
						break;	
						
					default:
						break;
				}
			}
			
			return tFieldFiltersArray;
		}
		
		/**
		 * 
		 * @param	target
		 * @param	source
		 */
		public static function setProperties(target:Object, source:Object):void
		{
			for (var i:String in source)
			{
				if (i in target)
				{
					switch (typeof target[i])
					{
						case "boolean":
							if (source[i] == "true")
							{
								target[i] = true;
							}
							else
							{
								target[i] = false;
							}
							break;
							
						case "number":
							switch (i)
							{
								case "alpha":
										target[i] = (Number(source[i]));
									break;
								case "color":
										target[i] = (parseInt(source[i]));
									break;
								case "quality":
									switch (source[i])
									{
										case "low":
											target[i] = BitmapFilterQuality.LOW;
											break;
										case "medium":
											target[i] = BitmapFilterQuality.MEDIUM;
											break;
										case "high":
											target[i] = BitmapFilterQuality.HIGH;
											break;
									}
									break;
								default:
									target[i] = parseInt(source[i]);
									break;
							}
							break;
							
						case "object":
							populateArrayByStrategy(target, ["colors", "alphas", "ratios"], source);
							break;
					}
				}
			}
		}
		
		/**
		 * 
		 * @param	target
		 * @param	fieldsArray
		 * @param	source
		 */
		public static function populateArrayByStrategy(target:Object, fieldsArray:Array, source:Object):void
		{
			for (var i:uint = 0; i < fieldsArray.length; i++ )
			{
				target[fieldsArray[i]] = formatArray(String(source[fieldsArray[i]]).split(","));
			}
		}
		
		/**
		 * 
		 * @param	initialArr
		 * @return
		 */
		public static function formatArray(initialArr:Array):Array
		{
			for (var j:uint = 0; j < initialArr.length; j++)
				{
					initialArr[j] = Number(initialArr[j]);
				}
				
			return initialArr;	
		}
		
	}

}