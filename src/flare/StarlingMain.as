package flare
{
	import flare.basic.*;
	import starling.core.*;
	import starling.display.*;
	import starling.events.*;
	import starling.textures.*;
 
	public class StarlingMain extends Sprite
	{
		
		private var _scene:Scene3D;
		
		public function StarlingMain()
		{
			
		}
 
		
 
		private function frameEvent( e:Event ):void
		{
			
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