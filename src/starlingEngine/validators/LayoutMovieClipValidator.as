package starlingEngine.validators 
{
import bridge.IEngine;
import bridge.abstract.IAbstractMovie;

import starling.utils.AssetManager;

import starlingEngine.elements.EngineLayerLayoutElementVo;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class LayoutMovieClipValidator 
	{
		
		public function LayoutMovieClipValidator() 
		{
			
		}
		
		public static function validate(engine:IEngine, assetsManager:AssetManager, element:EngineLayerLayoutElementVo):IAbstractMovie
		{
			var mc:IAbstractMovie = engine.requestMovie(element.resource, element.fps);
			(mc as IAbstractMovie).name = element.name;
			(mc as IAbstractMovie).loop = element.loop;
			mc.width = Math.round(Number(element.width));
			mc.height = Math.round(Number(element.height));
			mc.name = element.name;
			
			if (element.flipped)
			{
				mc.pivotX = mc.width;
				mc.scaleX = -1;
			}
			
			return mc;
		}
	}

}