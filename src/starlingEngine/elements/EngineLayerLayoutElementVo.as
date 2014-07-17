package starlingEngine.elements 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayerLayoutElementVo 
	{
		
		public var layerX:Number;
		public var layerY:Number;
		
		public var name:String;
		public var type:String;

		public var resource:String
		public var upState:String
		public var overState:String
		public var pressedState:String
		public var disabledState:String
		
		public var onStage:String;
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var fps:uint = 30;
		
		public var layerDepth:Number;
		
		public var loop:Boolean = false;
		
		public var labelWidth:Number;
		public var labelHeight:Number;
		public var label:String;
		public var font:String;
		public var labelFontSize:Number;
		public var labelFontColor:uint;
		public var labelX:Number;
		public var labelY:Number;
		
		public var icon:String;
		public var iconOffsetX:Number;
		public var iconOffsetY:Number;
		
		public var iconOff:String;
		public var iconOn:String;
		
		public var thumbUpSkin:String;
		public var thumbDownSkin:String;
		public var trackUpSkin:String;
		public var trackDownSkin:String;
		public var background:String;
		public var sliderX:Number;
		public var sliderY:Number;
		
		public var flipped:Boolean = false;
					
		public function EngineLayerLayoutElementVo() 
		{
			
		}
		
	}

}