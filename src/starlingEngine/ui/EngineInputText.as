package starlingEngine.ui 
{
	import bridge.abstract.ui.IAbstractInputText;
	import feathers.controls.TextInput;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineInputText extends TextInput implements IAbstractInputText
	{
		
		public function EngineInputText(width:int, height:int, text:String = "", fontName:String="Verdana", fontSize:Number=12, color:uint=0) 
		{
			super();
			
			this.width = width;
			this.height = height;
			this.text = text;
			this.textEditorProperties.fontFamily = fontName;
			this.textEditorProperties.fontSize = fontSize;
			this.textEditorProperties.color = color;
		}
		
	}

}