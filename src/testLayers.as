package  
{
	import away3d.controllers.SpringController;
	import away3d.events.AssetEvent;
	import bridge.abstract.AbstractPool;
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.events.IAbstractSignalEvent;
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.filters.IAbstractGlowFilter;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractGraphics;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.IAbstractVideo;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractComboBox;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import bridge.abstract.ui.IAbstractInputText;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import citrus.ui.starling.UI;
	import cmodule.AwayPhysics.TextFieldI;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import consoleCommand.Output;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.Slider;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.controls.TextInput;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;
	import feathers.text.StageTextField;
	import flappybird.Assets;
	import flare.basic.Scene3D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.NetStatusEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setInterval;
	import nape.space.Space;
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObjectContainer;
	import starling.display.FFParticleSystem;
	import starling.display.FFParticleSystem.SystemOptions;
	import starling.display.Graphics;
	import starling.display.graphics.Stroke;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Stage;
	import starling.extensions.particles.PDParticle;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.TextureSmoothing;
	import starlingEngine.events.EngineDelayedDisposeSignalEvent;
	import starlingEngine.extensions.DistanceFieldFont;
	import starlingEngine.extensions.DistanceFieldQuadBatch;
	import starlingEngine.filters.GodRaysFilter;
	import starlingEngine.filters.PixelateFilter;
	import starling.textures.GradientTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLabel;
	import starlingEngine.events.EngineEvent;
	import starlingEngine.events.GESignalEvent;
	import starlingEngine.StarlingEngine;
	import starlingEngine.ui.EngineComboBox;
	import starlingEngine.ui.EngineList;
	import starlingEngine.ui.EngineComboBoxItemRenderer;
	import starlingEngine.ui.EngineInputText;
	import starlingEngine.ui.EngineSlider;
	import starlingEngine.ui.EngineToggleButton;
	import starlingEngine.video.display.Video;
	import utils.delayedFunctionCall;
	/**
	 * ...
	 * @author Eu
	 */
	public class testLayers extends Sprite
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
		
		[Embed(source = "../bin/assets/test.flv", mimeType = "application/octet-stream")]
		private static const flv : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Lcd.fnt", mimeType = "application/octet-stream")]
		private static const defaultFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Lcd_0.png")]
		private static const defaultFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Dimbo.fnt", mimeType = "application/octet-stream")]
		private static const dimboFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Dimbo.png")]
		private static const dimboFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Zrnic.fnt", mimeType = "application/octet-stream")]
		private static const ZrnicFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Zrnic_0.png")]
		private static const ZrnicFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ZrnicBig.fnt", mimeType = "application/octet-stream")]
		private static const ZrnicBigFontClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ZrnicBig_0.png")]
		private static const ZrnicBigFontPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Omnes.fnt", mimeType = "application/octet-stream")]
		private static const OmnesClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Omnes_0.png")]
		private static const OmnesPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ScrollsOfRaCreditRiverMedium.fnt", mimeType = "application/octet-stream")]
		private static const CreditRiverXML : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/ScrollsOfRaCreditRiverMedium.png")]
		private static const CreditRiverPNG : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Arial.fnt", mimeType = "application/octet-stream")]
		private static const ArialClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Arial_0.png")]
		private static const ArialPng : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/desyrel.fnt", mimeType = "application/octet-stream")]
		private static const DesyrelClass : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/desyrel.png")]
		private static const DesyrelPng : Class;
		
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
		
		[Embed(source = "../bin/assets/sdfFonts/Poplar.png")]
		private static const PoplarPNG:Class;
		
		[Embed(source = "../bin/assets/sdfFonts/Poplar.xml", mimeType = "application/octet-stream")]
		private static const PoplarXML:Class;
		
		[Embed(source = "../bin/assets/particles/start.pex", mimeType = "application/octet-stream")]
			private static const ParticleTestPex:Class;
		
		[Embed(source = "../bin/assets/particles/texture.png")]
			private static const ParticleTestPNG:Class;
		
		private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
																		new Point(1920, 1080),
																		StarlingEngine,
																		starling.utils.AssetManager,
																		signals.SignalsHub,
																		AbstractPool,
																		starling.animation.Juggler,
																		nape.space.Space,
																		true
																		);
																		
		private var _layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
		private var _transIn:IAbstractLayerTransitionIn = _bridgeGraphics.requestLayerTransitionIN();
		private var _transOut:IAbstractLayerTransitionOut = _bridgeGraphics.requestLayerTransitionOUT();
		
		public function testLayers() 
		{
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void
			//{
				//testFLV();
			//})
			_bridgeGraphics.engine.is3D = false;
			addChild(_bridgeGraphics.engine as DisplayObject);
			 (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
		}

		private function testConsole():void
		{
			trace("asdasdasdasdasd");
		}
		
		private function loadAssets(event:String, obj:Object):void
		{
			_bridgeGraphics.consoleCommands.registerCommand("test", testConsole);
			
			(_bridgeGraphics.assetsManager as AssetManager).enqueue(
													"../bin/assets/spritesheets/spriteSheetBackgrounds.png", 
													"../bin/assets/spritesheets/spriteSheetBackgrounds.xml",
													"../bin/assets/spritesheets/spriteSheetElements.png",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													 "../bin/assets/sdfFonts/Poplar.otf_sdf.xml",
													 "../bin/assets/layouts/bonusLayout.xml",
													 "../bin/assets/spritesheets/Scrolls of Ra Feature Assets.png",
													"../bin/assets/spritesheets/winningsAnimations11-12.png",
													 "../bin/assets/spritesheets/winningsAnimations13-14.png",
													"../bin/assets/spritesheets/winningsAnimations1-5.png",
													 "../bin/assets/spritesheets/winningsAnimations6-10.png",
													"../bin/assets/spritesheets/winningsAnimationsAssets11-12.xml",
													"../bin/assets/spritesheets/winningsAnimationsAssets13-14.xml",
													"../bin/assets/spritesheets/winningsAnimationsAssets1-5.xml",
													"../bin/assets/spritesheets/winningsAnimationsAssets6-10.xml",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													"../bin/assets/spritesheets/spriteSheetPayTable.xml",
													"../bin/assets/spritesheets/preloader1x.png",
													"../bin/assets/spritesheets/Scrolls of Ra Assets.png",
													"../bin/assets/spritesheets/preloader1x.xml",
													"../bin/assets/spritesheets/backgroundAssets.xml",
													"../bin/assets/layouts/layerLayout.xml",
													"../bin/assets/layouts/preloader1xLayout.xml",
													"../bin/assets/layouts/buttonLayout.xml",
													"../bin/assets/layouts/UserInterface.xml",
													"../bin/assets/layouts/Paytable.xml",
													"../bin/assets/layouts/PaytablePage1.xml",
													"../bin/assets/layouts/PaytablePage2.xml",
													"../bin/assets/layouts/PaytablePage3.xml",
													"../bin/assets/layouts/PaytablePage4.xml",
													"../bin/assets/layouts/PaytablePage5.xml",
													"../bin/assets/layouts/PaytablePage6.xml",
													"../bin/assets/layouts/linesLayout.xml",
													"../bin/assets/sounds/track.mp3",
													"../bin/assets/layouts/freeSpinsLayout.xml",
													"../bin/assets/layouts/menuLayout.xml",
													"../bin/assets/spritesheets/FeaturesModuleAssets.xml",
													"../bin/assets/spritesheets/FeaturesModuleSkin.png",
													 "../bin/assets/spritesheets/featureAssets.xml",
													 "../bin/assets/layouts/PayTableModulePayTableLayerLayout.xml"
													);
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
				{
					Output.out("Loading assets, progress:"+ ratio);
					if (ratio == 1)
					{	 
						//testErrorThrowing();
						_transIn.injectAnimation(animIn);
						_transOut.injectAnimation(animOut);
						
						//((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
						//((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, transOutComplete);
						//((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.GENERIC_SLIDER_CHANGE, onSlider);
						
						//testEmptyButton();
						//testNullMovie();
						//testPool();
						//testList();
						//container = _bridgeGraphics.requestSprite("asd");
						//layer = _bridgeGraphics.requestLayer("bonus", 1, _bridgeGraphics.getXMLFromAssetsManager("bonusLayout") , true);
						//_bridgeGraphics.addChild(container);
						//(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, bonusOver);
						//testBonus();
						//layer.redrawEnabled = false;
						
						//testTexts();
						//testDistanceFonts();
						//testParticles();
						//testParticlesFromBridge();
						//testParticlesFromBridge2();
						//testFiters();
						//testLayersTranzitions();
						//testGradientMask();
						//testMask();
						//testDifferentSize();
						//testMovieClipsFromFrames();
						//showLines();
						showMenu();
						//(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, function(type:String, e:Object):void {
							//trace("@@@@@@@@@@@@@@@@@@@ LAYER_TRANSITION_IN_COMPLETE " + type);
						//});
						//
						//(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, function(type:String, e:Object):void {
							//trace("@@@@@@@@@@@@@@@@@@@ LAYER_TRANSITION_OUT_COMPLETE " + type);
							//showPaytable();
						//});
						//showPaytable();
						//makeSlider();
						//testMovieClips();
						//testImages();
						//testSounds();
						//testMovieClipsFromFrames();
						//testToggle();
						//testFreeSpins();
						//testInputText();
						//testGradientFill();
						//testNativeOverlay();
						//testComboBox("cb1", 150, 150);
						//testComboBox("cb2", 350,150);
						//testEmptyButton();
						//testTexturedLine();
						//testAnimatedTexture();
						//for (var i:uint = 0; i < 5; i++ )
						//{
							//testFLVs();
						//}
						//testOmnes();
						//testAnimatedButtons();
						//testDoubleSize();
						//testTexts();
						//testTextsVector();
						//testNativeTexts();
						//_bridgeGraphics.storeObject("", "")
						//_bridgeGraphics.retrieveObject();
					}
				});
		}
		
		private var _mask:IAbstractMask;
		private var _imgToMask:IAbstractImage;
		private var _imgMask:IAbstractImage;
		private var _counterMasks:int = 0;
		
		private function testMask():void 
		{
			_imgToMask = _bridgeGraphics.requestImage("BadGuy-Walking-01");
			_imgMask = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(150, 150, false, 0xFFFFFF));
			
			addMask();
			
			addEventListener(Event.ENTER_FRAME, testMasksDispose);
		}
		
		private function addMask():void
		{
			//_bridgeGraphics.signalsManager.dispatchSignal(Signals.REMOVE_AND_DISPOSE,Signals.REMOVE_AND_DISPOSE, new EngineDelayedDisposeSignalEvent(_imgMask, _mask, true));
			_bridgeGraphics.returnToPool(_imgMask);
			_mask = _bridgeGraphics.requestMask(_imgToMask, _imgMask);
			_bridgeGraphics.addChild(_mask);
			_counterMasks++
			//trace(_counterMasks);
		}
		
		private function testMasksDispose(e:Event):void
		{
			_bridgeGraphics.returnToPool(_mask);
			addMask();
		}
		
		private function testDoubleSize():void
		{
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("ExplodingWild", 10, true);
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			mc.addNewFrame(_bridgeGraphics.requestImage("BadGuy-Walking-01"));
			_bridgeGraphics.addChild(mc);
			mc.play();
		}
		
		private function testAnimatedButtons():void
		{
			var mcUp:IAbstractMovie = _bridgeGraphics.requestMovie("Chest");
			var mcHover:IAbstractMovie = _bridgeGraphics.requestMovie("Symbol11Animation");
			var mcDown:IAbstractMovie = _bridgeGraphics.requestMovie("Symbol13Animation");
			var btn:IAbstractButton = _bridgeGraphics.requestButton("asd");
			
			btn.upSkin_ = mcUp;
			btn.hoverSkin_ = mcHover;
			btn.downSkin_ = mcDown;
			
			//mcUp.play();
			//mcHover.play();
			//mcDown.p     lay();
			
			_bridgeGraphics.addChild(btn);
			
			btn.touchable = false;
		}
		
		private function testErrorThrowing():void
		{
			((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
			((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
		}
		
		private function testNullMovie():void
		{
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("symbol");
			trace(mc);
		}
		
		private function testList():void
		{
			_bridgeGraphics.registerBitmapFont(new dimboFontPng(), XML(new dimboFontClass()));
			
			var data:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>();
			data.push(new EngineComboBoxItemRenderer("test1"));
			data.push(new EngineComboBoxItemRenderer("test2"));
			data.push(new EngineComboBoxItemRenderer("test3"));
			data.push(new EngineComboBoxItemRenderer("test4"));
			var list:IAbstractComboBox = _bridgeGraphics.requestComboBox(data, 150, 300, null, "Dimbo");
			
			list.x = 100;
			list.y = 100;
			_bridgeGraphics.addChild(list);
		}
		
		private var container:IAbstractSprite;
		private var layer:IAbstractLayer;
		
		private var intervalId:uint;
		private var imgCount:int = 0;
		private var label:IAbstractLabel;
		
		private function testPool():void
		{
			var tField:IAbstractTextField = _bridgeGraphics.requestTextField(100, 30, "", "Verdana", 30, 0xFFFFFF);
			label = _bridgeGraphics.requestLabelFromTextfield(tField);
			label.y = 30;
			_bridgeGraphics.addChild(label);
			
			intervalId = setInterval(createChildren, 1);
		}
		
		private function createChildren():void
		{
				var ranSymbol:int = 1 + Math.random() * 13;
				var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Symbol"+String(ranSymbol)+"Animation");
				mc.x = Math.random() * 800;
				mc.y = Math.random() * 600;
				mc.play();
				_bridgeGraphics.currentContainer.addNewChild(mc);
				_bridgeGraphics.returnToPool(mc);
				imgCount++;
				label.updateLabel(String(imgCount));
		}
		
		private function testBonus():void
		{
			var layersIn:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			layersIn.push(layer);
			
			_bridgeGraphics.updateLayers(container, layersIn);
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED,chestPressed);
		}
		
		private function bonusOver(type:String, obj:Object):void
		{ 
				testBonus();
		} 
		
		private  function chestPressed(type:String, obj:Object):void
		{
			trace(type);
			if (type == "chestButtonImage25")
			{
				var layersOut:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
				layersOut.push(layer);
				_bridgeGraphics.updateLayers(container, null, layersOut);
			}
			else
			{
				layer.removeChildAndDispose(layer.getChildByNameStr(type), true);
			}
		}
		
		private function testDistanceFonts():void
		{
			var	texture:Texture = Texture.fromBitmap(new PoplarPNG());
			var	xml:XML = XML(new PoplarXML());
			 
			//var	batch:QuadBatch = new QuadBatch ();
			//var	font:BitmapFont = new BitmapFont (texture, xml);
			 
			var	batch:DistanceFieldQuadBatch = new DistanceFieldQuadBatch ();
			var	font:DistanceFieldFont = new DistanceFieldFont (texture, xml);
			 
			font.fillQuadBatch (batch, 512, 512, "Hello This is a test", 50, 0xff0000, "center", "center", false, false);
			 
			_bridgeGraphics.addChild(batch);
		}
		
		private function testNativeTexts():void
		{
			var tFormat:TextFormat = new TextFormat("Credit River", 50, 0xFFFFFF);
			var tF1:TextField = new TextField();
			tF1.text = "OVERVIEW";
			tF1.setTextFormat(tFormat);
			tF1.y = 30;
			tF1.x = 500;
			
			_bridgeGraphics.nativeDisplay.addChild(tF1);
		}
		
		private function testTexts():void
		{
			_bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			
			var tF1:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 10, 0xFFFFFF);
			var tF2:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 15, 0xFFFFFF);
			var tF3:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 20, 0xFFFFFF);
			var tF4:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 30, 0xFFFFFF);
			var tF5:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 40, 0xFFFFFF);
			var tF6:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Omnes-Regular", 50, 0xFFFFFF);
			
			var label1:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF1);
			var label2:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF2);
			var label3:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF3);
			var label4:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF4);
			var label5:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF5);
			var label6:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF6);
			
			label1.x = label2.x = label3.x = label4.x = label5.x = label6.x = 100;
			label1.y = 20;
			label2.y = 50;
			label3.y = 80;
			label4.y = 110;
			label5.y = 140;
			label6.y = 180;
			
			_bridgeGraphics.addChild(label1);
			_bridgeGraphics.addChild(label2);
			_bridgeGraphics.addChild(label3);
			_bridgeGraphics.addChild(label4);
			_bridgeGraphics.addChild(label5);
			_bridgeGraphics.addChild(label6);
			
		}
		
		private function testTextsVector():void
		{
			_bridgeGraphics.registerBitmapFont(new CreditRiverPNG(), XML(new CreditRiverXML()));
			
			var factor:Number = 1.3;
			
			var tF1:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 10*factor, 0xFFFFFF);
			var tF2:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 15*factor, 0xFFFFFF);
			var tF3:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 20*factor, 0xFFFFFF);
			var tF4:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 30*factor, 0xFFFFFF);
			var tF5:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 40*factor, 0xFFFFFF);
			var tF6:IAbstractTextField = _bridgeGraphics.requestTextField(200, 100, "GEORGE", "Credit River", 50*factor, 0xFFFFFF);
			
			var label1:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF1);
			var label2:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF2);
			var label3:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF3);
			var label4:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF4);
			var label5:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF5);
			var label6:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tF6);
			
			label1.x = label2.x = label3.x = label4.x = label5.x = label6.x = 100;
			label1.y = 20;
			label2.y = 53;
			label3.y = 85;
			label4.y = 115;
			label5.y = 148;
			label6.y = 188;
			
			_bridgeGraphics.addChild(label1);
			_bridgeGraphics.addChild(label2);
			_bridgeGraphics.addChild(label3);
			_bridgeGraphics.addChild(label4);
			_bridgeGraphics.addChild(label5);
			_bridgeGraphics.addChild(label6);
			
		}
		
		private function tryLabel(newX:uint, newY:uint, newSize:uint):void
		{
			//var labelFeathers1:Label = new Label();
			//labelFeathers1.text = "GEORGE";
			//labelFeathers1.x = newX;
			//labelFeathers1.y = newY;
			//labelFeathers1.textRendererFactory = function():ITextRenderer
			//{
				//var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
				//textRenderer.textFormat = new BitmapFontTextFormat("Arial", newSize);
				//return textRenderer;
			//}
			//_bridgeGraphics.addChild(labelFeathers1);
			
			var tField:IAbstractTextField = _bridgeGraphics.requestTextField(200, 30, "ASDasd123", "Verdana", 40, 0, false, [new GlowFilter()]);
			var label:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tField);
			
			label.x = 200;
			label.y = 200;
			
			_bridgeGraphics.addChild(label);
		}
		
		private	var advancedParticles:IAbstractParticleSystem
		private	var advancedParticles2:IAbstractParticleSystem
		
		private function testParticlesFromBridge():void
		{
			var atlas:XML = _bridgeGraphics.getXMLFromAssetsManager("spriteSheetElements");
			var particleTexture:Texture = _bridgeGraphics.requestImage("symbol_0").currentTexture as Texture;
			
			advancedParticles = _bridgeGraphics.requestAdvancedParticleSystem(XML(new ParticleTestPex()), _bridgeGraphics.requestImage("symbol_0"), atlas);
			_bridgeGraphics.addChild(advancedParticles);
			advancedParticles.start();
			
			TweenLite.to(advancedParticles, 1, { x:300, onComplete:particlesCompleted } )
		}
		
		private function testParticlesFromBridge2():void
		{
			var atlas:XML = _bridgeGraphics.getXMLFromAssetsManager("spriteSheetElements");
			var particleTexture:Texture = _bridgeGraphics.requestImage("symbol_0").currentTexture as Texture;
			
			advancedParticles2 = _bridgeGraphics.requestAdvancedParticleSystem(XML(new ParticleTestPex()), _bridgeGraphics.requestImage("symbol_0"), atlas);
			_bridgeGraphics.addChild(advancedParticles2);
			advancedParticles2.start();
			
			TweenLite.to(advancedParticles2, 1.5, { y:50, onComplete:particlesCompleted2 } )
			
		}
		
		private function particlesCompleted():void
		{
			advancedParticles.stop();
		}
		
			private function particlesCompleted2():void
		{
			advancedParticles2.stop();
		}
		
		private function onParticlesCompleted(type:String, obj:Object):void
		{
			trace("Particles Compelted")
		}
		
		private var btn:IAbstractButton;
		private var glowFilter:IAbstractGlowFilter
		private var added:Boolean = false;
		private var imgToPixelate:IAbstractImage
		private var pixelSize:uint = 1;
		private var frameCount:int = 0;
		
		private var imgWithFilters:IAbstractImage;
		
		private function testFiters():void
		{
			 //imgToPixelate = _bridgeGraphics.requestImage("Background");
			//_bridgeGraphics.addChild(imgToPixelate);
			//_bridgeGraphics.addPixelationFilter(imgToPixelate, 100);
			//
			addEventListener(Event.ENTER_FRAME, pixelate);
			glowFilter = _bridgeGraphics.requestGlowFilter();
			imgWithFilters = _bridgeGraphics.requestImage("Rola-Wild-Extins");
			imgWithFilters.x = 200;
			imgWithFilters.y = 200;
			_bridgeGraphics.addChild(imgWithFilters);
			_bridgeGraphics.addGlowFilter(imgWithFilters, glowFilter);
		}
		
		private function pixelate(e:Event):void
		{
			frameCount++
			//pixelSize -= 5;
			//_bridgeGraphics.addPixelationFilter(imgToPixelate, pixelSize);
			if (frameCount % 2 == 0)
			{
				_bridgeGraphics.returnToPool(glowFilter);
			}
			else
			{
				_bridgeGraphics.addGlowFilter(imgWithFilters, glowFilter);
			}
		}
		
		private function onButtonHover(type:String, e:Object):void
		{		
			if (!added)
			{
				trace("over");
				_bridgeGraphics.addGlowFilter(btn, glowFilter);
				added = true;
			}
			_bridgeGraphics.clearFilter(btn);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_OUT, onButtonOut);
			(_bridgeGraphics.signalsManager as ISignalsHub).removeListenerFromSignal(Signals.GENERIC_BUTTON_OVER, onButtonHover)
		}
		
		private function onButtonOut(type:String, e:Object):void
		{
			if (added)
			{
					trace("out");
				_bridgeGraphics.clearFilter(btn);
				added = false;
			}
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_OVER, onButtonHover);
			(_bridgeGraphics.signalsManager as ISignalsHub).removeListenerFromSignal(Signals.GENERIC_BUTTON_OVER, onButtonOut);
		}
		
		private var layer1:IAbstractLayer;
		private var layer2:IAbstractLayer;
		
		private var holder:IAbstractSprite;
		
		private var transitionIn:IAbstractLayerTransitionIn;
		private var transitionOut:IAbstractLayerTransitionOut;
		private function testLayersTranzitions():void
		{
			var spr:IAbstractSprite = _bridgeGraphics.requestSprite("asdasds");
			
			var label:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(_bridgeGraphics.requestTextField(100, 100, "TESTADSD", "Verdana", 30));
			_bridgeGraphics.addChild(label);
			label.x = 100;
			label.y = 100;
			
			label.pivotX = label.width / 2;
			label.pivotY = label.height;
			TweenLite.to(label, 10, { skewX:60} );
			
			//layers properties
			layer1 = _bridgeGraphics.requestLayer("Layer1", 0, null,  true);
			layer1.redrawEnabled = false;
			layer1.x = 0;
			layer2 = _bridgeGraphics.requestLayer("Layer2", 1, null, true);
			layer2.redrawEnabled = false;
			layer2.x = 100;
			
			//transitions
			transitionIn = _bridgeGraphics.requestLayerTransitionIN();
			transitionOut = _bridgeGraphics.requestLayerTransitionOUT();
			
			//layers holder
			holder = _bridgeGraphics.requestSprite("holder");
			_bridgeGraphics.addChild(holder);
			
			//layers vectors
			var layersIn:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			var layersOut:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			
			layersIn.push(layer1);
			layersOut.push(layer2);
			
			layer1.addNewChild(_bridgeGraphics.requestImage("Background"));
			//layer2.addNewChild(_bridgeGraphics.requestImage("Bonus-Background"));
			
			_bridgeGraphics.updateLayers(holder, layersIn, layersOut, transitionIn, transitionOut);
		}
		
		private function testGradientMask():void
		{
			//CREATE MASK
			var rect:Shape = new Shape();
			rect.width = 800;
			rect.height = 800;
			
			var mat:Matrix=new Matrix();
			var colors:Array = [0xFF0000,0x00FF00, 0x0000FF];
			var alphas:Array = [0,1,0];
			var ratios:Array = [0, 127, 255];
			mat.createGradientBox(300,300, 30);
			rect.graphics.lineStyle();
			rect.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,mat);
			rect.graphics.drawRect(0,0,300,300);
			rect.graphics.endFill();
			
			var bmpd:BitmapData = new BitmapData(200, 200, true, 0x000000);
			bmpd.draw(rect);
			
			var img:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(bmpd);
			
			//CREATE MASKED OBJECT
			var maskedObject:IAbstractSprite = _bridgeGraphics.requestSprite(); 
			maskedObject.addNewChild(_bridgeGraphics.requestImage("Logo"));
			
			//CREATE MASK OBJECT
			var mask:IAbstractMask = _bridgeGraphics.requestMask(maskedObject, img);
			mask.x = 250;
			mask.y = 250;
			
			var oldImg:IAbstractImage = _bridgeGraphics.requestImage("Logo");
			_bridgeGraphics.colorizeImage(oldImg, 0xFF0000);
			oldImg.x = 250;
			oldImg.y = 250;
			
			_bridgeGraphics.addChild(oldImg);
			_bridgeGraphics.addChild(mask);
			
			TweenLite.to(img, 20, { rotation:360 } );
		}
		
		private function testDifferentSize():void
		{
			var img1:IAbstractImage = _bridgeGraphics.requestImage("Auto-Spin-Button");
			var img2:IAbstractImage = _bridgeGraphics.requestImage("Auto-Spin-Button-Hover");
			var img3:IAbstractImage = _bridgeGraphics.requestImage("Auto-Spin-Button-Down");
			
			img1.x = img2.x = img3.x =  200;
			img1.y = img2.y = img3.y =  200;
			
			_bridgeGraphics.addChild(img3);
			_bridgeGraphics.addChild(img2);
			_bridgeGraphics.addChild(img1);
		}
		
		private function showMenu():void
		{
			var paytableXml:XML = new XML();
			paytableXml = _bridgeGraphics.getXMLFromAssetsManager("menuLayout");
			
			 //Adding the Paytable layer and initializing the layout via auto methods
			_layersVO.addLayer("Paytable", 0, paytableXml, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var paytableLayer:IAbstractLayer = _layersVO.retrieveLayer("Paytable");
			inLayers.push(paytableLayer);
			
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);
		}
		
		private function testOmnes():void
		{
			_bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			
			var tField:IAbstractTextField = _bridgeGraphics.requestTextField(400, 100, "abcdeghijklmnopqrstuvwxyzTESTtestTEST!@#$%^&*()_+", "Omnes-Regular", 20, 0xFFFFFF);
			var label:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tField);
			
			label.x = 100;
			label.y = 100;
			
			_bridgeGraphics.addChild(label);
		}
		
		private function testFLVs():void
		{
			var dflv1:delayedFunctionCall = new delayedFunctionCall(function():void {
				testFLV("../bin/assets/test.flv");
			}, 200);
			
			var dflv2:delayedFunctionCall = new delayedFunctionCall(function():void {
				testFLV("../bin/assets/test2.flv");
			}, 200);
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.FLV_MOVIE_STARTED, function(type:String, obj:Object):void
			{
				trace(type + " " + obj);
			}
			);
		}
		
		private function testFLV(path:String):void
		{
			var __stream:IAbstractVideo;
			var __holder:IAbstractSprite;
			__holder = _bridgeGraphics.requestSprite("holder");
			__stream = _bridgeGraphics.requestVideo();
			__stream.addVideoPath(path, false);
			__stream.loop = true;
			
			_bridgeGraphics.addChild(__holder);
			__holder.addNewChild(__stream);
			
			__holder.x =150;
		}
		
		private function onConnect(e:NetStatusEvent):void {
			if (e.info.code == 'NetConnection.Connect.Success') {
				trace(e.target as NetConnection);
				var ns:NetStream = new NetStream(e.target as NetConnection);

				ns.client = {};
				var file:ByteArray = new flv();
				ns.play(null);

				ns.appendBytes(file);
				
				var flvHolder:IAbstractVideo = _bridgeGraphics.requestVideo();
				//flv.addVideoPath("../bin/assets/test.flv");
				flvHolder.addVideoStream(ns);
				_bridgeGraphics.addChild(flvHolder);
			}

		}
		
		private function testAnimatedTexture():void
		{
			var spr:IAbstractSprite = _bridgeGraphics.requestSprite("adasd");
			var gr:IAbstractGraphics = _bridgeGraphics.requestGraphics(spr);
			
			gr.animateTexture(1, 1, 50, _bridgeGraphics.requestImage("User-Interface-Free-Spins-Background"));
			gr.moveTo(150, 0);
			gr.curveTo(500,100,500,300)
			gr.curveTo(500, 100, 700, 650)
			
			_bridgeGraphics.addChild(spr);
		}  
		
		private function testTexturedLine():void
		{
			var spr:IAbstractSprite = _bridgeGraphics.requestSprite("adasd");
			var gr:IAbstractGraphics = _bridgeGraphics.requestGraphics(spr);
			
			gr.drawLineTexture(50, _bridgeGraphics.requestImage("User-Interface-Free-Spins-Background"));
			gr.moveTo(150, 0);
			gr.curveTo(500,100,500,300)
			gr.curveTo(500, 100, 700, 650)
			
			_bridgeGraphics.addChild(spr);
		}
		
	
		private function testEmptyButton():void
		{
			var btn:IAbstractButton = _bridgeGraphics.requestButton("asd");
			var tField:IAbstractTextField = _bridgeGraphics.requestTextField(300, 300, "Ioana", "Verdana", 50, 0, false);
			var customLabel:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(tField);
			
			btn.upSkin_ =  _bridgeGraphics.requestImage("asdasd");
			btn.downSkin_ =  _bridgeGraphics.requestImage("asdasd");
			btn.hoverSkin_ =  _bridgeGraphics.requestImage("asdasd");
			btn.addCustomLabel(customLabel);
			btn.width = 500;
			
			_bridgeGraphics.addChild(btn);
			btn.x = 150;
			btn.y = 150;
		}
		
		private function testScreenShot():void
		{
			var rect:Rectangle = new Rectangle(150, 150, 500, 500);
			var img:Image = Image.fromBitmap(new Bitmap(_bridgeGraphics.requestScreenshot(rect, 1)));
			img.y = 100;
			_bridgeGraphics.addChild(img)
		}
		
		private var cb:IAbstractComboBox;
		private var testCount:uint = 10;
		
		private function testComboBox(name:String, xPos:uint, yPos:uint):void
		{
			 _bridgeGraphics.registerBitmapFont(new defaultFontPng(), XML(new defaultFontClass()));
			 _bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			 _bridgeGraphics.registerBitmapFont(new ZrnicBigFontPng(), XML(new ZrnicBigFontClass()));
			 _bridgeGraphics.registerBitmapFont(new ArialPng(), XML(new ArialClass()));
			 _bridgeGraphics.registerBitmapFont(new DesyrelPng(), XML(new DesyrelClass()));
			
			var dataProvider:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>;
			dataProvider.push(new EngineComboBoxItemRenderer("test1",  {test:"haha0"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test2",  {test:"haha1"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test3",  {test:"haha2"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test4",  {test:"haha3"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test5",  {test:"haha4"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test6",  {test:"haha5"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test7",  {test:"haha6"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test8",  {test:"haha7"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test9",  {test:"haha8"}));
			
			var backgroundImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(150, 200, false, 0xFFFFFF));
			
			//var cb:EngineComboBox = new EngineComboBox(_bridgeGraphics.signalsManager as SignalsHub,dataProvider, 200, 200,backgroundImage, "Zrnic");
			cb = _bridgeGraphics.requestComboBox(dataProvider, 200, 200,backgroundImage, "desyrel");
			_bridgeGraphics.addChild(cb);
			
			cb.x = xPos;
			cb.y = yPos;
			
			//cb.addItem(new EngineComboBoxItemRenderer("test " + Math.random() * 999999, _bridgeGraphics.requestImage("Spark-1"), {test:"haha"+testCount}));
			
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LIST_ITEM_TOUCHED, onItemTouched);
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.MOUSE_WHEEL, onWheel);
			
			trace(cb.currentSelectedIData + " " + cb.currentSelectedIndex + " " + cb.currentSelection);
		}
		
		private function onWheel(type:String, e:Object):void
		{
			trace(type+" " + e.params["delta"]);
		}
		
		private function onItemTouched(type:String, e:Object):void
		{
			//testScreenShot();
			//testCount++
			//cb.addItem(new EngineComboBoxItemRenderer("test " + Math.random() * 999999, _bridgeGraphics.requestImage("Spark-1"), { test:"test" +testCount } ));
			//cb.clearList();
			//trace(e["params"]["data"]["test"]);
			trace(cb.currentSelectedIndex);
		}
		
		private function testNativeOverlay():void
		{
			var nativeOverlay:Sprite = _bridgeGraphics.nativeDisplay;
			
			nativeOverlay.graphics.beginFill(0xFF0000);
			nativeOverlay.graphics.drawCircle(100, 100, 400);
			nativeOverlay.graphics.endFill();
		}
		
		private function testGradientFill():void
		{
				var square:IAbstractSprite = _bridgeGraphics.requestSprite("sq");
				var graphics:IAbstractGraphics = _bridgeGraphics.requestGraphics(square);
				
				graphics.beginFill(0x000000);
				graphics.drawRect(0, 0, 100, 60);
				graphics.endFill();
				square.x = 200;
				square.y = 200;
				square.rotation = 30;
				
				graphics.beginGradientFill("linear", [0x000000, 0x000000], [0, 1], [0, 255]);
				
				_bridgeGraphics.addChild(square);
				
				square.y = 300;
				
				//var stroke:Stroke = new Stroke();
				//stroke.addVertex(100, 100, 1, 0xFFFFFF, 0, 0xFFFFFF, 0);
				//stroke.addVertex(150, 150, 2);
				//stroke.addVertex(250, 200, 5);
				//stroke.addVertex(250, 200, 2);
				//stroke.addVertex(400, 300);
				//stroke.addVertex(400, 400, 1, 0xFFFFFF, 0, 0xFFFFFF, 0);
				//stroke.alpha = 0.3;
				//_bridgeGraphics.addChild(stroke);
		}
		
		private function testInputText():void
		{
			var input:IAbstractInputText = _bridgeGraphics.requestInputTextField(400, 50, "AAAAAAAAAAAAAAAAAAA", "Verdana", 50, 0x000000);
			input.name = "adadasd";
			input.x = 50;
			input.y = 50;
			input.restriction = "0-9.";
			input.backgroundBitmap = new Bitmap(new BitmapData(width, height, false, 0xFFFFFF));
			_bridgeGraphics.addChild(input);
			trace(input.name);
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.TEXT_INPUT_CHANGED, inputChanged);
		}
		
		private function inputChanged(type:String, event:Object):void
		{
			trace("CAUGHT " + type+" event: " + event);
		}
		
		private function testFreeSpins():void
		{
			var fsXML:XML = new XML();
			fsXML = _bridgeGraphics.getXMLFromAssetsManager("freeSpinsLayout");
			
			_layersVO.addLayer("fsUI", 0, fsXML, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			
			inLayers.push(_layersVO.retrieveLayer("fsUI"));
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);
			
			addEventListener(Event.ENTER_FRAME, updateValues);
		}
		
		private function updateValues(e:Event):void
		{
			var display:IAbstractLayer = _layersVO.retrieveLayer("fsUI");
			
			var value1:IAbstractLabel = display.getChildByNameStr("remainingSpinsValue") as IAbstractLabel;
			(value1 as IAbstractLabel).updateLabel(String(Math.random() * 9999999));
			
			var value2:IAbstractDisplayObject = display.getChildByNameStr("totalWinValue");
			(value2 as IAbstractLabel).updateLabel(String(Math.random() * 9999999));
			
			var value3:IAbstractDisplayObject = display.getChildByNameStr("currentWinValue");
			(value3 as IAbstractLabel).updateLabel(String(Math.random() * 9999999));
		}
		
		private var toggleBTN:IAbstractToggle
		private function testToggle():void
		{
			toggleBTN = _bridgeGraphics.requestToggleButton("gigi");
			toggleBTN.upSkin_ = toggleBTN.downSkin_ = toggleBTN.hoverSkin_ = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(200, 50, false, 0xFF0000));
			toggleBTN.toggleTrueImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(20, 20, false, 0xFFFFFF));
			toggleBTN.toggleFalseImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(20, 20, false, 0x000000));
			
			toggleBTN.x = toggleBTN.y = 200;
			_bridgeGraphics.addChild(toggleBTN);
			
				((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, onToggle);
		}
		
		private function onToggle(type:String, e:Object):void
		{
			var paytableXml:XML = new XML();
			paytableXml = _bridgeGraphics.getXMLFromAssetsManager("UserInterface");
			
			 //Adding the Paytable layer and initializing the layout via auto methods
			_layersVO.addLayer("UserInterface", 1, paytableXml, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var paytableLayer:IAbstractLayer = _layersVO.retrieveLayer("UserInterface");
			inLayers.push(paytableLayer);
			outLayers.push(_layersVO.retrieveLayer("Paytable"));
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, null, outLayers, null, _transOut);
		}
		
		private var _img:IAbstractImage
		
		private function testMovieClipsFromFrames():void
		{
			var images:Vector.<IAbstractImage> = new Vector.<IAbstractImage>;
			var spr:Sprite = new Sprite();
			var tf:TextField = new TextField();
			spr.addChild(tf);
			
			for (var i:uint = 0; i < 1000; i++ )
			{
				tf.text = String(i);
				var bmpData:BitmapData = new BitmapData(120, 120, true, 0xFF0000);
				bmpData.draw(spr);
				images.push(_bridgeGraphics.requestImageFromBitmapData(bmpData));
			}
			
				var mc:IAbstractMovie = _bridgeGraphics.requestMovieFromFrames(images, 20);
				mc.x = 100;
				mc.y = 100;
				mc.name = "mc";
				_bridgeGraphics.addChild(mc);
				
				TweenPlugin.activate([FramePlugin]);
				var tMax:TimelineMax = new TimelineMax();
				tMax.insert(TweenLite.to(mc, 2, { frame:999} ));
				tMax.play();
		}
		
		private function onMovieClipEnded(type:String, event:IAbstractSignalEvent):void
		{
			trace(type+" - " + event);
		}
		
		private function testSounds():void
		{
			_bridgeGraphics.retrieveSound("track").play();
		}
		
		private function testImages():void
		{
			_img = _bridgeGraphics.requestImage("Slider-Dragger");
			_bridgeGraphics.addChild(_img);
			
			//addEventListener(Event.ENTER_FRAME, drawStuff);
			_bridgeGraphics.colorizeImage(_img, 0xFF0000);
			
			_img.x = 250;
			_img.y = 250;
			
			_img.scaleX = _img.scaleY = 5;
		}
		
		private function drawStuff(e:Event):void
		{
			_img.newTextureFromBitmapData = new BitmapData(100, 100, false, Math.random() * 0xFFFFFF)
		}
		
		private function testMovieClips():void
		{
			//var snd:Sound = (_bridgeGraphics.assetsManager as starling.utils.AssetManager).getSound("track");
			//snd.play();
			
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("BadGuy-Walking", 10);
			_bridgeGraphics.currentContainer.addNewChild(mc);
			mc.play();
			mc.x = mc.y = 250;
			
			var holder:IAbstractSprite = _bridgeGraphics.requestSprite("asd");
			
			var graphics:IAbstractGraphics = _bridgeGraphics.requestGraphics(holder);
			
			graphics.beginFill(0x000000);
			graphics.drawCircle(50, 50, 50);
			graphics.endFill();
			
			var blurFilter:IAbstractBlurFilter = _bridgeGraphics.requestBlurFilter();
			
			_bridgeGraphics.addBlurFilter(holder, blurFilter);
			
			_bridgeGraphics.currentContainer.addNewChild(holder);
		}
		
		private var slider:IAbstractSlider;
		private function makeSlider():void
		{
			var sliderTextField:IAbstractTextField = _bridgeGraphics.requestTextField(140, 50, "", "Verdana", 20, 0xFFFFFF);
			var sliderLabel:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(sliderTextField, "label");
			slider = _bridgeGraphics.requestSlider(_bridgeGraphics.requestImage("Slider-Dragger"), 
																					_bridgeGraphics.requestImage("Slider-Dragger"),
																					_bridgeGraphics.requestImage("Slider-Track-Full"),
																					_bridgeGraphics.requestImage("Slider-Track-Full"),
																					_bridgeGraphics.requestImage("Slider-Slot"),
																					sliderLabel,
																					"test"
																					);
			slider.sliderComponentY = 20;
			slider.sliderComponentX = 5;
			slider.x = 250;
			slider.y = 250;
			_bridgeGraphics.addChild(slider);
			slider.sliderCurrentValue = 50;
		}
		
		private var _paytablePagesLayersVO:IAbstractEngineLayerVO;
		private var _currentPage:IAbstractLayer;
		private var _paytablePagesHolder:IAbstractSprite;
		
		private function showLines():void
		{
			_bridgeGraphics.registerBitmapFont(new defaultFontPng(), XML(new defaultFontClass()));
			 _bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			 _bridgeGraphics.registerBitmapFont(new ZrnicBigFontPng(), XML(new ZrnicBigFontClass()));
			 _bridgeGraphics.registerBitmapFont(new ArialPng(), XML(new ArialClass()));
			 _bridgeGraphics.registerBitmapFont(new DesyrelPng(), XML(new DesyrelClass()));
			 
			 var linesXML:XML = new XML();
			linesXML = _bridgeGraphics.getXMLFromAssetsManager("linesLayout");
			
			_layersVO.addLayer("Lines", 0, linesXML, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var linesLayer:IAbstractLayer = _layersVO.retrieveLayer("Lines");
			inLayers.push(linesLayer);
			
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.DISPLAY_OBJECT_TOUCHED, doTouched);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_OVER, doOver);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_ENDED, doEnded);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_OUT, doOut);
			
			for (var i:uint = 0; i < 20; i++ )
			{
				var img:IAbstractImage = _bridgeGraphics.requestImage("History-Icon");
				
				img.name = "imgline"+(i+1);
				img.x = _layersVO.retrieveLayer("Lines").getChildByNameStr("line"+(i+1)).x + 20;
				img.y =_layersVO.retrieveLayer("Lines").getChildByNameStr("line"+(i+1)).y;
				img.alpha = 0;
				
				_layersVO.retrieveLayer("Lines").addNewChild(img);
			}
		}
		
		private function showPaytable():void
		{	
			//_bridgeGraphics.registerBitmapFont(new defaultFontPng(), XML(new defaultFontClass()));
			 //_bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			 //_bridgeGraphics.registerBitmapFont(new ZrnicBigFontPng(), XML(new ZrnicBigFontClass()));
			 //_bridgeGraphics.registerBitmapFont(new ArialPng(), XML(new ArialClass()));
			 //_bridgeGraphics.registerBitmapFont(new DesyrelPng(), XML(new DesyrelClass()));
			
			var paytableXml:XML = new XML();
			paytableXml = _bridgeGraphics.getXMLFromAssetsManager("Paytable");
			
			 //Adding the Paytable layer and initializing the layout via auto methods
			_layersVO.addLayer("Paytable", 0, paytableXml, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var paytableLayer:IAbstractLayer = _layersVO.retrieveLayer("Paytable");
			inLayers.push(paytableLayer);
			
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers, null, _transIn);
			paytableLayer = _layersVO.retrieveLayer("Paytable");
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, onToggle);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, onTransitionInComplete);
			
			paytableLayer.flatten();
		}
		
		private function onTransitionInComplete(type:String, data:Object ):void
		{
			trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!! " + type);
		}
		
		private function doOut(type:String, event:IAbstractSignalEvent):void
		{
			trace(type+" Out");
			//(_layersVO.retrieveLayer("Lines").getChildByNameStr("img" + type)).alpha = 0;
			//TweenLite.to((_layersVO.retrieveLayer("Lines").getChildByNameStr("img" + type)), .5, { alpha:0} );
		}
		
		private function doEnded(type:String, event:IAbstractSignalEvent):void
		{
			trace(type+" Ended");
		}
		
		private function doOver(type:String, event:IAbstractSignalEvent):void
		{
			trace(type+" Over ");
			//(_layersVO.retrieveLayer("Lines").getChildByNameStr("img" + type)).alpha = 1;
			//TweenLite.to((_layersVO.retrieveLayer("Lines").getChildByNameStr("img" + type)), .5, { alpha:1 } );
		}
		
		private function doTouched(type:String, event:IAbstractSignalEvent):void
		{
			trace(type);
		}
		
		private function buttonPressed(type:String, event:IAbstractSignalEvent):void
		{		
			var inLayer:IAbstractLayer;
			
			switch(type)
			{
				case "OverviewButton":
					inLayer = _paytablePagesLayersVO.retrieveLayer("Overview");
					break;
				case "ScatterButton":
						inLayer = _paytablePagesLayersVO.retrieveLayer("Scatter");
					break;
				case "StickyWildButton":
						inLayer = _paytablePagesLayersVO.retrieveLayer("Wild");
					break;
				case "BonusButton":
						inLayer = _paytablePagesLayersVO.retrieveLayer("Bonus");
					break;
				case "LinesRulesButton":
						inLayer = _paytablePagesLayersVO.retrieveLayer("Rules");
					break;
				case "ShortcutsButton":
						inLayer = _paytablePagesLayersVO.retrieveLayer("Shortcuts");
					break;
			}
			
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			
			inLayers.push(inLayer);
			if (_currentPage)
			{
				outLayers.push(_currentPage); 
			}
			
			_bridgeGraphics.updateLayers(_paytablePagesHolder, inLayers, outLayers, _transIn, _transOut);
			_currentPage = inLayer;
		}
		
		private function animIn(obj1:IAbstractDisplayObject, obj2:IAbstractDisplayObject):void
		{
			TweenLite.to(obj1, Math.random()*2, { x:Math.random() * 250, onComplete:  _transIn.onTransitionComplete, onCompleteParams:[obj1, obj2]} );
		}
		
		private function animOut(obj1:IAbstractDisplayObject, obj2:IAbstractDisplayObject):void
		{
			TweenLite.to(obj1, Math.random()*2, { x:Math.random() * 250, onComplete:  _transOut.onTransitionComplete, onCompleteParams:[obj1, obj2]} );
		}
		
		private function transInComplete(type:String, obj:IAbstractSignalEvent):void
		{
			//trace("IN Caught Transition " + type+" & " + obj);
			//var img:IAbstractImage = layer1.getChildByNameStr("Background") as IAbstractImage;
			//TweenLite.to(img, 1, { x:300 } );
			//var tweenTimeline:TimelineMax = new TimelineMax();
			//tweenTimeline.insert(TweenLite.to(img, 3, { x:300 } ));
			//tweenTimeline.insert(TweenLite.to(img, 3, { x:0 } ));
			//
			//tweenTimeline.play();
		}
		
		private function transOutComplete(type:String, obj:IAbstractSignalEvent):void
		{
			trace("OUT Caught Transition " + type+" & " + obj);
		}
		
		private function onSlider(type:String, obj:IAbstractSignalEvent):void
		{
			trace("Caught Slider " + type+" & " + obj);
			trace("!!!!!!!!!!!!!!!! " + slider.sliderCurrentValue);
		}
		
	}

}