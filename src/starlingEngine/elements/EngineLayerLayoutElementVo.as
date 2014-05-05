package starlingEngine.elements 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineLayerLayoutElementVo 
	{
		
		public var name:String;
		public var type:String;
		
		public var resource:String
		
		public var onStage:String;
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var fps:uint = 30;
		
		public var layerDepth:Number;
		
		public var loop:Boolean = false;
					
		public function EngineLayerLayoutElementVo() 
		{
			
		}
		
	}

}