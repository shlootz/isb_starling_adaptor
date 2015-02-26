package starlingEngine.elements 
{
import bridge.abstract.IAbstractAnimatable;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractMovie;

import flash.display.BitmapData;
import flash.media.Sound;

import starling.display.Image;
import starling.display.MovieClip;
import starling.textures.Texture;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineMovie extends MovieClip implements IAbstractMovie, IAbstractAnimatable
	{
		private var _frames:Vector.<Texture> = new Vector.<Texture>();
		private var _frame:Number;
		/**
		 * 
		 * @param	vector
		 * @param	fps
		 */
		public function EngineMovie(vector:Vector.<Texture>, fps:uint = 24) 
		{
			_frames = vector;
			super(vector, fps);
		}
		/**
		 * 
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		public function addNewFrame(image:IAbstractImage, sound:Sound = null, duration:Number = -1):void
		{
			super.addFrame(image.currentTexture as Texture, sound, duration);
		}
		/**
		 * 
		 * @param	frameID
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		public function addNewFrameAt(frameID:uint, image:IAbstractImage, sound:Sound = null, duration:Number = -1):void
		{
			super.addFrameAt(frameID, image.currentTexture as EngineTexture, sound, duration);
		}
		/**
		 * 
		 * @param	frameID
		 * @return
		 */
		public function getTextureFromFrame(frameID:uint):IAbstractImage
		{
			return new Image(super.getFrameTexture(frameID) as Texture) as IAbstractImage
		}
		/**
		 * 
		 * @param	frameID
		 * @param	texture
		 */
		public function setTextureToFrame(frameID:uint, image:IAbstractImage):void
		{
			super.setFrameTexture(frameID, image.currentTexture as EngineTexture);
		}
		
		/**
		 * 
		 */
		public function get currentTexture () : Object
		{
			return super.texture as Object;
		}

		/**
		 * 
		 */
		public function set newTexture (value:Object) : void
		{
			super.texture = value as Texture;
		}
		
		/**
		 * 
		 */
		public function set newTextureFromBitmapData(value:BitmapData):void
		{
			super.texture = Texture.fromBitmapData(value);
		}
		
		public function get frame():Number 
		{
			return this.currentFrame;
		}
		
		public function set frame(value:Number):void 
		{
			this.currentFrame = value;
		}
		
		/**
		 * 
		 * @param	frame
		 */
		public function gotoAndStop(frame:int):void
		{
			this.currentFrame = frame;
			this.pause();
		}
		
		/**
		 * 
		 * @param	frame
		 */
		public function gotoAndPlay(frame:int):void
		{
			this.currentFrame = frame;
			this.play();
		}
	}

}