package starlingEngine.ui 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.ui.IAbstractToggle;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * ...
	 * @author  Alex Popescu
	 */
	public class EngineToggleButton extends EngineButton implements IAbstractToggle
	{
		
		private var _toggle:Boolean = false;
		private var _toggleTrueImage:IAbstractImage;
		private var _toggleFalseImage:IAbstractImage;
		
		public function EngineToggleButton() 
		{
			super();
			addEventListener(TouchEvent.TOUCH, toggleButtonTouched);
		}
		
		public function toggle(val:Boolean):void
		{
			_toggle = val;
			if (_toggle)
			{
				upIcon_ = selectedUpIcon_ = selectedHoverIcon_ = hoverIcon_ = disabledIcon_ = selectedDownIcon_ = _toggleTrueImage;
			}
			else
			{
				upIcon_ = selectedUpIcon_ = selectedHoverIcon_ = hoverIcon_ = disabledIcon_ = selectedDownIcon_ = _toggleFalseImage;
			}
		}
		
		public function get state():Boolean
		{
			return _toggle;
		}
		
		public function set toggleTrueImage(val:IAbstractImage):void
		{
			_toggleTrueImage = val;
		}
		
		public function set toggleFalseImage(val:IAbstractImage):void
		{
			_toggleFalseImage = val;
			toggle(false);
		}
		
		private function toggleButtonTouched(event:TouchEvent):void
		{
			var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			
			if (touchBegan)
			{
				toggle(!_toggle);
			}
		}
		
	}

}