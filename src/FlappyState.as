package  
{
	import bridge.IBridgeGraphics;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Enemy;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.events.Event;
	import starlingEngine.elements.EngineState;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class FlappyState extends EngineState
	{
		
		private var _bridge:IBridgeGraphics
		
		public function FlappyState(bridge:IBridgeGraphics) 
		{
			super();
			_bridge = bridge;
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			var nape:Nape = new Nape("nape", {gravity:new Vec2(0, 150)});
			nape.visible = true;
			add(nape);
			
			add(new CitrusSprite("backgroud", { parallaxX:0.02, parallaxY:0, view:_bridge.requestImage("Background") } ));
			add(new Platform("platformBot", { x:250, y:500, width:500, height:10 } ));
			add(new Hero("Gheorghe"));
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void
		{
			//add(new Enemy("Ghita", {x:Math.random()*800}));
		}
		
	}

}