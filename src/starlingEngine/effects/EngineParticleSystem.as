package starlingEngine.effects 
{
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.IAbstractImage;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import starlingEngine.elements.EngineSprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineParticleSystem extends EngineSprite implements IAbstractParticleSystem
	{
		
		private var _texture:Texture;
		private var _configXML:XML;
		private var _particleSystem:PDParticleSystem;
		private var _juggler:Juggler;
		
		public function EngineParticleSystem(configXML:XML, imageSource:IAbstractImage, juggler:Juggler) 
		{
			_configXML = configXML;
			_texture = imageSource.currentTexture as Texture;
			_juggler = juggler;
			
			_particleSystem = new PDParticleSystem(configXML, _texture);
			this.addNewChild(_particleSystem)
		}
		
		public function start(duration:Number = Number.MAX_VALUE):void
		{
			_juggler.add(_particleSystem);
			_particleSystem.start(duration);
		}
		
		public function stop():void
		{
			_particleSystem.stop();
		}
		
		public function clear():void
		{
			_juggler.remove(_particleSystem);
			_particleSystem.removeFromParent(true);
			this.dispose();
		}
		
		public function setEmmiter(position:Point):void
		{
			_particleSystem.emitterX = position.x;
			_particleSystem.emitterY = position.y;
		}
		
	}

}