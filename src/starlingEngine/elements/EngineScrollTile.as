package starlingEngine.elements 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractScrollTile;
	import starling.textures.Texture;
	import starlingEngine.extensions.krecha.ScrollTile;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineScrollTile extends ScrollTile implements IAbstractScrollTile
	{
		
		public function EngineScrollTile(image:IAbstractImage, autoCrop:Boolean = false) 
		{
			super(image.currentTexture as Texture, autoCrop);
		}
		
	}

}