package starlingEngine.elements 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractTexture;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineImage extends Image implements IAbstractImage
	{
		
		public function EngineImage(texture:Texture) 
		{
			super(texture as Texture);
		}
		
		public function get currentTexture () : Object
		{
			return super.texture as Object
		}
		
		public function set newTexture (value:Object) : void
		{
			super.texture = value as Texture;
		}
		
		override public function readjustSize () :void
		{
			super.readjustSize();
		}
		
	}

}