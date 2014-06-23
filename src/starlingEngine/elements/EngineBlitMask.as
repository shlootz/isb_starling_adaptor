package starlingEngine.elements 
{
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.IAbstractScrollTile;
	import starlingEngine.extensions.krecha.ScrollImage;
	import starlingEngine.extensions.krecha.ScrollTile;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineBlitMask extends ScrollImage implements IAbstractBlitMask
	{
		
		public function EngineBlitMask( width:Number, height:Number, useBaseTexture:Boolean = false) 
		{
			super(width, height, useBaseTexture);
		}
		
		public function addLayerOnTop(layer:IAbstractScrollTile):IAbstractScrollTile
		{
			return super.addLayer(layer as ScrollTile) as IAbstractScrollTile;
		}
		
	}

}