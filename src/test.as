package  
{
	import adobe.utils.CustomActions;
	import away3d.controllers.SpringController;
	import bridge.abstract.AbstractPool;
	import bridge.abstract.events.BridgeEvents;
	import bridge.abstract.events.IAbstractEvent;
	import bridge.abstract.events.IAbstractEventDispatcher;
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	import bridge.abstract.IAbstractAnimatable;
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractJuggler;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractState;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.IAbstractTexture;
	import bridge.abstract.IAbstractVideo;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.LabelProperties;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.datastructures.PoolObject;
	import citrus.objects.NapePhysicsObject;
	import com.greensock.TweenLite;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.AsyncErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import nape.space.Space;
	import org.osflash.signals.Signal;
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.extensions.particles.ParticleSystem;
	import starling.extensions.particles.PDParticleSystem;
	import starling.filters.BlurFilter;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	import starlingEngine.elements.EngineLabel;
	import starlingEngine.elements.EngineLayer;
	import starlingEngine.elements.EngineLayerVO;
	import starlingEngine.elements.EngineMask;
	import starlingEngine.elements.EngineTexture;
	import starlingEngine.elements.EngineVideo;
	import starlingEngine.events.EngineEvent;
	import starlingEngine.extensions.krecha.ScrollImage;
	import starlingEngine.extensions.krecha.ScrollTile;
	import starlingEngine.extensions.pixelmask.PixelMaskDisplayObject;
	import starlingEngine.StarlingEngine;
	import starlingEngine.transitions.EngineLayerTransitionIn;
	import starlingEngine.transitions.EngineLayerTransitionOut;
	import starlingEngine.transitions.EngineStateTransition;
	import starlingEngine.ui.EngineButton;
	import starlingEngine.video.display.Video;
	import starlingEngine.video.events.VideoEvent;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class test extends Sprite
	{	
		[Embed(source="../bin/assets/media/drugs.pex", mimeType="application/octet-stream")]
        private static const DrugsConfig:Class;
        
        [Embed(source="../bin/assets/media/fire.pex", mimeType="application/octet-stream")]
        private static const FireConfig:Class;
        
        [Embed(source="../bin/assets/media/sun.pex", mimeType="application/octet-stream")]
        private static const SunConfig:Class;
        
        [Embed(source="../bin/assets/media/jellyfish.pex", mimeType="application/octet-stream")]
        private static const JellyfishConfig:Class;
		
		[Embed(source = "../bin/assets/media/blue.pex", mimeType = "application/octet-stream")]
		private static const BlueClass:Class;
        
        // particle textures
        
        [Embed(source = "../bin/assets/media/drugs_particle.png")]
        private static const DrugsParticle:Class;
        
        [Embed(source = "../bin/assets/media/fire_particle.png")]
        private static const FireParticle:Class;
        
        [Embed(source = "../bin/assets/media/sun_particle.png")]
        private static const SunParticle:Class;
        
        [Embed(source = "../bin/assets/media/jellyfish_particle.png")]
        private static const JellyfishParticle:Class;
		
		[Embed(source = "../bin/assets/media/blue.png")]
		private static const BlueParticle:Class;
        
        // member variables
        
        private var mParticleSystems:Vector.<ParticleSystem>;
        private var mParticleSystem:ParticleSystem;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[Embed(source = "../bin/assets/bitmapfonts/Lcd.fnt", mimeType = "application/octet-stream")]
		private static const defaultFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Lcd_0.png")]
		private static const defaultFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Zrnic.fnt", mimeType = "application/octet-stream")]
		private static const ZrnicFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Zrnic_0.png")]
		private static const ZrnicFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ZrnicBig.fnt", mimeType = "application/octet-stream")]
		private static const ZrnicBigFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ZrnicBig_0.png")]
		private static const ZrnicBigFontPng : Class;
		
		private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
																		new Point(800, 600),
																		StarlingEngine,
																		starling.utils.AssetManager,
																		signals.SignalsHub,
																		AbstractPool,
																		starling.animation.Juggler,
																		nape.space.Space,
																		true
																		);
		
		public function test() 
		{	
			addChild(_bridgeGraphics.engine as DisplayObject);
			 (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
		}
		
		private function loadAssets(event:String, obj:Object):void
		{
			(_bridgeGraphics.assetsManager).enqueue("../bin/assets/spritesheets/spriteSheetBackgrounds.png", 
													"../bin/assets/spritesheets/spriteSheetBackgrounds.xml",
													"../bin/assets/spritesheets/spriteSheetElements.png",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													"../bin/assets/spritesheets/spriteSheetPayTable.xml",
													"../bin/assets/spritesheets/preloader1x.png",
													"../bin/assets/spritesheets/preloader1x.xml",
													"../bin/assets/layouts/layerLayout.xml",
													"../bin/assets/layouts/preloader1xLayout.xml",
													"../bin/assets/layouts/buttonLayout.xml",
													"../bin/assets/layouts/UserInterface.xml"
													);
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
				{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1)
					{	
						buildUI();
					}
				});
		}
		
		private function buildUI():void
		{
			var uiHolder:IAbstractSprite = _bridgeGraphics.requestSprite();
			_bridgeGraphics.addChild(uiHolder);
			
			var button:IAbstractButton = _bridgeGraphics.requestButton("startBtn");
			button.downSkin_ = _bridgeGraphics.requestImage("Spin-Button-Down");
			button.upSkin_ = _bridgeGraphics.requestImage("Spin-Button");
			button.hoverSkin_ = _bridgeGraphics.requestImage("Spin-Button-Hover");
			button.disabledSkin_ = _bridgeGraphics.requestImage("Spin-Button-Hover");
			
			button.x = 50;
			button.y = 50;
			
			button.addEventListener(BridgeEvents.TRIGGERED, button_triggeredHandler);
			
			uiHolder.addNewChild(button as IAbstractDisplayObject);
			
			TweenLite.to(uiHolder.getChildByNameStr("startBtn"), 2, { x:400 } );
			
			var t:IAbstractTextField = _bridgeGraphics.requestTextField(150, 30, "Yaaaay", "Times", 30);
			t.autoScale = true;
			t.hAlign = LabelProperties.ALIGN_CENTER;
			
			var label:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(t,"tt");
			
			button.addCustomLabel(label, LabelProperties.ALIGN_CENTER, new Point(100,100));
			button.updateCustomLabel("Ha\nha");
		}
		
		private function button_triggeredHandler(e:Object):void
		{
			(BridgeEvents.extractCurrentTarget(e) as IAbstractButton).isEnabled  = false;
			(BridgeEvents.extractCurrentTarget(e) as IAbstractButton).visible  = false;
			//showThings();
			//particlesTest();
			//showMaskedThings2();
			//testPreloader();
			//testShape();
			//testScrollingImage();
			//testLayouts();
			//showMainMenu();
			//showMainMenuContained();
			//testEngineFonts();
			//testConsole();
			testPhysics();
		}
		
		private function testPhysics():void
		{
			_bridgeGraphics.tranzitionToState(new PhysicsState());
		}
		
		private function testConsole():void
		{
			
		}
		
		private function testEngineFonts():void
		{
			var fName:String = _bridgeGraphics.registerBitmapFont(defaultFontPng, XML(new defaultFontClass()));
			
			var tt:TextField = new TextField(200, 200, "TEST", fName, 50, 0xffffff);
			var tt2:TextField = new TextField(200, 300, "TEST 2", fName, 50, 0xffffff);
			var tt3:TextField = new TextField(200, 400, "TEST 3", fName, 50, 0xffffff);
			_bridgeGraphics.addChild(tt);
			_bridgeGraphics.addChild(tt2);
			_bridgeGraphics.addChild(tt3);
			
			tt.fontName = "Zrnic";
		}
		
		private var _layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
		
		private function showMainMenu():void
		{
			 _bridgeGraphics.registerBitmapFont(defaultFontPng, XML(new defaultFontClass()));
			 _bridgeGraphics.registerBitmapFont(ZrnicFontPng, XML(new ZrnicFontClass()));
			 _bridgeGraphics.registerBitmapFont(ZrnicBigFontPng, XML(new ZrnicBigFontClass()));
			
			var mainUIxml:XML = new XML();
			mainUIxml = _bridgeGraphics.getXMLFromAssetsManager("UserInterface");
			
			
			_layersVO.addLayer("UI", 0, mainUIxml, true);
			_bridgeGraphics.initLayers(_layersVO.layers);
			
			var layer:IAbstractLayer = _layersVO.retrieveLayer("UI");
			var element:IAbstractDisplayObject = layer.getElement("spin_btn");
			var label:IAbstractLabel = ((element as IAbstractButton).customLabel);
			
			var shadow:IAbstractDropShadowFilter = _bridgeGraphics.requestDropShadowFilter();
			shadow.alpha = 2;
			shadow.distance = 0;
			shadow.blur = 10;
			_bridgeGraphics.addDropShadowFilter(label, shadow);
			addEventListener(Event.ENTER_FRAME, updateStuff);
		}
		
		private function showMainMenuContained():void
		{
			
			var someTranzition:IAbstractLayerTransitionOut = _bridgeGraphics.requestLayerTransitionOUT();
			
			var someContainer:starling.display.Sprite = new starling.display.Sprite();
			_bridgeGraphics.addChild(someContainer);
			
			 _bridgeGraphics.registerBitmapFont(defaultFontPng, XML(new defaultFontClass()));
			 _bridgeGraphics.registerBitmapFont(ZrnicFontPng, XML(new ZrnicFontClass()));
			 _bridgeGraphics.registerBitmapFont(ZrnicBigFontPng, XML(new ZrnicBigFontClass()));
			
			var mainUIxml:XML = new XML();
			mainUIxml = _bridgeGraphics.getXMLFromAssetsManager("UserInterface");
			
			
			_layersVO.addLayer("UI", 0, mainUIxml, true);
			
			
			var layer:IAbstractLayer = _layersVO.retrieveLayer("UI");
			
			someContainer.addChild(layer as starling.display.DisplayObject);
			_bridgeGraphics.drawLayerLayout(layer);
			//someContainer.width = 100;
			
			someTranzition.doTransition(layer, null);
			
			var element:IAbstractDisplayObject = layer.getElement("spin_btn");
			var label:IAbstractLabel = ((element as IAbstractButton).customLabel);
			
			var shadow:IAbstractDropShadowFilter = _bridgeGraphics.requestDropShadowFilter();
			shadow.alpha = 2;
			shadow.distance = 0;
			shadow.blur = 10;
			_bridgeGraphics.addDropShadowFilter(label, shadow);
			addEventListener(Event.ENTER_FRAME, updateStuff);
		}
		
		private var _winAmount:Number = 0;
		private var _smallWin:Number = 0;
		
		private function updateStuff(e:flash.events.Event):void
		{
			_winAmount += 100000;
			_smallWin += 1;
				(_layersVO.retrieveLayer("UI").getChildByNameStr("win_text") as IAbstractLabel).updateLabel(String(Number(_winAmount).toFixed(2)));
				
				if (_winAmount > 100000000)
				{
					(_layersVO.retrieveLayer("UI").getChildByNameStr("win_text") as IAbstractLabel).updateLabel(String(Number(_smallWin).toFixed(2)));
				}
		}
		
		private function testLayouts():void
		{
			//var xml:XML = XML(new TimesXml());
			//_bridgeGraphics.registerBitmapFont(TimesTexture, xml);
			//var t:IAbstractTextField = _bridgeGraphics.requestTextField(1000, 1000, "Yaaaay", "Times", 350);
			//t.color = 0xffffff;
			//_bridgeGraphics.addChild(t);
			//
			//var x:XML = new XML();
			//x = _bridgeGraphics.getXMLFromAssetsManager("buttonLayout");
			//
			//var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			//layersVO.addLayer("UI", 0, x, true);
			//_bridgeGraphics.initLayers(layersVO.layers);
			//
			//(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED, buttonPressed);
		}
		
		private var scroll:IAbstractBlitMask;
		
		private function testScrollingImage():void
		{
			var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			layersVO.addLayer("UI", 0, null, true);
			_bridgeGraphics.initLayers(layersVO.layers);
			
			var scrollingImg:IAbstractImage = _bridgeGraphics.requestImage("Numbers");
			 
			scroll = _bridgeGraphics.requestBlitMask(scrollingImg, 800, 600, 300, 300);
			layersVO.retrieveLayer("UI").addNewChild(scroll);
			
			layersVO.retrieveLayer("UI").destroyAll();
			
			addEventListener(flash.events.Event.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:flash.events.Event):void
		{
			scroll.tilesOffsetY --;
			scroll.tilesOffsetX ++;
		}
		
		private function testShape():void
		{
			var s2:flash.display.Shape = new flash.display.Shape();
			s2.graphics.beginFill(0xff0000, 1);
			s2.graphics.drawCircle(40, 40, 40);
			s2.graphics.endFill();

			var bmpData:BitmapData = new BitmapData(100,100, true, 0x000000);
			bmpData.draw(s2);
			
			_bridgeGraphics.addChild(_bridgeGraphics.requestImageFromBitmapData(bmpData));
		}
		
		private function testPreloader():void
		{
			var x:XML = new XML();
			x = _bridgeGraphics.getXMLFromAssetsManager("preloader1xLayout");
			
			var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			layersVO.addLayer("UI", 0, x, true);
			_bridgeGraphics.initLayers(layersVO.layers);
			
			var m:IAbstractMask = _bridgeGraphics.requestMask(
																									layersVO.retrieveLayer("UI").getChildByNameStr("Preloader-Background"), 
																									_bridgeGraphics.requestImage("Loader-Over")
																									);
			layersVO.retrieveLayer("UI").addNewChild(m);
		}
		
		private function showMaskedThings2():void
		{
			var video:IAbstractVideo = _bridgeGraphics.requestVideo();
			video.addVideoPath("../bin/assets/test.flv");
			_bridgeGraphics.addChild(video);
			
			var sprite:IAbstractSprite = _bridgeGraphics.requestSprite();
			_bridgeGraphics.addChild(sprite)
						
			var img:IAbstractImage = _bridgeGraphics.requestImage("Auto-Spin-Button-Down");
			sprite.addNewChild(img);
	
			_bridgeGraphics.addChild(sprite);
			
			var m:IAbstractMask = _bridgeGraphics.requestMask(video, img);
			sprite.addNewChild(m);
			
			m.y = 250;
		}
		
		private function showThings():void
		{			
			var sprite:IAbstractSprite = _bridgeGraphics.requestSprite();
			_bridgeGraphics.addChild(sprite)
						
			var img:IAbstractImage = _bridgeGraphics.requestImage("Background");
			sprite.addNewChild(img);
			img.x = 150
			
						//
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Bet", 30);
			mc.x = 0;
			mc.y = 0;
						
			sprite.x = 150;
			sprite.y = 150;
			sprite.rotation = .1;
			(_bridgeGraphics.defaultJuggler).add(mc as IAbstractAnimatable);
						//
			var x:XML = new XML();
			x = _bridgeGraphics.getXMLFromAssetsManager("layerLayout");
			
			var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			layersVO.addLayer("UI", 0, null, true);
			layersVO.addLayer("Overground", 1, null, true);
			layersVO.addLayer("Layer 3", 2,x, true);
						
			//layersVO.retrieveLayer("Layer 3").addNewChild(mc);
			
			//var video:IAbstractVideo = _bridgeGraphics.requestVideo();
			//video.addVideoPath("../bin/assets/test.flv");
			//layersVO.retrieveLayer("Overground").addNewChild(video);
						//
			_bridgeGraphics.initLayers(layersVO.layers);
			
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED, buttonPressed);
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.MOVIE_CLIP_ENDED, movieclipEnded);
			
			//layersVO.addLayer("TEST", 4, null);
			
			//var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			//var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			//
			//var outTransition:IAbstractLayerTransitionOut = _bridgeGraphics.requestLayerTransitionOUT()
			//var inTransition:IAbstractLayerTransitionIn = _bridgeGraphics.requestLayerTransitionIN();
			
			//inLayers.push(layersVO.retrieveLayer("TEST"));
			//outLayers.push(layersVO.retrieveLayer("Layer 3"));
			//
			//_bridgeGraphics.updateLayers(inLayers, outLayers, inTransition, outTransition);
						
			//var transIn:IAbstractLayerTransitionIn = _bridgeGraphics.requestLayerTransitionIN()
			//var transOut:IAbstractLayerTransitionOut = _bridgeGraphics.requestLayerTransitionOUT();
						
			//var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			//outLayers.push(layersVO.retrieveLayer("Layer 2"));
						
			//var newLayer:IAbstractLayer = _bridgeGraphics.requestLayer("Tzeapa", 0, x, true);
			//inLayers.push(newLayer);
			//_bridgeGraphics.updateLayers(inLayers, null, null, null);
			//newLayer.addNewChild(_bridgeGraphics.requestImage("Background"));
				
			//TweenLite.to(newLayer.getChildByNameStr("badass"), 2, { x:400 } );
						
			//var state2:IAbstractState = _bridgeGraphics.requestState();
			//var stateTransition:IAbstractStateTransition = new EngineStateTransition();
			//_bridgeGraphics.tranzitionToState(state2, stateTransition);
			
 
			//var xml:XML = XML(new TimesXml());
			//_bridgeGraphics.registerBitmapFont(TimesTexture, xml);
			//var t:IAbstractTextField = _bridgeGraphics.requestTextField(500, 500, "Yaaaay", "Times", 150);
			//_bridgeGraphics.addChild(t);
			
			///////////////////////////////////////////////////
		}
		
		private function particlesTest():void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, CheckDirection);
			
			var drugsConfig:XML = XML(new DrugsConfig());
            var drugsTexture:Texture = Texture.fromBitmap(new DrugsParticle());
            
            var fireConfig:XML = XML(new FireConfig());
            var fireTexture:Texture = Texture.fromBitmap(new FireParticle());
            
            var sunConfig:XML = XML(new SunConfig());
            var sunTexture:Texture = Texture.fromBitmap(new SunParticle());
            
            var jellyConfig:XML = XML(new JellyfishConfig());
            var jellyTexture:Texture = Texture.fromBitmap(new JellyfishParticle());
			
			var blueConfig:XML = XML (new BlueClass());
			var blueTexture:Texture = Texture.fromBitmap(new BlueParticle());
            
            mParticleSystems = new <ParticleSystem>[
                //new PDParticleSystem(drugsConfig, drugsTexture),
                //new PDParticleSystem(fireConfig, fireTexture),
                //new PDParticleSystem(sunConfig, sunTexture),
                //new PDParticleSystem(jellyConfig, jellyTexture),
				new PDParticleSystem(blueConfig, drugsTexture)]
				
				startNextParticleSystem();
		}
		
		private function CheckDirection(e:MouseEvent):void
		{
			if (mParticleSystem)
			{
				mParticleSystem.emitterX = stage.mouseX;
				mParticleSystem.emitterY = stage.mouseY;
			}
		}
		
		 private function startNextParticleSystem():void
        {
            if (mParticleSystem)
            {
                mParticleSystem.stop();
                mParticleSystem.removeFromParent();
               (_bridgeGraphics.defaultJuggler).remove(mParticleSystem);
            }
            
            mParticleSystem = mParticleSystems.shift();
            mParticleSystems.push(mParticleSystem);

            mParticleSystem.emitterX = 320;
            mParticleSystem.emitterY = 240;
            mParticleSystem.start();
            
            _bridgeGraphics.addChild(mParticleSystem);
            (_bridgeGraphics.defaultJuggler).add(mParticleSystem);
        }
		
		private function buttonPressed(type:String, event:Object):void
		{
			trace("Caught " + type + " " + event)
			trace("Target "+event.currentTarget);
			(event.currentTarget as IAbstractButton).isEnabled = false;
		}
		
		private function movieclipEnded(type:String, event:Object):void
		{
			trace("!!!!!!!!!!!!!!!!!!!Caught "+type+" "+event)
		}
		
		private function cleanUp():void
		{
			_bridgeGraphics.cleanUp();
			_bridgeGraphics = null;
			System.gc();
		}
		
	}

}