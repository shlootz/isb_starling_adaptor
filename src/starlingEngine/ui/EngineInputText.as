package starlingEngine.ui 
{
import bridge.abstract.ui.IAbstractInputText;

import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

import flash.display.Bitmap;

import starlingEngine.signals.Signals;
import signals.ISignalsHub;

import starling.display.Image;
import starling.events.Event;

import starlingEngine.events.GESignalEvent;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineInputText extends TextInput implements IAbstractInputText
	{
		private var _backgroundBitmap:Bitmap;
		private var _signalsManager:ISignalsHub;
		
		/**
		 * 
		 * @param	signalsManager
		 * @param	width
		 * @param	height
		 * @param	text
		 * @param	fontName
		 * @param	fontSize
		 * @param	color
		 */
		public function EngineInputText(signalsManager:Object, width:int, height:int, text:String = "", fontName:String="Verdana", fontSize:Number=12, color:uint=0) 
		{
			super();
			
			_signalsManager = signalsManager as ISignalsHub;
			 
			this.width = width;
			this.height = height;
			this.text = text;
			this.textEditorProperties.fontFamily = fontName;
			this.textEditorProperties.fontSize = fontSize;
			this.textEditorProperties.color = color;
			
			addEventListener( Event.CHANGE, input_changeHandler );
			addEventListener( FeathersEventType.ENTER, input_enterHandler );
			addEventListener( FeathersEventType.FOCUS_IN, input_FocusInHandler );
			addEventListener( FeathersEventType.FOCUS_OUT, input_FocusOutHandler );
		}
		
		public function set restriction(val:String):void
		{
			this.restrict = val;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function input_enterHandler(e:Event):void 
		{
			var o:GESignalEvent = new GESignalEvent()
			o.eventName = Signals.TEXT_INPUT_CHANGED;
			o.engineEvent = e;
			o.params = {
				text:this.text
			}
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_CHANGED, this.name, o);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function input_changeHandler(e:Event):void 
		{
			var o:GESignalEvent = new GESignalEvent()
			o.eventName = Signals.TEXT_INPUT_CHANGED;
			o.engineEvent = e;
			o.params = {
				text:this.text
			}
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_CHANGED, this.name, o);
		}
		
		private function input_FocusInHandler(e:Event):void
		{
			var o:GESignalEvent = new GESignalEvent()
			o.eventName = Signals.TEXT_INPUT_FOCUS_IN;
			o.engineEvent = e;
			o.params = {
				text:this.text
			}
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_FOCUS_IN, this.name, o);
		}
		
		private function input_FocusOutHandler(e:Event):void
		{
			var o:GESignalEvent = new GESignalEvent()
			o.eventName = Signals.TEXT_INPUT_FOCUS_OUT;
			o.engineEvent = e;
			o.params = {
				text:this.text
			}
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_FOCUS_OUT, this.name, o);
		}
		
		public function set backgroundBitmap(val:Bitmap):void
		{
			var backgroundImage:Image = Image.fromBitmap(val);
			this.backgroundSkin = backgroundImage;
		}
		
	}

}