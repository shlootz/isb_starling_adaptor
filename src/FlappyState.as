package  
{
	import bridge.IBridgeGraphics;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Enemy;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import flash.geom.Point;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starlingEngine.elements.EngineState;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class FlappyState extends EngineState
	{
		
		private var _bridge:IBridgeGraphics
		private var _hero:Hero;
		
		public function FlappyState(bridge:IBridgeGraphics) 
		{
			super();
			_bridge = bridge;
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			var nape:Nape = new Nape("nape", {gravity:new Vec2(0, 500)});
			nape.visible = true;
			add(nape);
			
			add(new CitrusSprite("backgroud", { parallaxX:0.02, parallaxY:0, view:_bridge.requestImage("Background") } ));
			add(new Platform("platformBot", { x:250, y:500, width:500, height:10 } ));
			
			_hero = new Hero("Gheorghe", {x:300, y:400});
			add(_hero);
			
			addEventListener(Event.ENTER_FRAME, loop);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
			}
		}
		
		private function loop(event:Event):void
		{
			add(new Enemy("asd", {x:Math.random()*800, y:0}))
		}
		
	}

}