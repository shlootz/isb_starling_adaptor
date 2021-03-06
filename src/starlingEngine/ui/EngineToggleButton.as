package starlingEngine.ui 
{
import bridge.abstract.IAbstractImage;
import bridge.abstract.ui.IAbstractToggle;

import starlingEngine.events.EngineEvent;

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
			addEventListener(EngineEvent.TRIGGERED, toggle_button_triggeredHandler);
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
	
		private function toggle_button_triggeredHandler(e:Object):void
		{
			toggle(!_toggle);
		}
		
	}

}