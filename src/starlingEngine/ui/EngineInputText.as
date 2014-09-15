package starlingEngine.ui 
{
	import bridge.abstract.ui.IAbstractInputText;
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.events.Event;
	import starlingEngine.events.GESignalEvent;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineInputText extends TextInput implements IAbstractInputText
	{
		
		private var _signalsManager:SignalsHub;
		
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
			
			_signalsManager = signalsManager as SignalsHub;
			
			this.width = width;
			this.height = height;
			this.text = text;
			this.textEditorProperties.fontFamily = fontName;
			this.textEditorProperties.fontSize = fontSize;
			this.textEditorProperties.color = color;
			
			addEventListener( Event.CHANGE, input_changeHandler );
			addEventListener( FeathersEventType.ENTER, input_enterHandler );
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
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_CHANGED, o.params["text"], o);
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
			_signalsManager.dispatchSignal(Signals.TEXT_INPUT_CHANGED, o.params["text"], o);
		}
		
	}

}