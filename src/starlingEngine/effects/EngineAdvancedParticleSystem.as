package starlingEngine.effects 
{
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.IAbstractImage;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.display.FFParticleSystem;
	import starling.display.FFParticleSystem.SystemOptions;
	import starling.display.Image;
	import starling.textures.Texture;
	import starlingEngine.elements.EngineSprite;
	/**
	 * ...
	 * @author Eu
	 */
	public class EngineAdvancedParticleSystem extends EngineSprite implements IAbstractParticleSystem
	{
		
		private var _texture:Texture;
		private var _particlesConfig:SystemOptions;
		private var _particleSystem:FFParticleSystem;
		private var _juggler:Juggler;
		
		public function EngineAdvancedParticleSystem(configXML:XML, imageSource:IAbstractImage, juggler:Juggler, atlasXML:XML = null) 
		{
			_juggler = juggler;
			_texture = (imageSource as Image).texture;
			_particlesConfig = new SystemOptions(_texture, atlasXML, configXML);
			_particleSystem = new FFParticleSystem(_particlesConfig);
			
			this.addNewChild(_particleSystem);
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