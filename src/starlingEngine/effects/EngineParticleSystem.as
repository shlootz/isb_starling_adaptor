package starlingEngine.effects 
{
import bridge.abstract.IAbstractImage;
import bridge.abstract.effects.IAbstractParticleSystem;

import flash.geom.Point;

import starling.animation.Juggler;
import starling.extensions.particles.ColorArgb;
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
		
		public function updateConfigXML(newConfigXML:XML, atlasXML:XML = null):void
		{
			trace("StarlingEngine :: EngineParticleSystem :: WARNING :: updateConfigXML only available for Advanced Particle System");
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
		
		/////////////////////////////////////// SYSTEM PROPERTIES //////////////////////////////////////////////
		
		/**
		 * 
		 * @return
		 */
		public function get emissionRate():Number
		{
			return _particleSystem.emissionRate
		}
		public function set emissionRate(val:Number):void
		{
			_particleSystem.emissionRate = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitAngle():Number
		{
			return _particleSystem.emitAngle
		}
		public function set emitAngle(val:Number):void
		{
			_particleSystem.emitAngle = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitAngleAlignedRotation():Boolean
		{
			return false
		}
		public function set emitAngleAlignedRotation(val:Boolean):void
		{
			
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitAngleVariance():Number
		{
			return _particleSystem.emitAngleVariance
		}
		public function set emitAngleVariance(val:Number):void
		{
			_particleSystem.emitAngleVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitter():Point
		{
			return new Point(_particleSystem.emitterX, _particleSystem.emitterY); 
		}
		public function set emitter(val:Point):void
		{
			_particleSystem.emitterX = val.x;
			_particleSystem.emitterY = val.y;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterObject():Object
		{
			return null
		}
		public function set emitterObject(val:Object):void
		{
			_particleSystem.emitterX = val.x;
			_particleSystem.emitterY = val.y;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterType():Number
		{
			return _particleSystem.emitterType
		}
		public function set emitterType(val:Number):void
		{
			_particleSystem.emitterType = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterX():Number
		{
			return _particleSystem.emitterX
		}
		public function set emitterX(val:Number):void
		{
			_particleSystem.emitterX = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterXVariance():Number
		{
			return _particleSystem.emitterXVariance
		}
		public function set emitterXVariance(val:Number):void
		{
			_particleSystem.emitterXVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterY():Number
		{
			return _particleSystem.emitterY
		}
		public function set emitterY(val:Number):void
		{
			_particleSystem.emitterY = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitterYVariance():Number
		{
			return _particleSystem.emitterYVariance
		}
		public function set emitterYVariance(val:Number):void
		{
			_particleSystem.emitterYVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get emitting():Boolean
		{
			return false
		}
		
		/**
		 * 
		 * @return
		 */
		public function get endRotation():Number
		{
			return _particleSystem.endRotation
		}
		public function set endRotation(val:Number):void
		{
			_particleSystem.endRotation = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get endRotationVariance():Number
		{
			return _particleSystem.endRotationVariance
		}
		public function set endRotationVariance(val:Number):void
		{
			_particleSystem.endRotationVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get endSize():Number
		{
			return _particleSystem.endSize
		}
		public function set endSize(val:Number):void
		{
			_particleSystem.endSize = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get endSizeVariance():Number
		{
			return _particleSystem.endSizeVariance
		}
		public function set endSizeVariance(val:Number):void
		{
			_particleSystem.endSizeVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get fadeInTime():Number
		{
			return 0
		}
		public function set fadeInTime(val:Number):void
		{
			
		}
		
		/**
		 * 
		 * @return
		 */
		public function get fadeOutTime():Number
		{
			return 0
		}
		public function set fadeOutTime(val:Number):void
		{
			
		}
	
		/**
		 * 
		 * @return
		 */
		public function get gravityX():Number
		{
			return 	_particleSystem.gravityX
		}
		public function set gravityX(val:Number):void
		{
				_particleSystem.gravityX = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get gravityY():Number
		{
			return _particleSystem.gravityY
		}
		public function set gravityY(val:Number):void
		{
			_particleSystem.gravityY = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get lifespan():Number
		{
			return _particleSystem.lifespan
		}
		public function set lifespan(val:Number):void
		{
			_particleSystem.lifespan = val;
		}
	
		/**
		 * 
		 * @return
		 */
		public function get lifespanVariance():Number
		{
			return 	_particleSystem.lifespanVariance
		}
		public function set lifespanVariance(val:Number):void
		{
				_particleSystem.lifespanVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get maxCapacity():Number
		{
			return _particleSystem.maxCapacity
		}
		public function set maxCapacity(val:Number):void
		{
			_particleSystem.maxCapacity = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get maxNumParticles():Number
		{
			return _particleSystem.maxNumParticles
		}
		public function set maxNumParticles(val:Number):void
		{
			_particleSystem.maxNumParticles = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get maxRadius():Number
		{
			return _particleSystem.maxRadius
		}
		public function set maxRadius(val:Number):void
		{
			_particleSystem.maxRadius = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get maxRadiusVariance():Number
		{
			return _particleSystem.maxRadiusVariance
		}
		public function set maxRadiusVariance(val:Number):void
		{
			_particleSystem.maxRadiusVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get minRadius():Number
		{
			return _particleSystem.minRadius
		}
		public function set minRadius(val:Number):void
		{
			_particleSystem.minRadius = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get minRadiusVariance():Number
		{
			return _particleSystem.minRadiusVariance
		}
		public function set minRadiusVariance(val:Number):void
		{
			_particleSystem.minRadiusVariance = val
		}
		
		/**
		 * 
		 * @return
		 */
		public function get numParticles():Number
		{
			return _particleSystem.numParticles
		}
		
		/**
		 * 
		 * @return
		 */
		public function get radialAcceleration():Number
		{
			return _particleSystem.radialAcceleration
		}
		public function set radialAcceleration(val:Number):void
		{
			_particleSystem.radialAcceleration = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get radialAccelerationVariance():Number
		{
			return _particleSystem.radialAccelerationVariance
		}
		public function set radialAccelerationVariance(val:Number):void
		{
			_particleSystem.radialAccelerationVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get randomStartFrames():Boolean
		{
			return false
		}
		public function set randomStartFrames(val:Boolean):void
		{
			
		}
		
		/**
		 * 
		 * @return
		 */
		public function get rotatePerSecond():Number
		{
			return _particleSystem.rotatePerSecond
		}
		public function set rotatePerSecond(val:Number):void
		{
			_particleSystem.rotatePerSecond = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get rotatePerSecondVariance():Number
		{
			return _particleSystem.rotatePerSecondVariance
		}
		public function set rotatePerSecondVariance(val:Number):void
		{
			_particleSystem.rotatePerSecondVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get spawnTime():Number
		{
			return 0
		}
		public function set spawnTime(val:Number):void
		{
			
		}
	
		/**
		 * 
		 * @return
		 */
		public function get speed():Number
		{
			return 	_particleSystem.speed
		}
		public function set speed(val:Number):void
		{
				_particleSystem.speed = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get speedVariance():Number
		{
			return _particleSystem.speedVariance
		}
		public function set speedVariance(val:Number):void
		{
			_particleSystem.speedVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get startRotation():Number
		{
			return _particleSystem.startRotation
		}
		public function set startRotation(val:Number):void
		{
			_particleSystem.startRotation = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get startRotationVariance():Number
		{
			return _particleSystem.startRotationVariance
		}
		public function set startRotationVariance(val:Number):void
		{
			_particleSystem.startRotationVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get startSize():Number
		{
			return _particleSystem.startSize
		}
		public function set startSize(val:Number):void
		{
			_particleSystem.startSize = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get startSizeVariance():Number
		{
			return _particleSystem.startSizeVariance
		}
		public function set startSizeVariance(val:Number):void
		{
			_particleSystem.startSizeVariance = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get tangentialAcceleration():Number
		{
			return _particleSystem.tangentialAcceleration
		}
		public function set tangentialAcceleration(val:Number):void
		{
			_particleSystem.tangentialAcceleration = val;
		}
		
		/**
		 * 
		 * @return
		 */
		public function get tangentialAccelerationVariance():Number
		{
			return _particleSystem.tangentialAccelerationVariance
		}
		public function set tangentialAccelerationVariance(val:Number):void
		{
			_particleSystem.tangentialAccelerationVariance = val;
		}
		
			/**
		 * 
		 */
		public function get startColor():Object
		{
			return _particleSystem.startColor;
		}
		public function set startColor(val:Object):void
		{
			_particleSystem.startColor = val as  ColorArgb;
		}
		
			/**
		 * 
		 */
		public function get endColor():Object
		{
			return _particleSystem.endColor;
		}
		public function set endColor(val:Object):void
		{
			_particleSystem.endColor = val as  ColorArgb;
		}
		
	}

}