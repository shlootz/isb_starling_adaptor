package starlingEngine.elements 
{
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractGraphics;
	import starling.display.DisplayObjectContainer;
	import starling.display.Graphics;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineGraphics extends Graphics implements IAbstractGraphics
	{
		
		protected static const BEZIER_ERROR:Number = 0.75;
		
		public function EngineGraphics(displayObjectContainer:IAbstractDisplayObjectContainer) 
		{
			super(displayObjectContainer as DisplayObjectContainer);
		}
		
		override public function curveTo( cx:Number, cy:Number, a2x:Number, a2y:Number,  error:Number = 0.75 ):void
		{
			super.curveTo(cx,cy,a2x,a2y,BEZIER_ERROR)
		}
		
		override public function cubicCurveTo( c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number,  error:Number = 0.75):void
		{
			super.cubicCurveTo(c1x, c1y, c2x, c2y, a2x, a2y, BEZIER_ERROR);
		}
		
	}

}