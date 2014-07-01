package  
{
	import citrus.core.CitrusObject;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import nape.geom.Vec2;
	import objects.DraggableCube;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starlingEngine.elements.EngineState;
	/**
	 * ...
	 * @author Eu
	 */
	public class PhysicsState extends EngineState
	{
		
		public function PhysicsState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var nape:Nape = new Nape("nape");
			nape.visible = true;
			nape.gravity = new Vec2(0, 50);
			add(nape);
			
			add(new Platform("borderBottom", { x:400, y:600 - 10, width:800, height:10 } ));
			add(new Platform("borderLeft", { x:0, y:0, width:10, height:600 } ));
			add(new Platform("borderRight", { x:800 - 10, y:0, width:10, height:600 } ));
			
			var obj1:NapePhysicsObject = new NapePhysicsObject("test", { view:new Quad(50, 50), width:50, height:50, x:100, y:100 } );
			
			var obj2:DraggableCube = new DraggableCube("cube", { view:new Quad(50, 50), x:400, y:400 } );
			
			add(obj1);
			add(obj2);
			
			stage.addEventListener(TouchEvent.TOUCH, _handleTouch);
		}
		
		private function _handleTouch(tEvt:TouchEvent):void 
		{
 
			var art:DisplayObject = (tEvt.target as DisplayObject).parent;
		 
			var touchBegan:Touch = tEvt.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = tEvt.getTouch(this, TouchPhase.ENDED);
		 
			if (art && (touchBegan || touchEnded)) {
		 
				var object:CitrusObject = (view.getObjectFromArt(art)) as CitrusObject;
		 
				if (object) {
		 
					if (object is DraggableCube) {
		 
						if (touchBegan)
							(object as DraggableCube).enableHolding(art);
						else if (touchEnded)
							(object as DraggableCube).disableHolding();
					}
				}
			}
		}
		
	}

}