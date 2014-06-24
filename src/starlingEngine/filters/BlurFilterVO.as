package starlingEngine.filters 
{
	import bridge.abstract.filters.IAbstractBlurFilter;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class BlurFilterVO implements IAbstractBlurFilter
	{
		
		private var _blurX:Number = 1;
		private var _blurY:Number = 1;
		private var _resolution:Number = 0.5;
		
		public function BlurFilterVO(blurX:Number=1, blurY:Number=1, resolution:Number=1) 
		{
			_blurX = blurX;
			_blurY = blurY;
			_resolution = resolution;
		}
		
		public function set blurX(val:Number):void
		{
			_blurX = val
		}
		
		public function get blurX():Number
		{
			return _blurX
		}
		
		public function set blurY(val:Number):void
		{
			_blurY = val;
		}
		
		public function get blurY():Number
		{
			return _blurY
		}
		
		public function set resolution(val:Number):void
		{
			resolution = val;
		}
		
		public function get resolution():Number
		{
			return resolution
		}
		
	}

}