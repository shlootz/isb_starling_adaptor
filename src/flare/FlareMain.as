package flare
{
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flare.primitives.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import starling.core.*;
	import starling.display.*;
	import starling.events.*;
 
	[SWF(width = "800", height = "450", frameRate = "60", backgroundColor = "#ffffff")]
 
	public class FlareMain extends Sprite
	{
 
		private var _scene:Scene3D;
		private var _starling:Starling;
		private var _starlingRoot:starling.display.Sprite;
		private var _elsa:Pivot3D;
		private var _cubes:Pivot3D;
		private var _spinY:Number = 0;
 
		public function FlareMain()
		{
			// we create our standard Flare3D Viewer, with a costom-located camera and a test model
			_scene = new Viewer3D( this );
            _scene.addEventListener( flash.events.Event.CONTEXT3D_CREATE, contextCreate );
			_scene.autoResize = true;
 
			_scene.antialias = 2;
			_scene.clearColor = new Vector3D( 1, 1, 1 );
 
			_scene.camera = new Camera3D();
			_scene.camera.setPosition( 10, 100, -200 );
			_scene.camera.lookAt( 0, 0, 0 );
			_scene.registerClass( ZF3DLoader );
			//_elsa = _scene.addChildFromFile( new ElsaModel() );
 
			// we add some more cubes
			var cube:Cube = new Cube( "cube", 30, 30, 30 );
			_cubes = new Pivot3D();
			_cubes.addChild( cube.clone() ).setPosition( 100, 0, 0 );
			_cubes.addChild( cube.clone() ).setPosition( -100, 0, 0 );
			_cubes.addChild( cube.clone() ).setPosition( 0, 0, 100 );
			_cubes.addChild( cube.clone() ).setPosition( 0, 0, -100 );
 
			// during this phase we'll take care of drawing Starling's content
			_scene.addEventListener( Scene3D.POSTRENDER_EVENT, postRenderEvent );
		}
 
                private function contextCreate( e:Event ):void
		{
                        // we create our Starling instance and the "root" Starling Sprite object
			// shareContext must be set to "true" so Starling won't overwrite our
			// Context3D object
			_starling = new Starling( StarlingMain, stage, null, stage.stage3Ds[0] );
			_starling.addEventListener( "rootCreated", starlingRootEvent );
			_starling.start();
		}
 
		private function starlingRootEvent( e:Event ):void
		{
			// now that we've made sure that the "root" object has been created,
			// we can add listeners to our button events to make Elsa rotate
			// when pressed
			_starlingRoot = _starling.root as starling.display.Sprite;
			_starlingRoot.addEventListener( "leftButtonEvent",  leftButton );
			_starlingRoot.addEventListener( "rightButtonEvent",  rightButton );
		}
 
		private function leftButton( e:starling.events.Event ):void
		{
			_spinY += 50;
		}
 
		private function rightButton( e:Event ):void
		{
			_spinY -= 50;
		}
 
		private function postRenderEvent( e:Event ):void
		{
			// prepare and draw the Starling frame
			_starling.nextFrame();
 
			// update Flare3D content
			_cubes.draw(true);
			//_elsa.rotateY( _spinY / 25, false );
			_spinY *= 0.95;
		}
	}
}