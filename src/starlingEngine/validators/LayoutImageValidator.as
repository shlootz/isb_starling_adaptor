package starlingEngine.validators 
{
	import bridge.abstract.IAbstractImage;
	import bridge.IEngine;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLayerLayoutElementVo;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LayoutImageValidator 
	{
		
		public function LayoutImageValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractImage
		{
			var img:IAbstractImage = engine.requestImage(assetsManager.getTexture(element.resource));
			img.x = Number(element.x);
			img.y = Number(element.y);
			img.width = Number(element.width);
			img.height = Number(element.height);
			img.name = element.name;
			
			if (element.flipped)
			{
				img.pivotX = img.width;
				img.scaleX = -1;
			}
			
			return img;
		}
		
	}

}