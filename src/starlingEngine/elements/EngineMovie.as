package starlingEngine.elements 
{
	import bridge.abstract.IAbstractAnimatable;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractTexture;
	import flash.media.Sound;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineMovie extends MovieClip implements IAbstractMovie, IAbstractAnimatable
	{
		/**
		 * 
		 * @param	vector
		 * @param	fps
		 */
		public function EngineMovie(vector:Vector.<Texture>, fps:uint = 24) 
		{
			super(vector, fps);
		}
		/**
		 * 
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		public function addNewFrame(texture:IAbstractTexture, sound:Sound = null, duration:Number = -1):void
		{
			super.addFrame(texture as Texture, sound, duration);
		}
		/**
		 * 
		 * @param	frameID
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		public function addNewFrameAt(frameID:uint, texture:IAbstractTexture, sound:Sound = null, duration:Number = -1):void
		{
			super.addFrameAt(frameID, texture as EngineTexture, sound, duration);
		}
		/**
		 * 
		 * @param	frameID
		 * @return
		 */
		public function getTextureFromFrame(frameID:uint):IAbstractTexture
		{
			return super.getFrameTexture(frameID) as IAbstractTexture
		}
		/**
		 * 
		 * @param	frameID
		 * @param	texture
		 */
		public function setTextureToFrame(frameID:uint, texture:IAbstractTexture):void
		{
			super.setFrameTexture(frameID, texture as EngineTexture);
		}
		
		public function get currentTexture () : Object
		{
			return super.texture as Object;
		}

		public function set newTexture (value:Object) : void
		{
			super.texture = value as Texture;
		}

	}

}