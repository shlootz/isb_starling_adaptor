package starlingEngine
{
	import adobe.utils.CustomActions;
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	import bridge.abstract.filters.IAbstractGlowFilter;
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractScrollTile;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import bridge.abstract.ui.LabelProperties;
	import flash.display3D.Context3DProfile;
	import flash.geom.Point;
	import starling.filters.BlurFilter;
	import starlingEngine.elements.EngineBlitMask;
	import starlingEngine.elements.EngineMask;
	import starlingEngine.elements.EngineScrollTile;
	import starlingEngine.extensions.krecha.ScrollImage;
	import starlingEngine.extensions.krecha.ScrollTile;
	import starlingEngine.filters.BlurFilterVO;
	import starlingEngine.filters.DropShadowFilterVO;
	import starlingEngine.filters.GlowFilterVO;
	import starlingEngine.ui.EngineSlider;
	import starlingEngine.ui.EngineToggleButton;
	import starlingEngine.validators.LayoutButtonValidator;
	import starlingEngine.validators.LayoutImageValidator;
	import starlingEngine.validators.LayoutMovieClipValidator;
	import starlingEngine.validators.LayoutSliderValidator;
	import starlingEngine.validators.LayoutTextFieldValidator;
	import starlingEngine.validators.LayoutToggleButtonValidator;
	
	import bridge.abstract.AbstractPool;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractState;
	import bridge.abstract.IAbstractTexture;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.IAbstractVideo;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.BridgeGraphics;
	import bridge.IEngine;
	
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.core.starling.ViewportMode;
	import citrus.datastructures.PoolObject;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	import org.osflash.signals.Signal;
	
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Stage;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import starlingEngine.elements.EngineImage;
	import starlingEngine.elements.EngineLabel;
	import starlingEngine.elements.EngineLayer;
	import starlingEngine.elements.EngineLayerLayoutElementVo;
	import starlingEngine.elements.EngineLayerVO;
	import starlingEngine.elements.EngineMovie;
	import starlingEngine.elements.EngineSprite;
	import starlingEngine.elements.EngineState;
	import starlingEngine.elements.EngineTextField;
	import starlingEngine.elements.EngineTexture;
	import starlingEngine.elements.EngineVideo;
	import starlingEngine.events.EngineEvent;
	import starlingEngine.transitions.EngineLayerTransitionIn;
	import starlingEngine.transitions.EngineLayerTransitionOut;
	import starlingEngine.ui.EngineButton;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class StarlingEngine extends StarlingCitrusEngine implements IEngine
	{		
		
		public static const ENGINE_LAYER_PROPERTIES:String = "layerProperties";
		public static const ENGINE_IMAGE:String = "image";
		public static const ENGINE_MOVIE_CLIP:String = "movie";
		public static const ENGINE_FLV:String = "flv";
		public static const ENGINE_BUTTON:String = "button";
		public static const ENGINE_TOGGLE_BUTTON:String = "toggleButton";
		public static const ENGINE_SLIDER:String = "slider";
		public static const ENGINE_TEXT_FIELD:String = "textField";
		
		private var _initCompleteCallback:Function;
		private var _engineStage:Stage;
		private var _layers:Dictionary = new Dictionary(true);
		private var _space:Space;
		private var _currentState:IAbstractState;
		private var _assetsManager:starling.utils.AssetManager;
		private var _signalsHub:SignalsHub;
		private var _debugMode:Boolean = false;
		
		private var _spritesPool:AbstractPool;
		private var _imagesPool:AbstractPool;
		private var _movieClipsPool:AbstractPool;
		private var _buttonsPool:AbstractPool;
		
		/**
		 * 
		 * @param	initCompleteCallback
		 * @param	baseWidth
		 * @param	baseHeight
		 * @param	viewportMode
		 */
		public function StarlingEngine(initCompleteCallback:Function, baseWidth:int = 800, baseHeight:int = 600, viewportMode:String = ViewportMode.FULLSCREEN, debugMode:Boolean = false):void 
		{
			_baseWidth = baseWidth;
			_baseHeight = baseHeight;
			_viewportMode = viewportMode;
			_assetSizes = [1, 1.5, 2];
			_debugMode = debugMode;
			_initCompleteCallback = initCompleteCallback;
		}
		
		/**
		 * 
		 * @param	assetsManager
		 */
		public function injectAssetsManager(assetsManager:Object):void
		{
			_assetsManager = assetsManager as starling.utils.AssetManager;
		}
		
		/**
		 * 
		 * @param	signalsHub
		 */
		public function injectSignalsHub(signalsHub:Object):void
		{
			_signalsHub = signalsHub as SignalsHub;
			initSignals();
		}
		
		/**
		 * 
		 * @param	e
		 */
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage(e);
			initEngine(_debugMode);
		}		
		
		/**
		 * 
		 */
		public function initEngine(debugMode:Boolean = false):void
		{
			Starling.handleLostContext = true;
			setUpStarling(debugMode);
		}
		
		/**
		 * 
		 */
		override public function handleStarlingReady():void
		{ 
			//creates a new pool for sprites
			_spritesPool = new AbstractPool("sprites", EngineSprite, 10);
			
			//creates a new pool for images
			_imagesPool = new AbstractPool("images", EngineImage, 20, Texture.fromColor(2, 2, 0x000000));
			
			//creates a new pool for movieclips
			var defaultVector:Vector.<Texture> = new Vector.<Texture>;
			defaultVector.push(Texture.fromColor(2, 2, 0x000000));
			_movieClipsPool = new AbstractPool("movieClips", EngineMovie, 50, defaultVector)
			
			//creates a new pool for buttons
			_buttonsPool = new AbstractPool("buttons", EngineButton, 20);
			
			_currentState = requestState();
			state = _currentState as IState;
			
			_initCompleteCallback.call();
			_engineStage = starling.stage;
			
			_signalsHub.dispatchSignal(Signals.STARLING_READY, "", "");
			
			configureConsole();
		}
		
		private function configureConsole():void
		{
			console.addCommand("output", output)
		}
		
		private function output(input:String):void
		{
			var tf:IAbstractTextField = requestTextField(500, 500, input, "Verdana", 200, 0xffffff);
			_currentState.addNewChild(tf);
		}
		
		/**
		 * 
		 */
		public function initSignals():void
		{
			(_signalsHub as SignalsHub).addSignal(Signals.STARLING_READY, new Signal(), new Vector.<Function>);
			
			(_signalsHub as SignalsHub).addSignal(Signals.CHANGE_GRAPHICS_STATE, new Signal(), new Vector.<Function>);
			
			(_signalsHub as SignalsHub).addSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, new Signal(), new Vector.<Function>);
			(_signalsHub as SignalsHub).addSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, new Signal(), new Vector.<Function>);
			
			(_signalsHub as SignalsHub).addSignal(Signals.GENERIC_BUTTON_PRESSED, new Signal(), new Vector.<Function>);
			(_signalsHub as SignalsHub).addSignal(Signals.MOVIE_CLIP_ENDED, new Signal(), new Vector.<Function>);
			
			(_signalsHub as SignalsHub).addSignal(Signals.DISPLAY_OBJECT_TOUCHED, new Signal(), new Vector.<Function>);
			
			(_signalsHub as SignalsHub).addSignal(Signals.GENERIC_SLIDER_CHANGE, new Signal(), new Vector.<Function>);
			(_signalsHub as SignalsHub).addSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, new Signal(), new Vector.<Function>);
		}
		
		/**
		 * 
		 */
		private function initNape():void
		{
			//_space = new Space(new Vec2(0, 5));
			//addEventListener(Event.ENTER_FRAME, loop);
		}
		
		/**
		 * 
		 * @param	e
		 */
		public function loop(e:Event):void
		{
			_space.step(1 / 60);
		}
		
		/**
		 * 
		 * @param	newJuggler
		 */
		public function addJuggler(newJuggler:Object):void
		{
			starling.juggler.add(newJuggler as Juggler);
		}
		
		/**
		 * 
		 * @param	juggler
		 */
		public function removeJuggler(juggler:Object):void
		{
			starling.juggler.remove(juggler as Juggler);
		}
		
		/**
		 * @TODO this function still return null for some reason
		 * @param	name
		 * @return IAbstractTexture
		 * @see bridge.abstract.IAbstractTexture
		 */
		public function requestTexture(name:String ):IAbstractTexture
		{
			var t:IAbstractTexture = new EngineTexture() as IAbstractTexture;
			t = _assetsManager.getTexture(name) as IAbstractTexture;
			trace(t);
			return t as IAbstractTexture;
		}
		
		/**
		 * 
		 * @param	texture
		 * @return IAbstractImage
		 * @see bridge.abstract.IAbstractImage
		 */
		public function requestImage(texture:Object, name:String = ""):IAbstractImage
		{
			var i:IAbstractImage = _imagesPool.getNewObject() as IAbstractImage;
			i.newTexture = texture;
			i.readjustSize();
			
			if (name != "")
			{
				i.name = name;
			}
			
			return i;
		}
		
		/**
		 * 
		 * @param	scrollImage
		 * @param	width
		 * @param	height
		 * @param	centerX
		 * @param	centerY
		 * @param	useBaseTexture
		 * @return
		 */
		public function requestBlitMask(scrollImage:IAbstractImage, width:Number, height:Number, centerX:Number, centerY:Number, useBaseTexture:Boolean  = false):IAbstractBlitMask
		{
			var scroller:IAbstractBlitMask = new EngineBlitMask ( width, height, useBaseTexture );
			var scrollTile:IAbstractScrollTile;
			scrollTile = scroller.addLayerOnTop (  new EngineScrollTile ( scrollImage) );
			scroller.tilesPivotX = centerX;
			scroller.tilesPivotY = centerY;
			
			return scroller as IAbstractBlitMask;
		}
		
		/**
		 * 
		 * @param	bitmapData
		 * @return
		 */
		public function requestImageFromBitmapData(bitmapData:BitmapData):IAbstractImage
		{
			var i:IAbstractImage = _imagesPool.getNewObject() as IAbstractImage;
			i.newTexture = Texture.fromBitmapData(bitmapData);
			i.readjustSize();
			
			return i;
		}
		
		/**
		 * @param	textures
		 * @param	fps
		 * @return IAbstractMovie
		 * @see bridge.abstract.IAbstractMovie
		 */
		public function requestMovie(prefix:String, fps:uint = 24):IAbstractMovie
		{
			var textures:Vector.<Texture> =  _assetsManager.getTextures(prefix);
			var m:IAbstractMovie = new EngineMovie(textures, fps) as IAbstractMovie;

			var n:EngineMovie = _movieClipsPool.getNewObject() as EngineMovie;
			
			while (n.numFrames > 1)
			{
				n.removeFrameAt(0);
			}
			
			for (var i:uint = 0; i < textures.length; i++ )
			{
				(n as MovieClip).addFrame(textures[i] as Texture);
			}
			
			n.name = prefix;
			n.currentFrame = 0;
			
			return n;
		}
		
		/**
		 * 
		 * @return IAbstractSprite
		 * @see bridge.abstract.IAbstractSprite
		 */
		public function requestSprite(name:String = ""):IAbstractSprite
		{
			var s:IAbstractSprite = _spritesPool.getNewObject() as IAbstractSprite;
			if (name != "")
			{
				s.name = name;
			}
			return s;
		}
		
		/**
		 * 
		 * @return IAbstractButton
		 * @see bridge.abstract.IAbstractButton
		 */
		public function requestButton(name:String = ""):IAbstractButton
		{
			var b:IAbstractButton = _buttonsPool.getNewObject() as IAbstractButton;
			if (name != "")
			{
				b.name = name;
			}
			return b;
		}
		
		/**
		 * TODO build pool?
		 * @param	name
		 * @return
		 */
		public function requestToggleButton(name:String = ""):IAbstractToggle
		{
			var b:IAbstractToggle = new EngineToggleButton();
			if (name != "")
			{
				b.name = name;
			}
			return b;
		}
		
		public function requestSlider( 
														thumbUpSkin:IAbstractImage,
														thumbDownSkin:IAbstractImage, 
														trackUpSkin:IAbstractImage, 
														trackDownSkin:IAbstractImage,
														backgroundSkin:IAbstractImage,
														label:IAbstractLabel,
														name:String = ""):IAbstractSlider
		{
			var s:IAbstractSlider = new EngineSlider(thumbUpSkin, thumbDownSkin, trackUpSkin, trackDownSkin, backgroundSkin, label)
			{
				if (name != "")
				{
					s.name = name
				}
			}
			
			return s;
		}
		
		/**
		 * 
		 * @return IAbstractState
		 */
		public function requestState():IAbstractState
		{
			return new EngineState() as IAbstractState;
		}
		
		/**
		 * 
		 * @param	name
		 * @param	depth
		 * @param	layout
		 * @param	addedToStage
		 * @return
		 */
		public function requestLayer (name:String, depth:Number, layout:XML, addedToStage:Boolean) : IAbstractLayer
		{
			return new EngineLayer(name, depth, layout, addedToStage) as IAbstractLayer;
		}
		
		/**
		 * 
		 * @return IAbstractTextField
		 */
		public function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false):IAbstractTextField
		{
			while (text.indexOf("\\n") != -1)
			{
				text = text.replace("\\n", "\n");
			}
			
			var rows:int = 1;
			rows += (text.match(new RegExp("\n", "g")).length);
			
			var finalH:Number = height;
			var dynamicH:Number =  fontSize * rows;
			
			if (dynamicH <= height)
			{
				finalH = dynamicH;
			}
			
			var t:IAbstractTextField = new EngineTextField(width, finalH, text, fontName, fontSize, color, bold) as IAbstractTextField;
			t.batchable = true;
			t.autoScale = true;
			
			return t;
		}
		
		/**
		 * 
		 * @param	text
		 * @return IAbstractLabel
		 * @see bridge.abstract.ui.IAbstractLabel
		 */
		public function requestLabelFromTextfield(text:IAbstractTextField, name:String = ""):IAbstractLabel
		{	
			var label:IAbstractLabel = new EngineLabel(text);
			label.name = name;
			label.touchable = false;
			
			return label;
		}
		
		/**
		 * 
		 * @param	maskedObject
		 * @param	mask
		 * @return
		 */
		public function requestMask(maskedObject:IAbstractDisplayObject, mask:IAbstractDisplayObject, isAnimated:Boolean=false):IAbstractMask
		{
			var mM:IAbstractMask = new EngineMask();
			
			var myCustomDisplayObject:IAbstractSprite = requestSprite();
			var myCustomMaskDisplayObject:IAbstractSprite = requestSprite();
			
			myCustomDisplayObject.name = maskedObject.name;
			myCustomMaskDisplayObject.name = maskedObject.name + "mask";
			
			myCustomDisplayObject.addNewChild(maskedObject);
			myCustomMaskDisplayObject.addNewChild(mask);
			 
			mM.addNewChild(myCustomDisplayObject);
			mM.newMask = myCustomMaskDisplayObject;
			
			mM.touchable = false;
			
			return (mM as IAbstractMask);
		}
		
		/**
		 * 
		 * @return IAbstractEngineLayerVO
		 */
		public function requestLayersVO():IAbstractEngineLayerVO
		{
			return new EngineLayerVO();
		}
		
		/**
		 * 
		 * @param	textureClass
		 * @param	xml
		 */
		public function registerBitmapFont(textureBitmap:Bitmap, xml:XML, fontName:String = ""):String
		{
			var fontTexture:Texture = Texture.fromBitmap(textureBitmap);
			var fontXML:XML = xml;
			var bitmapFont:BitmapFont = new BitmapFont(fontTexture, fontXML);
			var fontName_:String;
			
			if (fontName != "")
			{
				fontName_ = TextField.registerBitmapFont(bitmapFont, fontName);
			}
			else
			{
				fontName_ = TextField.registerBitmapFont(bitmapFont);
			}
			
			return fontName_
		}
		
		/**
		 * 
		 * @return IAbstractLayerTransitionIn
		 */
		public function requestLayerTransitionIN():IAbstractLayerTransitionIn
		{
			var inTransition:IAbstractLayerTransitionIn = new EngineLayerTransitionIn();
			return inTransition;
		}
		
		/**
		 * 
		 * @return IAbstractLayerTransitionOut
		 */
		public function requestLayerTransitionOUT():IAbstractLayerTransitionOut
		{
			var outTransition:IAbstractLayerTransitionOut = new EngineLayerTransitionOut();
			return outTransition;
		}
		
		/**
		 * 
		 * @return IAbstractVideo
		 */
		public function requestVideo():IAbstractVideo
		{
			var video:IAbstractVideo = new EngineVideo();
			return video
		}
		
		/**
		 * 
		 * @param	newState
		 * @param	transitionEffect
		 */
		public function tranzitionToState(newState:IAbstractState, transitionEffect:IAbstractStateTransition = null):void
		{
			if (transitionEffect != null)
			{
				transitionEffect.injectOnTransitionComplete(tranzitionToStateComplete);
				futureState = newState as IState;
				transitionEffect.doTransition(state as IAbstractDisplayObject, futureState as IAbstractDisplayObject);
			}
			else
			{
				_currentState = newState as EngineState;
				state = _currentState as IState;
			}
		}
		
		/**
		 * 
		 * @param	o1
		 * @param	o2
		 */
		private function tranzitionToStateComplete(o1:Object = null, o2:Object = null):void
		{
			_currentState = futureState as EngineState;
			state = _currentState as IState;
		}
		
		/**
		 * 
		 */
		public function get juggler():Object
		{
			return starling.juggler;
		}
		
		/**
		 * 
		 */
		public function get engineStage():Object
		{
			return _engineStage;
		}
		
		/**
		 * 
		 * @param	inputLayers
		 * @param	inTransition
		 * @param	outTransition
		 */
		public function initLayers(container:IAbstractDisplayObjectContainer, inputLayers:Dictionary, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		{
			var orderedLayers:Vector.<EngineLayer> = new Vector.<EngineLayer>();
			
			for (var k:Object in inputLayers) 
			{
				var child:EngineLayer = inputLayers[k] as EngineLayer;
				if (child.addToStage)
				{
					container.layers[child.name] = child;
					orderedLayers.push(child);
				}
			}
			
			orderedLayers.sort(sortDepths);
			
			for (var j:uint = 0; j < orderedLayers.length; j++ )
			{
				if (container.getChildByNameStr(orderedLayers[j].name) == null)
				{
					if (orderedLayers[j].addToStage)
					{
						container.addNewChildAt(orderedLayers[j], j);
						drawLayerLayout(orderedLayers[j]);
						
						if (inTransition != null)
						{
							inTransition.injectOnTransitionComplete(tranzitionToLayerInComplete);
							inTransition.doTransition(orderedLayers[j] as EngineLayer, null);
						}
						else
						{
							tranzitionToLayerInComplete(orderedLayers[j], null);
						}
					}
				}
			}
		}
		
		/**
		 * 
		 * @param	a
		 * @param	b
		 * @return int
		 */
		private function sortDepths(a:Object, b:Object):int
		{
			var depth1:uint = (a as Object).layerDepth;
			var depth2:uint = (b as Object).layerDepth;
			
			if (depth1 < depth2) 
			{ 
				return -1; 
			} 
			else if (depth1 > depth2) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
		}
		
		/**
		 * @param	inLayers
		 * @param	outLayers
		 */
		public function updateLayers(container:IAbstractDisplayObjectContainer, inLayers:Vector.<IAbstractLayer> = null, outLayers:Vector.<IAbstractLayer> = null, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null ):void
		{
			if (inLayers != null)
			{
				for (var i:uint = 0; i < inLayers.length; i++ )
				{
					insertLayerInDictionary(inLayers[i], container.layers);
				}
			}
			
			if (outLayers != null)
			{
				for (var j:uint = 0; j < outLayers.length; j++ )
				{
					removeLayerFromDictionary(outLayers[j], container.layers);
					
					if (outTransition != null)
					{
						outTransition.injectOnTransitionComplete(tranzitionToLayerOutComplete);
						outTransition.doTransition(outLayers[j] as EngineLayer, null);
					}
					else
					{
						tranzitionToLayerOutComplete(outLayers[j], null);
					}
				}
			}
			
			initLayers(container, container.layers, inTransition);
		}
		
		/**
		 * 
		 * @param	target1
		 * @param	target2
		 */
		public function tranzitionToLayerInComplete(target1:Object = null, target2:Object = null, params:Object = null):void
		{
			if(target1)
			{
				var o:Object = {
					type:"LayerTransitionInComplete",
					caller:target1,
					params:params
				}
				
				_signalsHub.dispatchSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, Signals.LAYER_TRANSITION_IN_COMPLETE, o);
			}
		}
		
		/**
		 * 
		 * @param	target1
		 * @param	target2
		 */
		public function tranzitionToLayerOutComplete(target1:Object = null, target2:Object = null, params:Object = null):void
		{
			if (target1)
			{
				_currentState.removeChildAndDispose(target1 as EngineLayer);
				
				(target1 as EngineLayer).destroyAll();
					
				var o:Object = {
					type:"LayerTransitionOutComplete",
					caller:target1,
					params:params
				}
				
				_signalsHub.dispatchSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, Signals.LAYER_TRANSITION_OUT_COMPLETE, o);
			}
		}
		
		/**
		 * 
		 * @param	layer
		 */
		private function insertLayerInDictionary(layer:IAbstractLayer, elementsDictionary:Dictionary):void
		{
			var alreadyExisting:Boolean = false;
			
			for (var k:Object in elementsDictionary) 
			{
				var child:IAbstractLayer = elementsDictionary[k] as IAbstractLayer;
				if (child.layerName == layer.layerName)
				{
					alreadyExisting = true;
				}
			}
			
			if (!alreadyExisting)
			{
				elementsDictionary[layer.layerName] = layer;
			}
		}
		
		/**
		 * 
		 * @param	layer
		 */
		private function removeLayerFromDictionary(layer:IAbstractLayer, dict:Dictionary):void
		{
			for (var k:Object in dict) 
			{
				var child:IAbstractLayer = dict[k] as IAbstractLayer;
				if (child.layerName == layer.layerName)
				{
					delete dict[layer.layerName];
				}
			}
		}
		
		/**
		 * 
		 * @param	layer
		 */
		public function drawLayerLayout(layer:IAbstractLayer):void
		{
			if (layer.redrawEnabled)
			{
				var layoutDict:Dictionary = layer.layout;
				var layerElements:Vector.<EngineLayerLayoutElementVo> = new Vector.<EngineLayerLayoutElementVo>();
				
				if (!layer.addToStage)
				{
					var orderedLayers:Vector.<EngineLayer> = new Vector.<EngineLayer>();
					layer.addToStage = true;
				}
				
				for (var key:String in layoutDict)
				{
					layerElements.push(layoutDict[key] as EngineLayerLayoutElementVo);
				}
				
				layerElements.sort(sortDepths);
				
				if (layerElements.length > 0)
				{
					autoAddItems(layer, layerElements);
				}
			}	
		}
		
		/**
		 * 
		 * @param	layer
		 * @param	sortedElements
		 */
		private function autoAddItems(layer:IAbstractLayer, sortedElements:Vector.<EngineLayerLayoutElementVo>): void
		{
			for (var i:uint = 0; i < sortedElements.length; i++ )
			{
				switch (sortedElements[i].type) 
				{
					case ENGINE_LAYER_PROPERTIES:
						layer.x = sortedElements[i].layerX;
						layer.y = sortedElements[i].layerY;
						break;
					
					case ENGINE_IMAGE:
						layer.addNewChildAt(LayoutImageValidator.validate(this, _assetsManager, sortedElements[i]), i);
						break;
						
					case ENGINE_BUTTON:
						var btn:IAbstractButton = LayoutButtonValidator.validate(this, _assetsManager, sortedElements[i]);
						(btn as IAbstractButton).addEventListener(EngineEvent.TRIGGERED, button_triggeredHandler);
						layer.addNewChildAt(btn, i);
						break;
						
					case ENGINE_TOGGLE_BUTTON:
						var toggleBtn:IAbstractToggle = LayoutToggleButtonValidator.validate(this, _assetsManager, sortedElements[i]);
						(toggleBtn as IAbstractToggle).addEventListener(EngineEvent.TRIGGERED, toggle_button_triggeredHandler);
						layer.addNewChildAt(toggleBtn, i);
						break;	
						
					case ENGINE_SLIDER:
						var slider:IAbstractSlider = LayoutSliderValidator.validate(this, _assetsManager, sortedElements[i]);
						slider.anchor = slider_component_changed;
						layer.addNewChildAt(slider, i);
						break;
						
					case ENGINE_MOVIE_CLIP:
						var mc:IAbstractMovie = LayoutMovieClipValidator.validate(this, _assetsManager, sortedElements[i]);
						mc.addEventListener(EngineEvent.COMPLETE, movieClip_Completed);
						layer.addNewChildAt(mc, i);
						juggler.add(mc as IAnimatable);
						break;
						
					case ENGINE_TEXT_FIELD:
							layer.addNewChildAt(LayoutTextFieldValidator.validate(this, _assetsManager, sortedElements[i]), i);
						break
						
					case ENGINE_FLV:
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function movieClip_Completed(e:Object):void
		{
			_signalsHub.dispatchSignal(Signals.MOVIE_CLIP_ENDED, (e.currentTarget as IAbstractMovie).name, e);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function button_triggeredHandler(e:Object):void
		{
			_signalsHub.dispatchSignal(Signals.GENERIC_BUTTON_PRESSED, (e.currentTarget as IAbstractButton).idName, e);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function slider_component_changed(e:Object):void
		{
			_signalsHub.dispatchSignal(Signals.GENERIC_SLIDER_CHANGE, e["name"], e);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function toggle_button_triggeredHandler(e:Object):void
		{
			_signalsHub.dispatchSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, (e.currentTarget as IAbstractButton).idName, e);
		}
		
		/**
		 * 
		 */
		public function get layers():Dictionary
		{
			return _layers
		}
		
		/**
		 * 
		 */
		public function set layers(val:Dictionary):void
		{
			_layers = val;
		}
		
		/**
		 * 
		 * @param	layer1
		 * @param	layer2
		 */
		public function swapLayers(layer1:IAbstractLayer, layer2:IAbstractLayer):void
		{
			_currentState.swapChildrenF(layer1 as IAbstractLayer, layer2 as IAbstractLayer);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	atlasXml
		 * @param	atlasPng
		 */
		 public function addTextureAtlas(name:String, atlasXml:XML, atlasPng:Class):void
		 {
		   var atlasBitmapData:BitmapData = new atlasPng();
		   var atlasBitmap:Bitmap = new Bitmap(atlasBitmapData);
		   var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(atlasBitmap), atlasXml);
		   _assetsManager.addTextureAtlas(name, atlas);
		 }
		 
		 /**
		 * 
		 * @return
		 */
		 public function requestDropShadowFilter():IAbstractDropShadowFilter
		 {
			  return new DropShadowFilterVO();
		 }
		
		/**
		 * 
		 * @return
		 */
		 public function requestGlowFilter():IAbstractGlowFilter
		 {
			  return new GlowFilterVO();
		 }
		
		/**
		 * 
		 * @return
		 */
		 public function requestBlurFilter():IAbstractBlurFilter
		 {
			 return new BlurFilterVO();
		 }
		 
		 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addDropShadowFilter(target:IAbstractDisplayObject, vo:IAbstractDropShadowFilter):void
		 {
			 (target as DisplayObject).filter = BlurFilter.createDropShadow(vo.distance, vo.angle, vo.color, vo.alpha, vo.blur, vo.resolution);
		 }
		 
		 	 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addGlowFilter(target:IAbstractDisplayObject, vo:IAbstractGlowFilter):void
		 {
			 (target as DisplayObject).filter = BlurFilter.createGlow(vo.color, vo.alpha, vo.blur, vo.resolution);
		 }
		 
		 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addBlurFilter(target:IAbstractDisplayObject, vo:IAbstractBlurFilter):void
		 {
			  (target as DisplayObject).filter = new BlurFilter(vo.blurX, vo.blurY, vo.resolution);
		 }
		 
		 public function get currentContainer():IAbstractState
		 {
			 return _currentState;
		 }
		
		/**
		 * 
		 */
		public function cleanUp():void
		{
			_initCompleteCallback = null;
			_engineStage = null;
			
			for (var k:String in _layers)
			{
				_layers[k] = null
			}
			
			_layers = null;
			_space = null;
			_currentState = null; 
			_assetsManager = null;
			_signalsHub = null;
			
			state.destroy();
			if (futureState != null)
			{
				futureState.destroy();
			}
			
			super.destroy();
			
			trace(this + " -> destroyed");
		}
		
	}
	
}