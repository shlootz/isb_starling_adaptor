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
			nape.gravity = new Vec2(0, 0);
			add(nape);
			
			add(new Platform("borderBottom", { x:400, y:600 - 10, width:800, height:10 } ));
			add(new Platform("borderLeft", { x:0, y:300, width:10, height:600 } ));
			add(new Platform("borderRight", { x:800 - 10, y:300, width:10, height:600 } ));
			add(new Platform("borderTop", { x:400 , y:0, width:800, height:10 } ));
			
			for (var i:uint = 0; i < 300; i++ )
			{
				var w:Number = Math.random() * 50;
				add(new DraggableCube("cube"+i, { view:new Quad(w,w, Math.random()*0xffffff), width:w, height:w, x:Math.random()*800, y:Math.random()*600 } ));
			}
			add(new DraggableCube("cube", { view:new Quad(200,200, Math.random()*0xffffff), width:200, height:200, x:50, y:50} ));
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