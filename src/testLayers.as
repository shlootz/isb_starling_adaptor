package  
{
	import bridge.abstract.AbstractPool;
	import bridge.abstract.events.IAbstractSignalEvent;
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractGraphics;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractTextField;
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
	import com.greensock.TweenLite;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;
	import flappybird.Assets;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
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
	import starling.display.Graphics;
	import starling.display.graphics.Stroke;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Stage;
	import starling.textures.GradientTexture;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starlingEngine.elements.EngineLabel;
	import starlingEngine.StarlingEngine;
	import starlingEngine.ui.EngineComboBox;
	import starlingEngine.ui.EngineList;
	import starlingEngine.ui.EngineComboBoxItemRenderer;
	import starlingEngine.ui.EngineInputText;
	import starlingEngine.ui.EngineSlider;
	import starlingEngine.ui.EngineToggleButton;
	/**
	 * ...
	 * @author Eu
	 */
	public class testLayers extends Sprite
	{
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
													"../bin/assets/layouts/UserInterface.xml",
													"../bin/assets/layouts/Paytable.xml",
													"../bin/assets/layouts/PaytablePage1.xml",
													"../bin/assets/layouts/PaytablePage2.xml",
													"../bin/assets/layouts/PaytablePage3.xml",
													"../bin/assets/layouts/PaytablePage4.xml",
													"../bin/assets/layouts/PaytablePage5.xml",
													"../bin/assets/layouts/PaytablePage6.xml",
													"../bin/assets/sounds/track.mp3",
													"../bin/assets/layouts/freeSpinsLayout.xml"
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
						testTexturedLine();
						testAnimatedTexture();
					}
				});
		}
		
		private function testAnimatedTexture():void
		{
			var spr:IAbstractSprite = _bridgeGraphics.requestSprite("adasd");
			var gr:IAbstractGraphics = _bridgeGraphics.requestGraphics(spr);
			
			gr.animateTexture(1, 1, 50, new Bitmap(new BitmapData(1000, 30, false, 0xFFFFFF)));
			gr.moveTo(150, 0);
			gr.curveTo(500,100,500,300)
			gr.curveTo(500, 100, 700, 650)
			
			_bridgeGraphics.addChild(spr);
		}
		
		private function testTexturedLine():void
		{
			var spr:IAbstractSprite = _bridgeGraphics.requestSprite("adasd");
			var gr:IAbstractGraphics = _bridgeGraphics.requestGraphics(spr);
			
			gr.drawLineTexture(50, new Bitmap(new BitmapData(1000, 30, false, 0xFF0000)));
			gr.moveTo(150, 0);
			gr.curveTo(500,100,500,300)
			gr.curveTo(500, 100, 700, 650)
			
			gr.updateLineTexture(new Bitmap(new BitmapData(1000, 30, false, 0xFFFFFF)));
			gr.drawLineTexture(50, new Bitmap(new BitmapData(1000, 30, false, 0xFFFFFF)));
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
			 _bridgeGraphics.registerBitmapFont(new ZrnicFontPng(), XML(new ZrnicFontClass()));
			 _bridgeGraphics.registerBitmapFont(new ZrnicBigFontPng(), XML(new ZrnicBigFontClass()));
			
			var dataProvider:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>;
			dataProvider.push(new EngineComboBoxItemRenderer("test1", _bridgeGraphics.requestImage("Spark-1"), {test:"haha0"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test2", _bridgeGraphics.requestImage("Spark-1"), {test:"haha1"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test3", _bridgeGraphics.requestImage("Spark-1"), {test:"haha2"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test4", _bridgeGraphics.requestImage("Spark-1"), {test:"haha3"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test5", _bridgeGraphics.requestImage("Spark-1"), {test:"haha4"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test6", _bridgeGraphics.requestImage("Spark-1"), {test:"haha5"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test7", _bridgeGraphics.requestImage("Spark-1"), {test:"haha6"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test8", _bridgeGraphics.requestImage("Spark-1"), {test:"haha7"}));
			dataProvider.push(new EngineComboBoxItemRenderer("test9", _bridgeGraphics.requestImage("Spark-1"), {test:"haha8"}));
			
			var backgroundImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(150, 200, false, 0xFFFFFF));
			
			//var cb:EngineComboBox = new EngineComboBox(_bridgeGraphics.signalsManager as SignalsHub,dataProvider, 200, 200,backgroundImage, "Zrnic");
			cb = _bridgeGraphics.requestComboBox(dataProvider, 200, 200,backgroundImage, "Zrnic");
			_bridgeGraphics.addChild(cb);
			
			cb.x = xPos;
			cb.y = yPos;
			
			cb.addItem(new EngineComboBoxItemRenderer("test " + Math.random() * 999999, _bridgeGraphics.requestImage("Spark-1"), {test:"haha"+testCount}));
			
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.LIST_ITEM_TOUCHED, onItemTouched)
			
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
				graphics.drawRect(0, 0, 200, 200);
				graphics.endFill();
				square.x = 200;
				square.y = 200;
				
				graphics.beginGradientFill("linear", [0x000000, 0x000000], [0, 1], [0, 255]);
				
				_bridgeGraphics.addChild(square);
				
				square.y = 300;
				
				var stroke:Stroke = new Stroke();
				stroke.addVertex(100, 100, 1, 0xFFFFFF, 0, 0xFFFFFF, 0);
				stroke.addVertex(150, 150, 2);
				stroke.addVertex(250, 200, 5);
				stroke.addVertex(250, 200, 2);
				stroke.addVertex(400, 300);
				stroke.addVertex(400, 400, 1, 0xFFFFFF, 0, 0xFFFFFF, 0);
				stroke.alpha = 0.3;
				_bridgeGraphics.addChild(stroke);
		}
		
		private function testInputText():void
		{
			var input:IAbstractInputText = _bridgeGraphics.requestInputTextField(400, 50, "AAAAAAAAAAAAAAAAAAA", "Verdana", 50, 0x000000);
			input.name = "adadasd";
			input.x = 50;
			input.y = 50;
			input.restriction = "0-9.";
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
			trace("asd");
			trace(e);
		}
		
		private var _img:IAbstractImage
		
		private function testMovieClipsFromFrames():void
		{
			var images:Vector.<IAbstractImage> = new Vector.<IAbstractImage>;
			
			for (var i:uint = 0; i < 1000; i++ )
			{
				images.push(_bridgeGraphics.requestImageFromBitmapData(new BitmapData(120, 120, false, Math.random() * 0xFFFFFF)));
			}
			
			for (var j:uint = 0; j < 1000; j++ )
			{
				var mc:IAbstractMovie = _bridgeGraphics.requestMovieFromFrames(images, Math.random()*60);
				mc.x = 100 + Math.random()*700;
				mc.y = 100 + Math.random() * 500;
				mc.name = "mc" + j;
				mc.play();
				_bridgeGraphics.addChild(mc);
			}
			
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.MOVIE_CLIP_ENDED, onMovieClipEnded);
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
			var snd:Sound = (_bridgeGraphics.assetsManager as starling.utils.AssetManager).getSound("track");
			snd.play();
			
			var mc:IAbstractMovie = _bridgeGraphics.requestMovie("s", 60);
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
			var sliderTextField:IAbstractTextField = _bridgeGraphics.requestTextField(140, 50, "Test", "Verdana", 20, 0xFFFFFF);
			var sliderLabel:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(sliderTextField, "label");
			slider = _bridgeGraphics.requestSlider(_bridgeGraphics.requestImage("Slider-Dragger"), 
																					_bridgeGraphics.requestImage("Slider-Dragger"),
																					_bridgeGraphics.requestImage("Slider-Track-Full"),
																					_bridgeGraphics.requestImage("Slider-Track-Full"),
																					_bridgeGraphics.requestImage("Slider-Slot"),
																					sliderLabel,
																					"test"
																					);
			
			slider.x = 250;
			slider.y = 250;
			_bridgeGraphics.addChild(slider);
			slider.sliderCurrentValue = 50;
		}
		
		private var _paytablePagesLayersVO:IAbstractEngineLayerVO;
		private var _currentPage:IAbstractLayer;
		private var _paytablePagesHolder:IAbstractSprite;
		
		private function showPaytable():void
		{	
			getQualifiedClassName(_bridgeGraphics.requestSprite())
			var aPool:AbstractPool = new AbstractPool("Test", 	getDefinitionByName(getQualifiedClassName(_bridgeGraphics.requestSprite())) as Class, 20);
			
			var testSprite:IAbstractSprite = _bridgeGraphics.requestSprite("test");
			testSprite.addNewChild(_bridgeGraphics.requestImage("Background"));
			testSprite.updateMouseGestures(_bridgeGraphics.signalsManager, true);
			_bridgeGraphics.addChild(testSprite);
			
			var img:IAbstractImage = _bridgeGraphics.requestImage("Background");
			var img2:IAbstractImage = _bridgeGraphics.requestImage("Background");
			
			var testas:IAbstractLayer = _bridgeGraphics.requestLayer("asd", 2, null, false);
			_bridgeGraphics.returnToPool(img);
			_bridgeGraphics.returnToPool(img2);
			_bridgeGraphics.returnToPool(testSprite);
			
			testSprite = _bridgeGraphics.requestSprite("test");
			testSprite.addNewChild(_bridgeGraphics.requestImage("Bonus-Background"));
			testSprite.updateMouseGestures(_bridgeGraphics.signalsManager, true);
			_bridgeGraphics.addChild(testSprite);
			 //Retrievieng the XML layout for the paytable main menu
			var paytableXml:XML = new XML();
			paytableXml = _bridgeGraphics.getXMLFromAssetsManager("Paytable");
			
			 //Adding the Paytable layer and initializing the layout via auto methods
			_layersVO.addLayer("Paytable", 0, paytableXml, true);
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			inLayers.push(_layersVO.retrieveLayer("Paytable"));
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);
			
			//Creating a custom holder for the pages layouts
			_paytablePagesHolder = _bridgeGraphics.requestSprite("paytableHolder");
			
			//Creating a custom layersVO for the container created above
			_paytablePagesLayersVO = _bridgeGraphics.requestLayersVO();
			
			//Creating the XMLs for each page. In real life, these XMLs will be parsed from a single paytable.xml file
			var page1Xml:XML = new XML();
			page1Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage1");
			var page2Xml:XML = new XML();
			page2Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage2");
			var page3Xml:XML = new XML();
			page3Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage3");
			var page4Xml:XML = new XML();
			page4Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage4");
			var page5Xml:XML = new XML();
			page5Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage5");
			var page6Xml:XML = new XML();
			page6Xml = _bridgeGraphics.getXMLFromAssetsManager("PaytablePage6");
			
			//Adding the layers to the custom layersVO 
			_paytablePagesLayersVO.addLayer("Overview", 0, page1Xml);
			_paytablePagesLayersVO.addLayer("Scatter", 1, page2Xml);
			_paytablePagesLayersVO.addLayer("Wild", 2, page3Xml);
			_paytablePagesLayersVO.addLayer("Bonus", 3, page4Xml);
			_paytablePagesLayersVO.addLayer("Rules", 4, page5Xml);
			_paytablePagesLayersVO.addLayer("Shortcuts", 5, page6Xml);
			
			//Drawing the layouts by direct call to the drawLayerLayout method
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Overview"));
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Scatter"));
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Wild"));
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Bonus"));
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Rules"));
			_bridgeGraphics.drawLayerLayout(_paytablePagesLayersVO.retrieveLayer("Shortcuts"));
			
			//Adding the first page of the paytable
			_currentPage = _paytablePagesLayersVO.retrieveLayer("Overview");
			//_paytablePagesHolder.addNewChild(_currentPage as IAbstractDisplayObject);
			
			//Moving the container a bit
			_paytablePagesHolder.x = 200;
			
			//Adding the container to the paytable layer
			_layersVO.retrieveLayer("Paytable").addNewChild(_paytablePagesHolder);
			
			//Adding a listener to the signal from paytable
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED, buttonPressed);
			
			_layersVO.retrieveLayer("Paytable").updateMouseGestures((_bridgeGraphics.signalsManager as ISignalsHub), true);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.DISPLAY_OBJECT_TOUCHED, doTouched);
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
			trace("IN Caught Transition " + type+" & " + obj);
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