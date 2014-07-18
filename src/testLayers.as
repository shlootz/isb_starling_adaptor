package  
{
	import bridge.abstract.AbstractPool;
	import bridge.abstract.events.IAbstractSignalEvent;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import com.greensock.TweenLite;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import nape.space.Space;
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.utils.AssetManager;
	import starlingEngine.StarlingEngine;
	import starlingEngine.ui.EngineSlider;
	import starlingEngine.ui.EngineToggleButton;
	/**
	 * ...
	 * @author Eu
	 */
	public class testLayers extends Sprite
	{
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
													"../bin/assets/layouts/PaytablePage6.xml"
													);
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
				{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1)
					{	
						_transIn.injectAnimation(animIn);
						
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, transOutComplete);
						((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.GENERIC_SLIDER_CHANGE, onSlider);
						showPaytable();
						makeUILayer();
						//makeSlider();
					}
				});
		}
		
		private function makeSlider():void
		{
			var sliderTextField:IAbstractTextField = _bridgeGraphics.requestTextField(140, 50, "Test", "Verdana", 20, 0xFFFFFF);
			var sliderLabel:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(sliderTextField, "label");
			var slider:IAbstractSlider = _bridgeGraphics.requestSlider(_bridgeGraphics.requestImage("Slider-Dragger"), 
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
		}
		
		private var _paytablePagesLayersVO:IAbstractEngineLayerVO;
		private var _currentPage:IAbstractLayer;
		private var _paytablePagesHolder:IAbstractSprite;
		
		private function showPaytable():void
		{	
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
			
			//Adding new layer pages to the paytable container
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			inLayers.push(inLayer);
			//_bridgeGraphics.updateLayers(_paytablePagesHolder, inLayers, null, _transIn);
			
			//var inLayersMain:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			//inLayersMain.push(_layersVO.retrieveLayer("UI"));
			//(_layersVO.retrieveLayer("UI") as IAbstractLayer).addToStage = true;
			//_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayersMain, null, _transIn);
			
			//var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			//outLayers.push(_layersVO.retrieveLayer("UI"));
			//_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers, outLayers);
		}
		
		private function makeUILayer():void
		{
			var mainUIxml:XML = new XML();
			mainUIxml = _bridgeGraphics.getXMLFromAssetsManager("UserInterface");
			
			_layersVO.addLayer("UI", 1, mainUIxml, true);
			
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
			inLayers.push(_layersVO.retrieveLayer("UI"));
			_bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers, null, _transIn);
		}
		
		private function animIn(obj1:IAbstractDisplayObject, obj2:IAbstractDisplayObject):void
		{
			TweenLite.to(obj1, 1, { x:Math.random() * 250, onComplete:  _transIn.onTransitionComplete, onCompleteParams:[obj1, obj2]} );
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
		}
		
	}

}