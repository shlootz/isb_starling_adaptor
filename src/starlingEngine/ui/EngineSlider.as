package starlingEngine.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import feathers.controls.Button;
	import feathers.controls.Slider;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starlingEngine.elements.EngineSprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineSlider extends EngineSprite implements IAbstractSlider
	{
		
		private var slider:Slider;
		private var _sliderComponentX:uint = 0;
		private var _sliderComponentY:uint = 0;
		private var _anchor:Function;
		
		public function EngineSlider(thumbUpSkin:IAbstractImage,
														thumbDownSkin:IAbstractImage, 
														trackUpSkin:IAbstractImage, 
														trackDownSkin:IAbstractImage,
														backgroundSkin:IAbstractImage,
														label:IAbstractLabel) 
		{
			 slider = new Slider();
			 slider.minimum = 0;
			 slider.maximum = 100;
			 slider.step = 1;
			 slider.value = 50;
			 slider.addEventListener( Event.CHANGE, slider_changeHandler );
			 
			 slider.thumbFactory = function():feathers.controls.Button
			{
				var button:feathers.controls.Button = new feathers.controls.Button();
				//skin the thumb here
				button.defaultSkin = thumbUpSkin as Image;
				button.downSkin = thumbDownSkin as Image;
				return button;
			}
			
			slider.minimumTrackFactory = function():feathers.controls.Button
			{
				var button:feathers.controls.Button = new feathers.controls.Button();
				//skin the minimum track here
				button.defaultSkin = trackUpSkin as Image;
				button.downSkin = trackDownSkin as Image;
				return button;
			}
			
			this.addNewChild(backgroundSkin);
			this.addNewChild( slider );
			this.addNewChild(label)
		}
		
		public function get sliderComponentX():uint
		{
			return _sliderComponentX;
		}
		
		public function set sliderComponentX(val:uint):void
		{
			_sliderComponentX = val;
			slider.x = _sliderComponentX;
		}
		
		public function get sliderComponentY():uint
		{
			return _sliderComponentY;
		}
		
		public function set sliderComponentY(val:uint):void
		{
			_sliderComponentY = val;
			slider.y = _sliderComponentY;
		}
		
		public function get anchor():Function
		{
			return _anchor;
		}
		
		public function set anchor(val:Function):void
		{
			_anchor = val;
		}
		
		private function slider_changeHandler(e:Event):void
		{
			var o:Object = {
				name:this.name,
				amount:slider.value,
				target:e.currentTarget,
				event:e
			}
			_anchor.apply(null, [o]);
		}
		
	}

}