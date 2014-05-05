package starlingEngine.elements 
{
	import bridge.abstract.IAbstractTexture;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineTexture extends Texture implements IAbstractTexture
	{
		
		public function EngineTexture() 
		{
			super();
		}
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	premultipliedAlpha
		 * @param	mipMapping
		 * @param	optimizeForRenderToTexture
		 * @param	scale
		 * @param	format
		 * @return
		 */
		public static function empty (width:Number, height:Number, premultipliedAlpha:Boolean = true, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra") : EngineTexture
		{
			return Texture.empty(width, height, premultipliedAlpha, mipMapping, optimizeForRenderToTexture, scale, format) as EngineTexture;
		}
		/**
		 * 
		 * @param	data
		 * @param	scale
		 * @param	useMipMaps
		 * @param	async
		 * @return
		 */
		public static function fromAtfData (data:ByteArray, scale:Number = 1, useMipMaps:Boolean = true, async:Function = null) : EngineTexture
		{
			return Texture.fromAtfData(data, scale, useMipMaps, async) as EngineTexture;
		}
		/**
		 * 
		 * @param	bitmap
		 * @param	generateMipMaps
		 * @param	optimizeForRenderToTexture
		 * @param	scale
		 * @param	format
		 * @return
		 */
		public static function fromBitmap (bitmap:Bitmap, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra") : EngineTexture
		{
			return Texture.fromBitmap(bitmap, generateMipMaps, optimizeForRenderToTexture, scale, format) as EngineTexture;
		}
		/**
		 * 
		 * @param	data
		 * @param	generateMipMaps
		 * @param	optimizeForRenderToTexture
		 * @param	scale
		 * @param	format
		 * @return
		 */
		public static function fromBitmapData (data:BitmapData, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra") : EngineTexture
		{
			return Texture.fromBitmapData(data, generateMipMaps, optimizeForRenderToTexture, scale, format) as EngineTexture;
		}
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	optimizeForRenderToTexture
		 * @param	scale
		 * @param	format
		 * @return
		 */
		public static function fromColor (width:Number, height:Number, color:uint = 4294967295, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra") : EngineTexture
		{
			return Texture.fromColor(width, height, color, optimizeForRenderToTexture, scale, format) as EngineTexture;
		}
		/**
		 * 
		 * @param	assetClass
		 * @param	mipMapping
		 * @param	optimizeForRenderToTexture
		 * @param	scale
		 * @param	format
		 * @return
		 */
		public static function fromEmbeddedAsset (assetClass:Class, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra") : EngineTexture
		{
			return Texture.fromEmbeddedAsset(assetClass, mipMapping, optimizeForRenderToTexture, scale, format) as EngineTexture;
		}
		/**
		 * 
		 * @param	texture
		 * @param	region
		 * @param	frame
		 * @return
		 */
		public static function fromTexture (texture:Texture, region:Rectangle = null, frame:Rectangle = null) : EngineTexture
		{
			return Texture.fromTexture(texture, region, frame) as EngineTexture;
		}
		
	}

}