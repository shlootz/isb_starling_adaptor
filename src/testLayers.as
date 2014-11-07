package  
{
	import away3d.controllers.SpringController;
	import away3d.events.AssetEvent;
	import bridge.abstract.AbstractPool;
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.events.IAbstractSignalEvent;
	import bridge.abstract.filters.IAbstractBlurFilter;
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
	import cmodule.AwayPhysics.TextFieldI;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
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
	import starlingEngine.extensions.DistanceFieldFont;
	import starlingEngine.extensions.DistanceFieldQuadBatch;
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
																		
		private var _layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
		private var _transIn:IAbstractLayerTransitionIn = _bridgeGraphics.requestLayerTransitionIN();
		private var _transOut:IAbstractLayerTransitionOut = _bridgeGraphics.requestLayerTransitionOUT();
		
		public function testLayers() 
		{
			
			addChild(_bridgeGraphics.engine as DisplayObject);
			 (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
		}

		private function loadAssets(event:String, obj:Object):void
		{
			(_bridgeGraphics.assetsManager).enqueue(
													"../bin/assets/spritesheets/spriteSheetBackgrounds.png", 
													"../bin/assets/spritesheets/spriteSheetBackgrounds.xml",
													"../bin/assets/spritesheets/spriteSheetElements.png",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													 "../bin/assets/sdfFonts/Poplar.otf_sdf.xml",
													 "../bin/assets/layouts/bonusLayout.xml",
													 "../bin/assets/spritesheets/featureAssets.xml",
													 "../bin/assets/spritesheets/Scrolls of Ra Feature Assets.png"
													 
													//"../bin/assets/spritesheets/spriteSheetElements.xml",
													//"../bin/assets/spritesheets/spriteSheetPayTable.xml",
													//"../bin/assets/spritesheets/preloader1x.png",
													//"../bin/assets/spritesheets/Scrolls of Ra Assets.png",
													//"../bin/assets/spritesheets/preloader1x.xml",
													//"../bin/assets/spritesheets/backgroundAssets.xml",
													//"../bin/assets/layouts/layerLayout.xml",
													//"../bin/assets/layouts/preloader1xLayout.xml",
													//"../bin/assets/layouts/buttonLayout.xml",
													//"../bin/assets/layouts/UserInterface.xml",
													//"../bin/assets/layouts/Paytable.xml",
													//"../bin/assets/layouts/PaytablePage1.xml",
													//"../bin/assets/layouts/PaytablePage2.xml",
													//"../bin/assets/layouts/PaytablePage3.xml",
													//"../bin/assets/layouts/PaytablePage4.xml",
													//"../bin/assets/layouts/PaytablePage5.xml",
													//"../bin/assets/layouts/PaytablePage6.xml",
													//"../bin/assets/layouts/linesLayout.xml",
													//"../bin/assets/sounds/track.mp3",
													//"../bin/assets/layouts/freeSpinsLayout.xml",
													//"../bin/assets/layouts/menuLayout.xml"
													);
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
				{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1)
					{	
						_transIn.injectAnimation(animIn);
						_transOut.injectAnimation(animIn);
						
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, transOutComplete);
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.GENERIC_SLIDER_CHANGE, onSlider);
						
						container = _bridgeGraphics.requestSprite("asd");
						layer = _bridgeGraphics.requestLayer("bonus", 1, _bridgeGraphics.getXMLFromAssetsManager("bonusLayout") , true);
						_bridgeGraphics.addChild(container);
						(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, bonusOver);
						testBonus();
						//testTexts();
						//testDistanceFonts();
						//testParticles();
						//testParticlesFromBridge();
						//testFiters();
						//testLayersTranzitions();
						//testGradientMask();
						//testDifferentSize();
						//testMovieClipsFromFrames();
						//showLines();
						//showMenu();
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
							//testFLV(Math.random() * 800, Math.random() * 600);
						//}
						//testOmnes();
					}
				});
		}
		
		private var container:IAbstractSprite;
		private var layer:IAbstractLayer;
		
		private function testBonus():void
		{
			var layersIn:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			layersIn.push(layer);
			
			_bridgeGraphics.updateLayers(container, layersIn);
			
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED,chestPressed);
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
		
		private function testTexts():void
		{
			_bridgeGraphics.registerBitmapFont(new dimboFontPng(), XML(new dimboFontClass()));
			
			var tF1:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 10, 0xFFFFFF);
			var tF2:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 15, 0xFFFFFF);
			var tF3:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 20, 0xFFFFFF);
			var tF4:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 30, 0xFFFFFF);
			var tF5:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 40, 0xFFFFFF);
			var tF6:IAbstractTextField = _bridgeGraphics.requestTextField(100, 100, "GEORGE", "Dimbo", 50, 0xFFFFFF);
			
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
			
			tryLabel(250, 20, 10);
			tryLabel(250, 50, 15);
			tryLabel(250, 80, 20);
			tryLabel(250, 110, 30);
			tryLabel(250, 140, 40);
			tryLabel(250, 180, 50);
		}
		
		private function tryLabel(newX:uint, newY:uint, newSize:uint):void
		{
			var labelFeathers1:Label = new Label();
			labelFeathers1.text = "GEORGE";
			labelFeathers1.x = newX;
			labelFeathers1.y = newY;
			labelFeathers1.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
				textRenderer.textFormat = new BitmapFontTextFormat("Dimbo", newSize);
				return textRenderer;
			}
			_bridgeGraphics.addChild(labelFeathers1);
		}
		
		private function testParticlesFromBridge():void
		{
			var atlas:XML = _bridgeGraphics.getXMLFromAssetsManager("spriteSheetElements");
			var particleTexture:Texture = _bridgeGraphics.requestImage("symbol_0").currentTexture as Texture;
			
			var advancedParticles:IAbstractParticleSystem = _bridgeGraphics.requestAdvancedParticleSystem(XML(new DrugsConfig()), _bridgeGraphics.requestImage("symbol_0"), atlas);
			_bridgeGraphics.addChild(advancedParticles);
			advancedParticles.start();
		}
		
		private function testFiters():void
		{
			var img:IAbstractImage = _bridgeGraphics.requestImage("Background");
			_bridgeGraphics.addChild(img);
			
			//var pixelateFilter:PixelateFilter = new PixelateFilter(10);
			//(img as Image).filter = pixelateFilter;
			_bridgeGraphics.addNewsPaperFilter(img, 10,2,30);
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
			rect.width = 300;
			rect.height = 300;
			
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
			
			TweenLite.to(img, 400, { rotation:360 } );
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
			_bridgeGraphics.addChild(_bridgeGraphics.requestImage("Full-Screen-Icon"));
			
			var img:IAbstractImage = _bridgeGraphics.requestImage("Settings-Button-Hover");
			img.y = 150;
			
			var btn:IAbstractButton = _bridgeGraphics.requestButton("george");
			btn.upSkin_ = _bridgeGraphics.requestImage("Full-Screen-Icon");
			btn.x = btn.y =  250;
			
			_bridgeGraphics.addChild(img);
			_bridgeGraphics.addChild(btn);
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
		
		private function testFLV(posX:Number, posY:Number):void
		{
			var nc:NetConnection = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS , onConnect);
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR , trace);


			var metaSniffer:Object=new Object();  
			nc.client=metaSniffer;
			nc.connect(null);
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
			
			btn.upSkin_ =  _bridgeGraphics.requestImage("asdasd");
			btn.downSkin_ =  _bridgeGraphics.requestImage("asdasd");
			btn.hoverSkin_ =  _bridgeGraphics.requestImage("asdasd");
			
			btn.width = 500;
			
			_bridgeGraphics.addChild(btn);
			btn.x = 0;
			btn.y = 0;
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
			trace(type);
			trace(e);
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
			
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Spark", 60);
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
			_bridgeGraphics.registerBitmapFont(new defaultFontPng(), XML(new defaultFontClass()));
			 _bridgeGraphics.registerBitmapFont(new OmnesPng(), XML(new OmnesClass()));
			 _bridgeGraphics.registerBitmapFont(new ZrnicBigFontPng(), XML(new ZrnicBigFontClass()));
			 _bridgeGraphics.registerBitmapFont(new ArialPng(), XML(new ArialClass()));
			 _bridgeGraphics.registerBitmapFont(new DesyrelPng(), XML(new DesyrelClass()));
			
			var paytableXml:XML = new XML();
			paytableXml = _bridgeGraphics.getXMLFromAssetsManager("Paytable");
			
			 //Adding the Paytable layer and initializing the layout via auto methods
			_layersVO.addLayer("Paytable", 0, paytableXml, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			var paytableLayer:IAbstractLayer = _layersVO.retrieveLayer("Paytable");
			inLayers.push(paytableLayer);
			
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);
			paytableLayer = _layersVO.retrieveLayer("Paytable");
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, onToggle);
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