package  
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starlingEngine.extensions.DistanceFieldFont;
	import starlingEngine.extensions.DistanceFieldQuadBatch;
	/**
	 * ...
	 * @author Alex Popescu,
	 */
	public class Main extends Sprite
	{
		[Embed(source = "../bin/assets/sdfFonts/Poplar.png")]
		private static const PoplarPNG:Class;
		
		[Embed(source = "../bin/assets/sdfFonts/Poplar.xml")]
		private static const PoplarXML:Class;
		
		public function Main() 
		{
			var	texture:Texture = Texture.fromBitmap(new PoplarPNG());
			var	xml:XML = XML(new PoplarXML());
			 
			//var	batch:QuadBatch = new QuadBatch ();
			//var	font:BitmapFont = new BitmapFont (texture, xml);
			 
			var	batch:DistanceFieldQuadBatch = new DistanceFieldQuadBatch ();
			var	font:DistanceFieldFont = new DistanceFieldFont (texture, xml);
			 
			font.fillQuadBatch (batch, 512, 512, "Hello This is a test", 50, 0xff0000, "center", "center", false, false);
			 
			addChild(batch);
		}
		
	}

}