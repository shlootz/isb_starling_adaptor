package  
{
	import abstract.AbstractPool;
	import away3d.controllers.SpringController;
	import bridge.abstract.events.IAbstractEvent;
	import bridge.abstract.IAbstractAnimatable;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractJuggler;
	import bridge.abstract.IAbstractLayer;
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
	import bridge.abstract.ui.LabelProperties;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import citrus.core.starling.StarlingCitrusEngine;
	import com.greensock.TweenLite;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
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
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	import starlingEngine.elements.EngineLabel;
	import starlingEngine.elements.EngineLayer;
	import starlingEngine.elements.EngineLayerVO;
	import starlingEngine.elements.EngineTexture;
	import starlingEngine.elements.EngineVideo;
	import starlingEngine.events.EngineEvent;
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
		[Embed(source = "../bin/assets/bitmapfonts/Arial.fnt", mimeType = "application/octet-stream")]
		private static const FontXml : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Arial_0.png")]
		private static const FontTexture : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Times.fnt", mimeType = "application/octet-stream")]
		private static const TimesXml : Class;
		
		[Embed(source = "../bin/assets/bitmapfonts/Times_0.png")]
		private static const TimesTexture : Class;
		
		private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
																		StarlingEngine,
																		starling.utils.AssetManager,
																		signals.SignalsHub,
																		abstract.AbstractPool,
																		starling.animation.Juggler,
																		nape.space.Space
																		);
		
		public function test() 
		{	
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0x000000);
			btn.graphics.drawRect(10, 50, 20, 20);
			btn.graphics.endFill();
			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK, doStuff);
			addChild(_bridgeGraphics.engine as DisplayObject);
		}
		
		private function doStuff(e:MouseEvent):void
		{
			loadAssets();
		}
		
		private function loadAssets():void
		{
			(_bridgeGraphics.assetsManager).enqueue("../bin/assets/spritesheets/spriteSheetBackgrounds.png", 
													"../bin/assets/spritesheets/spriteSheetBackgrounds.xml",
													"../bin/assets/spritesheets/spriteSheetElements.png",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													"../bin/assets/spritesheets/spriteSheetElements.xml",
													"../bin/assets/spritesheets/spriteSheetPayTable.xml",
													"../bin/assets/layouts/layerLayout.xml"
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
			
			var button:IAbstractButton = _bridgeGraphics.requestButton();
			button.downSkin_ = _bridgeGraphics.requestImage("Spin-Button-Down") as IAbstractDisplayObject;
			button.upSkin_ = _bridgeGraphics.requestImage("Spin-Button") as IAbstractDisplayObject;
			button.hoverSkin_ = _bridgeGraphics.requestImage("Spin-Button-Hover") as IAbstractDisplayObject;
			button.disabledSkin_ = _bridgeGraphics.requestImage("Spin-Button-Hover") as IAbstractDisplayObject;
			
			button.x = 50;
			button.y = 50;
			
			button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			
			uiHolder.addNewChild(button as IAbstractDisplayObject);
			
			var t:IAbstractTextField = _bridgeGraphics.requestTextField(150, 30, "Yaaaay", "Times", 30);
			t.autoScale = true;
			t.hAlign = LabelProperties.ALIGN_CENTER;
			
			var label:EngineLabel = new EngineLabel(t);
			
			button.addCustomLabel(label, LabelProperties.ALIGN_CENTER, new Point(100,100));
			button.updateCustomLabel("Haha");
			
		}
		
		private function button_triggeredHandler(e:Event):void
		{
			(e.currentTarget as IAbstractButton).isEnabled  = false;
			showThings();
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
			x = _bridgeGraphics.requestXML("layerLayout");
			
			var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			layersVO.addLayer("UI", 0);
			layersVO.addLayer("Overground", 1);
			layersVO.addLayer("Layer 3", 2, x);
			layersVO.addLayer("Stuff with layout", 3);
						
			layersVO.retrieveLayer("Layer 3").addNewChild(mc);
						//
			_bridgeGraphics.initLayers(layersVO.layers);
			
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED, buttonPressed);
			(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.MOVIE_CLIP_ENDED, movieclipEnded);
			
			layersVO.addLayer("TEST", 4, x);
			
			var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			
			var outTransition:IAbstractLayerTransitionOut = new EngineLayerTransitionOut();
			var inTransition:IAbstractLayerTransitionIn = new EngineLayerTransitionIn();
			
			inLayers.push(layersVO.retrieveLayer("TEST"));
			outLayers.push(layersVO.retrieveLayer("Layer 3"));
			
			_bridgeGraphics.updateLayers(inLayers, outLayers, inTransition, outTransition);
						//
			//var transIn:IAbstractLayerTransitionIn = new EngineLayerTransitionIn();
			//var transOut:IAbstractLayerTransitionOut = new EngineLayerTransitionOut();
						//
			//var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			//outLayers.push(layersVO.retrieveLayer("Layer 2"));
						//
			//var newLayer:IAbstractLayer = new EngineLayer("Tzeapa", 0);
			//newLayer.addNewChild(_bridgeGraphics.requestImage("Preloader-Background"));
						//
			//var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>;
			//inLayers.push(newLayer);
						//
			//_bridgeGraphics.updateLayers(inLayers, null, transIn, transOut);
						//
			//var state2:IAbstractState = _bridgeGraphics.requestState();
			//var stateTransition:IAbstractStateTransition = new EngineStateTransition();
			//_bridgeGraphics.tranzitionToState(state2, stateTransition);
				//
			//var video:IAbstractVideo = new EngineVideo();
			//video.addVideoPath("../bin/assets/test.flv");
			//state2.addNewChild(video);
			//
 //
			//var texture:Texture = Texture.fromBitmap(new TimesTexture());
			//var xml:XML = XML(new TimesXml());
			//TextField.registerBitmapFont(new BitmapFont(texture, xml))
			//
			/////////////////////////////////////////////////////
		}
		
		private function buttonPressed(type:String, event:Object):void
		{
			trace("Caught "+type+" "+event)
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