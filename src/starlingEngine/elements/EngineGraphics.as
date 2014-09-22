package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractGraphics;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractSprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import starling.display.DisplayObjectContainer;
	import starling.display.Graphics;
	import starling.display.Image;
	import starling.display.materials.StandardMaterial;
	import starling.display.shaders.fragment.TextureFragmentShader;
	import starling.display.shaders.vertex.AnimateUVVertexShader;
	import starling.textures.GradientTexture;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineGraphics extends Graphics implements IAbstractGraphics
	{
		private var _displayObjectContainer:IAbstractDisplayObjectContainer;
		
		private var _storedLineTexture:Texture;
		
		private var _animatedMaterial:StandardMaterial;
		private var _storedAnimatedTexture:Texture;
		
		protected static const BEZIER_ERROR:Number = 0.75;
		
		public function EngineGraphics(displayObjectContainer:IAbstractDisplayObjectContainer) 
		{
			_displayObjectContainer = displayObjectContainer;
			super(displayObjectContainer as DisplayObjectContainer);
		}
		
		override public function curveTo( cx:Number, cy:Number, a2x:Number, a2y:Number,  error:Number = 0.75 ):void
		{
			super.curveTo(cx,cy,a2x,a2y,BEZIER_ERROR)
		}
		
		override public function cubicCurveTo( c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number,  error:Number = 0.75):void
		{
			super.cubicCurveTo(c1x, c1y, c2x, c2y, a2x, a2y, BEZIER_ERROR);
		}
		
		public function drawLineTexture(thickness:Number, texture:Bitmap):void
		{
			if (_storedLineTexture == null)
			{
				_storedLineTexture = Texture.fromBitmap(texture);
			}
			
			super.lineTexture(thickness, _storedLineTexture);
		}
		
		public function updateLineTexture(newTexture:Bitmap):void
		{
			_storedLineTexture = Texture.fromBitmap(newTexture);
		}
		
		public function animateTexture(uSpeed:Number, vSpeed:Number, thickness:Number, texture:Bitmap):void
		{
			if (_animatedMaterial == null)
			{
				_animatedMaterial = new StandardMaterial();
			}

			if (_storedAnimatedTexture == null)
			{
				_storedAnimatedTexture = Texture.fromBitmap(texture, false);
			}
			
			_animatedMaterial.vertexShader = new AnimateUVVertexShader(uSpeed, vSpeed);
			_animatedMaterial.fragmentShader = new TextureFragmentShader();
			_animatedMaterial.textures[0] = _storedAnimatedTexture;	
			
			super.lineMaterial(thickness, _animatedMaterial);
		}
		
		public function updateAnimateTexture(newTexture:Bitmap):void
		{
			_storedAnimatedTexture = Texture.fromBitmap(newTexture);
		}
		
		public function beginGradientFill(gradientType:String, colours:Array, alphaValues:Array, ratio:Array):void
		{
				var bgMatrix:Matrix = new Matrix();
				var maxSquare:Number;
				var stageH:Number = _displayObjectContainer.height;
				var stageW:Number = _displayObjectContainer.width;

				//I am making a gradient to fit my stage, but I don't want to distort the circular shape, the * 2.48 is to match the 248% scale I used in photoshop when visualising the gradient.
				if (stageH <= stageW) { maxSquare = stageH * 2.48 } else { maxSquare = stageW * 2.48 }

				var boxRotation:Number = Math.PI/2; // 90° Rotation value in radians, in photoshop the angle was set to 90 degrees for me, 0 might be fine for you.
				//Setting the starting x/y values, as the gradient is larger than the stage to center it I need to offset it a bit.
				var tx:Number = (stageW/2)-(maxSquare/2);
				var ty:Number = (stageH/2)-(maxSquare/2);
				//width,height,angle,offsetX,offsetY
				bgMatrix.createGradientBox(maxSquare, maxSquare, boxRotation, tx, ty);

				var bgGradientTexture:Texture = GradientTexture.create(
					stageH, 	//Define Width and Height to draw to, if less than defined in bgMatrix will clip the gradient
					stageW,
					gradientType, 	//Gradient type
					colours, //Colours
					alphaValues, 	//Alpha values 0-1
					ratio, 	//Ratio, where the colour is input into the gradient space, 0 left, 255 right, can be placed anywhere between
					bgMatrix) 	//Matrix to use, optional but gives finer control of the gradient appearance

				var img:Image = new Image(bgGradientTexture);
				_container.addChild(img);
				
		}
		
	}

}