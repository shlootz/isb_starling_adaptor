package starlingEngine.filters 
{
	import bridge.abstract.filters.IAbstractGlowFilter;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class GlowFilterVO implements IAbstractGlowFilter
	{
		
		private var _color:uint = 0;
		private var _alpha:Number = 0.5;
		private var _blur:Number = 1;
		private var _resolution:Number = 0.5;
		
		public function GlowFilterVO(color:uint=16776960, alpha:Number=1, blur:Number=1, resolution:Number=0.5) 
		{
			_color = color;
			_alpha = alpha;
			_blur = blur;
			_resolution = resolution;
		}
		
		public function set color(val:uint):void
		{
			_color = val;
		}
		
		public function get color():uint
		{
			return _color
		}
		
		public function set alpha(val:Number):void
		{
			_alpha = val;
		}
		
		public function get alpha():Number
		{
			return _alpha
		}
		
		public function set blur(val:Number):void
		{
			_blur = val;
		}
		
		public function get blur():Number
		{
			return _blur
		}
		
		public function set resolution(val:Number):void
		{
			_resolution = val;
		}
		
		public function get resolution():Number
		{
			return _resolution
		}
		
	}

}