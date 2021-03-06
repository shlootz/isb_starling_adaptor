package starlingEngine.elements 
{
import bridge.abstract.IAbstractImage;

import flash.display.BitmapData;

import starling.display.BlendMode;

import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineImage extends Image implements IAbstractImage
	{
		
		public function EngineImage(texture:Texture) 
		{
			super(texture as Texture);
//            blendMode = BlendMode.NONE;
//            smoothing = TextureSmoothing.NONE;
		}
		
		public function get currentTexture () : Object
		{
			return super.texture as Object
		}
		
		public function set newTexture (value:Object) : void
		{
			super.texture = value as Texture;
		}
		
		public function set newTextureFromBitmapData(value:BitmapData):void
		{
			super.texture.dispose();
			super.texture = Texture.fromBitmapData(value);
		}
		
		override public function readjustSize () :void
		{
			super.readjustSize();
		}
		
	}

}