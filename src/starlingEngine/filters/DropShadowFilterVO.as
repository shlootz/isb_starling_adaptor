package starlingEngine.filters 
{
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class DropShadowFilterVO implements IAbstractDropShadowFilter
	{
		
		private var _distance:Number = 4;
		private var _angle:Number = 0.785;
		private var _color:uint = 0;
		private var _alpha:Number = 0.5;
		private var _blur:Number = 1;
		private var _resolution:Number = 0.5;
		
		public function DropShadowFilterVO(distance:Number=4, angle:Number=0.785, color:uint=0, alpha:Number=0.5, blur:Number=1, resolution:Number=0.5) 
		{
			_distance = distance;
			_angle = angle;
			_color = color;
			_alpha = alpha;
			_blur = blur;
			_resolution = resolution;
		}
		
		public function set distance(val:Number):void
		{
			_distance = val;
		}
		
		public function get distance():Number
		{
			return _distance
		}
		
		public function set angle(val:Number):void
		{
			_angle = val;
		}
		
		public function get angle():Number
		{
			return _angle
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