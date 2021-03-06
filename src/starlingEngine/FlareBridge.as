package starlingEngine 
{
import flare.basic.Scene3D;
import flare.basic.Viewer3D;
import flare.core.Camera3D;
import flare.core.Pivot3D;

import flash.display.Sprite;
import flash.display3D.Context3D;
import flash.events.Event;
import flash.geom.Vector3D;

import signals.ISignalsHub;

import starling.core.Starling;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class FlareBridge 
	{
		public static const FLARE_INITED:String = "FlareInited";
		
		private var _scene:Scene3D;
		private var _signalsManager:ISignalsHub;

		public var _starling:Starling;
		
		public function FlareBridge(signalsManager:ISignalsHub, target:Sprite, starling:Starling) 
		{
			_signalsManager = signalsManager;
			_starling = starling;
			
			_scene = new Scene3D( target );
            _scene.addEventListener( Event.CONTEXT3D_CREATE, contextCreate );
			_scene.autoResize = true;
 
			_scene.antialias = 2;
			_scene.clearColor = new Vector3D( 0, 0, 0 );
 
			_scene.camera = new Camera3D();
			_scene.camera.setPosition( 10, 100, -200 );
			_scene.camera.lookAt( 0, 0, 0 );
			_scene.addEventListener( Scene3D.POSTRENDER_EVENT, postRenderEvent );
		}

		/**
		 * 
		 * @param	e
		 */
		private function contextCreate( e:Event ):void
		{
            // we create our Starling instance and the "root" Starling Sprite object
			// shareContext must be set to "true" so Starling won't overwrite our
			// Context3D object
			_signalsManager.dispatchSignal(FLARE_INITED, FLARE_INITED, new Object());
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function postRenderEvent( e:Event ):void
		{
			// prepare and draw the Starling frame

			if (_starling)
			{
				_starling.nextFrame();
			}
			
		}	
		
		/**
		 * 
		 * @return
		 */
		public function getFlareContext():Context3D
		{
			return _scene.context;
		}
		
		public function get scene():Scene3D 
		{
			return _scene;
		}
		
		public function set scene(value:Scene3D):void 
		{
			_scene = value;
		}
	}

}