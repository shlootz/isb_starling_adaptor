package starlingEngine.elements 
{
import bridge.abstract.IAbstractSprite;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.ui.IAbstractLabel;

import starling.text.TextField;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLabel extends EngineSprite implements IAbstractLabel, IAbstractSprite
	{
		
		private var _tField:IAbstractTextField;
		
		public function EngineLabel(textField:IAbstractTextField) 
		{
			_tField = textField;			
			addNewChild(_tField as TextField);
		}
		
		public function updateLabel(text:String, autoFit:Boolean = true):void
		{
			_tField.text = text;
			if (autoFit)
			{
				(_tField as EngineTextField).fitFont();
			}
		}
		
		public function get textField():IAbstractTextField
		{
			return _tField;
		}
		
	}

}