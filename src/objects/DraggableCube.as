package objects {
 
	import citrus.objects.NapePhysicsObject;
 
	import nape.callbacks.InteractionCallback;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.geom.Vec3;
 
	import starling.core.Starling;
	import starling.display.DisplayObject;
 
	/**
	 * @author Aymeric
	 */
	public class DraggableCube extends NapePhysicsObject {
 
		private var _hand:PivotJoint;
		private var _mouseScope:DisplayObject;
 
		public function DraggableCube(name:String, params:Object = null)
		{
			super(name, params);
			this.touchable = true;
			this.updateCallEnabled = true;
		}
 
		override protected function createConstraint():void {
 
			super.createConstraint();
 
			_hand = new PivotJoint(_nape.space.world, _body,  Vec2.weak(),  Vec2.weak());
			_hand.active = false;
			_hand.stiff = false;
			_hand.space = _nape.space;
			_hand.maxForce = 5000;
		}
 
		override public function destroy():void {
 
			_hand.space = null;
 
			super.destroy();
		}
 
		override public function update(timeDelta:Number):void {
 
			super.update(timeDelta);
			
			if (_mouseScope)
				_hand.anchor1.setxy(_ce.stage.mouseX / Starling.contentScaleFactor, _ce.stage.mouseY / Starling.contentScaleFactor);
 
		}
 
		public function enableHolding(mouseScope:DisplayObject):void {
 
			_mouseScope = mouseScope;
 
			var mp:Vec2 = new Vec2(x, y);
 
            _hand.anchor2.set(_body.worldPointToLocal(mp, true));
            _hand.active = true;
		}
 
		public function disableHolding():void {
 
			_hand.active = false;
			_mouseScope = null;
		}
 
	}
}