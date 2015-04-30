package starlingEngine
{
import bridge.abstract.console.IConsoleCommands;
import bridge.BridgeGraphics;
import bridge.IEngine;
import bridge.abstract.AbstractPool;
import bridge.abstract.IAbstractBlitMask;
import bridge.abstract.IAbstractDisplayObject;
import bridge.abstract.IAbstractDisplayObjectContainer;
import bridge.abstract.IAbstractEngineLayerVO;
import bridge.abstract.IAbstractGraphics;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractLayer;
import bridge.abstract.IAbstractMask;
import bridge.abstract.IAbstractMovie;
import bridge.abstract.IAbstractScrollTile;
import bridge.abstract.IAbstractSprite;
import bridge.abstract.IAbstractState;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.IAbstractTexture;
import bridge.abstract.IAbstractVideo;
import bridge.abstract.effects.IAbstractParticleSystem;
import bridge.abstract.filters.IAbstractBlurFilter;
import bridge.abstract.filters.IAbstractDropShadowFilter;
import bridge.abstract.filters.IAbstractGlowFilter;
import bridge.abstract.filters.IAbstractReferencedFilter;
import bridge.abstract.transitions.IAbstractLayerTransitionIn;
import bridge.abstract.transitions.IAbstractLayerTransitionOut;
import bridge.abstract.transitions.IAbstractStateTransition;
import bridge.abstract.ui.IAbstractButton;
import bridge.abstract.ui.IAbstractComboBox;
import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
import bridge.abstract.ui.IAbstractInputText;
import bridge.abstract.ui.IAbstractLabel;
import bridge.abstract.ui.IAbstractSlider;
import bridge.abstract.ui.IAbstractToggle;
import consoleCommand.ConsoleCommands;
import consoleCommand.Output;

import flash.display.StageQuality;

import starling.filters.ColorMatrixFilter;
import starling.filters.DisplacementMapFilter;
import starling.filters.FragmentFilterMode;
import starling.textures.SubTexture;

import starlingEngine.signals.Signals;

import citrus.core.IState;
import citrus.core.starling.StarlingCitrusEngine;
import citrus.core.starling.ViewportMode;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display3D.Context3D;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;


import org.osflash.signals.Signal;

import signals.ISignalsHub;

import signals.ISignalsHub;

import starling.animation.IAnimatable;
import starling.animation.Juggler;
import starling.core.RenderSupport;
import starling.core.Starling;
import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.FFParticleSystem;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Stage;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.filters.BlurFilter;
import starling.filters.FragmentFilter;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

import starlingEngine.effects.EngineAdvancedParticleSystem;
import starlingEngine.effects.EngineParticleSystem;
import starlingEngine.elements.EngineBlitMask;
import starlingEngine.elements.EngineGraphics;
import starlingEngine.elements.EngineImage;
import starlingEngine.elements.EngineLabel;
import starlingEngine.elements.EngineLayer;
import starlingEngine.elements.EngineLayerLayoutElementVo;
import starlingEngine.elements.EngineLayerVO;
import starlingEngine.elements.EngineMask;
import starlingEngine.elements.EngineMovie;
import starlingEngine.elements.EngineScrollTile;
import starlingEngine.elements.EngineSprite;
import starlingEngine.elements.EngineState;
import starlingEngine.elements.EngineTextField;
import starlingEngine.elements.EngineTexture;
import starlingEngine.elements.EngineVideo;
import starlingEngine.events.EngineEvent;
import starlingEngine.events.GESignalEvent;
import starlingEngine.filters.BlurFilterVO;
import starlingEngine.filters.DropShadowFilterVO;
import starlingEngine.filters.EngineReferencedFilterAbstract;
import starlingEngine.filters.GlowFilterVO;
import starlingEngine.filters.NewsprintFilter;
import starlingEngine.filters.PixelateFilter;
import starlingEngine.transitions.EngineLayerTransitionIn;
import starlingEngine.transitions.EngineLayerTransitionOut;
import starlingEngine.ui.EngineButton;
import starlingEngine.ui.EngineComboBox;
import starlingEngine.ui.EngineInputText;
import starlingEngine.ui.EngineSlider;
import starlingEngine.ui.EngineToggleButton;
import starlingEngine.validators.LayoutButtonValidator;
import starlingEngine.validators.LayoutImageValidator;
import starlingEngine.validators.LayoutMovieClipValidator;
import starlingEngine.validators.LayoutSliderValidator;
import starlingEngine.validators.LayoutTextFieldValidator;
import starlingEngine.validators.LayoutToggleButtonValidator;

import statsDebug.StatsDebug;

import utils.ATFSupport.TextureFromATF;

import utils.ClassHelper;

import utils.delayedFunctionCall;

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

		private var _is3D:Boolean = false;
		
		private var _initCompleteCallback:Function;
		private var _engineStage:Stage;
		private var _layers:Dictionary = new Dictionary(true);
		//private var _space:Space;
		private var _currentState:IAbstractState;
		private var _assetsManager:AssetManager;
		private var _signalsHub:ISignalsHub;
		private var _debugMode:Boolean = false;
		
		private var _spritesPool:AbstractPool;
		private var _imagesPool:AbstractPool;
		private var _movieClipsPool:AbstractPool;
		private var _buttonsPool:AbstractPool;
		private var _masksPool:AbstractPool;
        private var _textsPool:AbstractPool;
		private var _fragmentStandardFilterPool:AbstractPool;

		private var _floatingTexturesDictionary:Dictionary = new Dictionary(true);
		
		private var  defaultFramesVector:Vector.<Texture> = new Vector.<Texture>();
		private var _bitmapDataFallBack:BitmapData = new BitmapData(100, 100, true, 0x000000);
		private var _textureFallBack:Texture;
		
		private var _flareBridge:FlareBridge;
		
		private var _consoleCommands:ConsoleCommands;
        private var _statsDebug:StatsDebug;
        private var _texturesUsed:uint = 0;

		private var _cmf:ColorMatrixFilter;
		private var _dmf:DisplacementMapFilter;
		private var _fmM:FragmentFilterMode;
		/**
		 * 
		 * @param	initCompleteCallback
		 * @param	baseWidth
		 * @param	baseHeight
		 * @param	viewportMode
		 */
		public function StarlingEngine(initCompleteCallback:Function, baseWidth:int = 800, baseHeight:int = 600, viewportMode:String = ViewportMode.FULLSCREEN, debugMode:Boolean = false):void 
		{
            stage.quality = StageQuality.LOW;

			_baseWidth = baseWidth;
			_baseHeight = baseHeight;
			_viewportMode = viewportMode;
			_assetSizes = [1, 1.5, 2];
			_debugMode = debugMode;
			_initCompleteCallback = initCompleteCallback;
		}

        /**
         *
         * @param	e
         */
        override protected function handleAddedToStage(e:Event):void
        {
            super.handleAddedToStage(e);
            Starling.handleLostContext = true;
			
            //make the decision if the init should go through Flare of Starling
            if (is3D)
            {
                initFlare();
            }
            else
            {
                initEngine();
            }
        }

        /**
         *
         */
        override public function handleStarlingReady():void
        {
            //initial congig of the console (activate with tab)
			configureConsole();
			
            Starling.current.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onContext3DEventCreate);
            Starling.current.addEventListener(starling.events.Event.TEXTURES_RESTORED, onTexturesRestored);

            //small workaround to avoid redraw
            _starling.root.alpha = .999;

            _starling.supportHighResolutions = true;

            //reusable texture for empty textures or missing assets without causing a fail
            _textureFallBack = Texture.fromBitmapData(_bitmapDataFallBack);

            //creates a new pool for sprites
            _spritesPool = new AbstractPool("sprites", EngineSprite, 500);

            //creates a new pool for images
            _imagesPool = new AbstractPool("images", EngineImage, 1000, _textureFallBack);

            //creates a new pool for movieclips
            //a movie clip must have frames. creating a default frames vector with one 2x2 black texture
            defaultFramesVector.push(Texture.fromColor(2, 2, 0x000000));
            _movieClipsPool = new AbstractPool("movieClips", EngineMovie, 100, defaultFramesVector);

            //creates a new pool for buttons
            _buttonsPool = new AbstractPool("buttons", EngineButton, 20);

            //creates a new pool for FragmentFilters
            _fragmentStandardFilterPool = new AbstractPool("fragmentFilters", BlurFilter, 30);

            //creates a new pool for Maks
            _masksPool = new AbstractPool("maskPool", EngineMask, 50);

            //creates a new pool for textFields
            _textsPool = new AbstractPool("textsPool", EngineTextField, 100, 10,10,"");

            //assigns initial state
            _currentState = requestState();
            state = _currentState as IState;

            //alert bridge that init is complete
            _initCompleteCallback.call();

            //assigns initial stage
            _engineStage = starling.stage;

            //dispatch
            if (is3D)
            {
                _signalsHub.dispatchSignal(Signals.STARLING_READY, "", { "3dScene":_flareBridge.scene } );
            }
            else
            {
                _signalsHub.dispatchSignal(Signals.STARLING_READY, "", { } );
            }

            //mouse wheel listener
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0 , true);

            //deactivate event
            stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			
			//default verbose
			_signalsHub.verbose = Output.verbose;
        }


         /**
		 * Receives the asset manager from outside
		 * @param	assetsManager
		 */
		public function injectAssetsManager(assetsManager:Object):void
		{
			_assetsManager = assetsManager as AssetManager;
			(_assetsManager  as AssetManager).keepAtlasXmls = true;
		}
		
		/**
		 * Receives the signals manager from outside
		 * @param	signalsHub
		 */
		public function injectSignalsHub(signalsHub:Object):void
		{
			_signalsHub = signalsHub as ISignalsHub;
			initSignals();
		}
		
		/**
		 * 
		 */
		public function initEngine(sharedContext:Context3D = null):void
		{
			setUpStarling(_debugMode);
		}

        /**
         *
         */
        public function initSignals():void
        {
            (_signalsHub as ISignalsHub).addSignal(Signals.STARLING_READY, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.CONTEXT_3D_RESTORED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.REMOVE_AND_DISPOSE, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.CHANGE_GRAPHICS_STATE, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.MOUSE_WHEEL, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_BUTTON_PRESSED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_BUTTON_OVER, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_BUTTON_ENDED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_BUTTON_OUT, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.MOVIE_CLIP_ENDED, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.DISPLAY_OBJECT_TOUCHED, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_SLIDER_CHANGE, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.LIST_ITEM_TOUCHED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.LIST_ITEM_TOUCHED_INTERNAL, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.TEXT_INPUT_CHANGED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.TEXT_INPUT_FOCUS_IN, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.TEXT_INPUT_FOCUS_OUT, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.PARTICLE_SYSTEM_COMPLETED, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addSignal(Signals.FLV_MOVIE_ENDED, new Signal(), new Vector.<Function>);
            (_signalsHub as ISignalsHub).addSignal(Signals.FLV_MOVIE_STARTED, new Signal(), new Vector.<Function>);

            (_signalsHub as ISignalsHub).addListenerToSignal(Signals.REMOVE_AND_DISPOSE, tryRemove);
        }

        /**
         *
         * @param	obj
         */
        public function returnToPool(obj:Object):void
        {
            var rootClass:Class = ClassHelper.getClass(obj);
            var poolSucces:Boolean = false;
            var disposeSucces:Boolean = false;

            if (rootClass === EngineImage) {
                poolSucces = true;
                (obj as EngineImage).removeEventListeners();
                (obj as EngineImage).removeFromParent();
                if((obj as Quad).filter)
                {
                    returnToPool((obj as DisplayObject).filter);
                }
                if ((obj as EngineImage).texture != null) {
                    if (_floatingTexturesDictionary[(obj as EngineImage).name]) {
                        _assetsManager.removeTexture(_floatingTexturesDictionary[(obj as EngineImage).name]);
                        _floatingTexturesDictionary[(obj as EngineImage).name].dispose();
                        if ( _floatingTexturesDictionary[(obj as EngineImage).name] is SubTexture ) {
                            (_floatingTexturesDictionary[(obj as EngineImage).name] as SubTexture).parent.dispose();
                        }
                        _floatingTexturesDictionary[(obj as EngineImage).name] = null;
                        delete _floatingTexturesDictionary[(obj as EngineImage).name];
                    }

                    obj = new EngineImage(_textureFallBack);
                }
                _imagesPool.returnToPool(obj as EngineImage);
            } else if (rootClass === EngineMovie) {
                poolSucces = true;
                (obj as EngineMovie).removeEventListeners();
                (obj as EngineMovie).removeFromParent();
                if((obj as Quad).filter)
                {
                    returnToPool((obj as DisplayObject).filter);
                }
                obj = new EngineMovie(defaultFramesVector);
                _movieClipsPool.returnToPool(obj as EngineMovie);
            } else if (rootClass === EngineButton) {
                poolSucces = true;
                (obj as EngineButton).removeEventListeners();
                (obj as EngineButton).removeFromParent();
                if((obj as Quad).filter)
                {
                    returnToPool((obj as DisplayObject).filter);
                }
                obj = new EngineButton();
                _buttonsPool.returnToPool(obj as EngineButton);
            } else if (rootClass === EngineMask) {
                poolSucces = true;
                (obj as EngineMask).removeEventListeners();
                (obj as EngineMask).removeFromParent();

                _masksPool.returnToPool(obj as EngineMask);
                (obj as EngineMask).dispose();
            } else if (rootClass === BlurFilter) {
                poolSucces = true;
                _fragmentStandardFilterPool.returnToPool((obj as BlurFilter));
            } else if (rootClass === DisplayObjectContainer) {
                poolSucces = true;
                var container:DisplayObjectContainer = obj as DisplayObjectContainer;
                if((obj as Quad).filter)
                {
                    returnToPool((obj as DisplayObject).filter);
                }
                while (container.numChildren > 0) {
                    returnToPool(container.getChildAt(container.numChildren - 1));
                }
                if (obj as EngineSprite) {
                    (obj as EngineSprite).removeFromParent();
                    if((obj as Quad).filter)
                    {
                        returnToPool((obj as DisplayObject).filter);
                    }
                    obj = new EngineSprite();
                    _spritesPool.returnToPool(obj as EngineSprite);
                }
            } else if (rootClass === EngineLayer) {
                poolSucces = true;
                var layer:EngineLayer = obj as EngineLayer;
                if((obj as Quad).filter)
                {
                    returnToPool((obj as DisplayObject).filter);
                }
                while (layer.numChildren > 0) {
                    returnToPool(layer.getChildAt(layer.numChildren - 1));
                }
                if (obj as EngineLayer) {
                    (obj as EngineLayer).removeFromParent();
                }
                obj = new EngineSprite();
                _spritesPool.returnToPool(obj as EngineSprite);
            } else if (rootClass === EngineTextField) {
                poolSucces = true;
                _textsPool.returnToPool(obj);
            } else if (rootClass === EngineLabel) {
                poolSucces = false;
                disposeSucces = true;
                returnToPool((obj as EngineLabel).textField);
                (obj as EngineLabel).removeFromParent(true);
            } else if (rootClass === BlurFilterVO || rootClass === GlowFilterVO || rootClass === DropShadowFilterVO){
                poolSucces = true;
                _fragmentStandardFilterPool.returnToPool((obj as IAbstractReferencedFilter).reference);
            } else if (rootClass == EngineSprite){
                poolSucces = true;
                while ((obj as EngineSprite).numChildren > 0) {
                    returnToPool(obj.getChildAt(obj.numChildren - 1));
                }
                (obj as EngineSprite).x = (obj as EngineSprite).y = 0;
                (obj as EngineSprite).removeFromParent();
                _spritesPool.returnToPool(obj as EngineSprite);
            }

            if (!poolSucces)
            {
                Output.out("AssetsManager :: cannot return to pool object " + obj + " - pool not defined for this type " + " autodispose success: "+disposeSucces);
            }
            else
            {
                Output.out("AssetsManager :: recycled " + obj + " succesfuly");
            }
        }

        /**
         *
         * @param	e
         */
        public function loop(e:Event):void
        {
            //_space.step(1 / 60);
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
            return t as IAbstractTexture;
            updateCustomDebug();
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
			i.touchable = true;
            if (texture == null)
            {
                texture = _textureFallBack;
            }

            i.newTexture = texture;
            i.readjustSize();

            if (name != "")
            {
                i.name = name;
            }

            updateCustomDebug();

            return i;
        }

        /**
         *
         * @param	image
         * @param	color
         */
        public function colorizeImage(image:IAbstractImage, color:uint):void
        {
            (image as Image).color = color;
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

            updateCustomDebug();

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
            var storageName:String = "ImageFromBitmapData" + Math.random() * 999999;
			if (bitmapData.width != bitmapData.height)
			{
				_assetsManager.addTexture(storageName, Texture.fromBitmapData(bitmapData));
			}
			else
			{
				_assetsManager.addTexture(storageName, TextureFromATF.CreateTextureFromByteArray(TextureFromATF.CreateATFData(bitmapData)));
			}
            i.newTexture = _assetsManager.getTexture(storageName);
            i.readjustSize();
            i.name = storageName;

            _floatingTexturesDictionary[storageName] = _assetsManager.getTexture(storageName);

            updateCustomDebug();

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
            var n:IAbstractMovie = null;
            var textures:Vector.<Texture> =  _assetsManager.getTextures(prefix);

            if (textures.length != 0)
            {
                n = _movieClipsPool.getNewObject() as IAbstractMovie;
                n = cleanMovieclip(n, textures, fps);
                n.name = prefix;

                (juggler as Juggler).add(n as IAnimatable);

                n.addEventListener(EngineEvent.COMPLETE, movieClip_Completed);
                n.stop();
            }
            updateCustomDebug()
            return n;
        }

        /**
         *
         * @param	frames
         * @param	fps
         */
        public function requestMovieFromFrames(frames:Vector.<IAbstractImage>, fps:uint = 24):IAbstractMovie
        {
            var textures:Vector.<Texture> = new Vector.<Texture>();

            var i:uint = 0;
            for (i = 0; i < frames.length; i++ )
            {
                textures.push(frames[i].currentTexture as Texture);
                updateCustomDebug();
            }

            var n:IAbstractMovie = _movieClipsPool.getNewObject() as IAbstractMovie;
            n = cleanMovieclip(n, textures, fps);
            n.name = "McFromFrames";

            (juggler as Juggler).add(n as IAnimatable);

            n.addEventListener(EngineEvent.COMPLETE, movieClip_Completed);
            n.stop();

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
         * @return
         */
        public function requestGraphics(target:IAbstractDisplayObjectContainer):IAbstractGraphics
        {
            var g:IAbstractGraphics = new EngineGraphics(target);
            updateCustomDebug()
            return g;
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

            (b as IAbstractButton).addEventListener(EngineEvent.TRIGGERED, button_triggeredHandler);
            (b as IAbstractButton).addEventListener(TouchEvent.TOUCH, button_touchedHandler);

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

        public function requestComboBox(dataProvider:Vector.<IAbstractComboBoxItemRenderer>, width:Number, height:Number, backgroundImage:IAbstractImage, font:String):IAbstractComboBox
        {
            var cb:IAbstractComboBox = new EngineComboBox(_signalsHub, dataProvider, width, height, backgroundImage, font);
            return cb;
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
            var s:IAbstractSlider = new EngineSlider(thumbUpSkin, thumbDownSkin, trackUpSkin, trackDownSkin, backgroundSkin, label);
            {
                if (name != "")
                {
                    s.name = name
                }
            }

            s.anchor = slider_component_changed;

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
        public function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false, nativeFiltersArr:Array = null):IAbstractTextField
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

            var t:IAbstractTextField = _textsPool.getNewObject() as IAbstractTextField;
            t.width = width;
            t.height = height;
            t.text = text;
            t.fontName = fontName;
            t.fontSize = fontSize;
            t.color = color;
            t.bold = bold;
            if(nativeFiltersArr) {
                t.nativeFilters = nativeFiltersArr;
            }
            t.autoScale = true;
            updateCustomDebug()
            return t;
        }

        /**
         *
         * @param	width
         * @param	height
         * @param	text
         * @param	fontName
         * @param	fontSize
         * @param	color
         * @return
         */
        public function requestInputTextField(signalsManager:Object, width:int, height:int, text:String = "", fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0):IAbstractInputText
        {
            updateCustomDebug()
            return new EngineInputText(signalsManager, width, height, text, fontName, fontSize, color);
        }

        /**
         *
         * @param	text
         * @return IAbstractLabel
         * @see bridge.abstract.ui.IAbstractLabel
         */
        public function requestLabelFromTextfield(text:IAbstractTextField, name:String = ""):IAbstractLabel
        {
            (text as EngineTextField).fitFont();
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
            var mM:IAbstractMask = _masksPool.getNewObject() as EngineMask;
            //var mM:IAbstractMask = new EngineMask();

            mM.addNewChild(maskedObject);
            mM.newMask = mask;

            mM.touchable = false;

            return (mM as IAbstractMask);

            updateCustomDebug()
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
            var bitmapFont:BitmapFont = new BitmapFont(fontTexture, xml);
            var fontName_:String;

            if (fontName != "")
            {
                fontName_ = TextField.registerBitmapFont(bitmapFont, fontName);
            }
            else
            {
                fontName_ = TextField.registerBitmapFont(bitmapFont);
            }
            updateCustomDebug()
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
            var video:IAbstractVideo = new EngineVideo(_signalsHub, _assetsManager);
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
        public function get juggler_():Object
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
		 */
		private function
                initFlare():void {
            //Device3D.profile = "standard";
            //FLSL.agalVersion = 2;

            var _flareHolder:Sprite = new Sprite();
            _signalsHub.addSignal(FlareBridge.FLARE_INITED, new Signal(), new Vector.<Function>());
            _signalsHub.addListenerToSignal(FlareBridge.FLARE_INITED, onFlareInited);
            _flareBridge = new FlareBridge(_signalsHub, _flareHolder, _starling);

            this.addChild(_flareHolder);
        }
		
		/**
		 * 
		 * @param	type
		 * @param	obj
		 */
		private function onFlareInited(type:String, obj:Object):void
		{
			Output.out("BridgeGraphics :: Flare3D :: init successful");
			if (!_starling)
			{
				_starling = new Starling(StarlingMain, stage, null, stage.stage3Ds[0]);
				_starling.addEventListener( "rootCreated", starlingRootEvent );
				_starling.start();
			}
			
			if (_debugMode)
			{
				_starling.showStats = true;
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function starlingRootEvent( e:starling.events.Event ):void {
            Output.out("BridgeGraphics :: Flare3D :: Starling force started :: succesful");

            var _starlingRoot:starling.display.Sprite = _starling.root as starling.display.Sprite;
            _flareBridge._starling = _starling;

            handleStarlingReady();
        }
		
		/**
		 * 
		 * @param	e
		 */
		private function onDeactivate(e:Event):void
		{
			Starling.current.start();
			Starling.current.nativeStage.frameRate = 60;
			_juggler.paused = false;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function onMouseWheel(e:MouseEvent):void
		{
			var o:GESignalEvent = new GESignalEvent();
			o.eventName = Signals.MOUSE_WHEEL;
			o.engineEvent = e;
			o.params ={ delta:e.delta};
			_signalsHub.dispatchSignal(Signals.MOUSE_WHEEL, "delta", o);
		}
		
		/**
		 * 
		 */
		private function configureConsole():void
		{
			_consoleCommands = new ConsoleCommands(console);
			
			_consoleCommands.registerCommand("verbose=true", function():void
			{
				_signalsHub.verbose = true;
				Output.verbose = true;
				BridgeGraphics.isVerbose = true;
			});
			
			_consoleCommands.registerCommand("verbose=false", function():void
			{
				_signalsHub.verbose = false;
				Output.verbose = false;
				BridgeGraphics.isVerbose = true;
			});

            _consoleCommands.registerCommand("toggleCustomStats", function():void
            {
                _statsDebug = new StatsDebug();
                nativeDisplay.addChild(_statsDebug);
            });
		}
		
		/**
		 * @TODO finish integrating Nape 2D
		 */
		private function initNape():void
		{
			//_space = new Space(new Vec2(0, 5));
			//addEventListener(Event.ENTER_FRAME, loop);
		}
		
		/**
		 * 
		 * @param	mc
		 * @param	textures
		 * @param	fps
		 * @return
		 */
		private function cleanMovieclip(mc:IAbstractMovie, textures:Vector.<Texture>, fps:uint = 24):IAbstractMovie
		{
			while (mc.numFrames > 1)
			{
				mc.removeFrameAt(0);
			}
			
			for (var i:uint = 0; i < textures.length; i++ )
			{
				(mc as MovieClip).addFrame(textures[i] as Texture);
			}
			
			mc.removeFrameAt(0);
			mc.currentFrame = 0;
			mc.fps = fps;
			
			mc.readjustSize();
			
			return mc;
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
						outTransition.doTransition(outLayers[j] as EngineLayer, container);
					}
					else
					{
						tranzitionToLayerOutComplete(outLayers[j], container);
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
					var o:GESignalEvent = new GESignalEvent();
					o.eventName = Signals.LAYER_TRANSITION_IN_COMPLETE;
					o.engineEvent = null;
					o.params = params;
				
				_signalsHub.dispatchSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, (target1 as IAbstractDisplayObject).name, o);
			}
		}
		
		/**
		 * 
		 * @param	target1
		 * @param	target2
		 */
		public function tranzitionToLayerOutComplete(target:Object = null, container:Object = null, params:Object = null):void
		{
			if (target)
			{
				container.removeChildAndDispose(target as EngineLayer);
				
				(target as EngineLayer).destroyAll();
			
				var o:GESignalEvent = new GESignalEvent();
					o.eventName = Signals.LAYER_TRANSITION_OUT_COMPLETE;
					o.engineEvent = null;
					o.params = params;
				
				_signalsHub.dispatchSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, (target as IAbstractDisplayObject).name, o);
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
				layer.destroyAll();
			
				var layoutDict:Dictionary = layer.layout;
				var layerElements:Vector.<EngineLayerLayoutElementVo> = new Vector.<EngineLayerLayoutElementVo>();
			
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
            if(name.search("ATF") == -1) {
                var atlasBitmapData:BitmapData = new atlasPng();
                var atlasBitmap:Bitmap = new Bitmap(atlasBitmapData);
                var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(atlasBitmap), atlasXml);
                _assetsManager.addTextureAtlas(name, atlas);
				atlasBitmapData.dispose();
                atlasBitmapData = null;
                atlasBitmap = null;
            }
            else
            {
                addATFAtlas(name, atlasXml, atlasPng);
            }
        }

    /**
     *
     * @param name
     * @param atlasXml
     * @param atlasATF
     */
        public function  addATFAtlas(name:String, atlasXml:XML, atlasATF:Class):void
        {
            var atlas:TextureAtlas = new TextureAtlas(TextureFromATF.CreateTextureFromATF(atlasATF), atlasXml);
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
         * @param	rect
         * @param	scale
         * @return
         */
        public  function requestScreenshot(rect:Rectangle, scale:Number=1.0):BitmapData
        {
            var stage:Stage= Starling.current.stage;
            var width:Number = rect.width;
            var height:Number = rect.height;

            var rs:RenderSupport = new RenderSupport();

            rs.clear(stage.color, 1.0);
            rs.scaleMatrix(scale, scale);
            rs.setOrthographicProjection(rect.x, rect.y, rect.width, rect.height);

            stage.render(rs, 1.0);
            rs.finishQuadBatch();

            var outBmp:BitmapData = new BitmapData(width*scale, height*scale, true);
            Starling.context.drawToBitmapData(outBmp);

            return outBmp;
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
         * @param	pixelSize
         */
        public function addPixelationFilter(target:IAbstractDisplayObject, pixelSize:int):void
        {
            if ((target as DisplayObject).filter == null)
            {
                (target as DisplayObject).filter = new PixelateFilter(pixelSize);
            }
            else
            {
                ((target as DisplayObject).filter as PixelateFilter).pixelSize = pixelSize;
            }
        }

        /**
         *
         * @param	target
         * @param	pixelSize
         */
        public function addNewsPaperFilter(target:IAbstractDisplayObject, size:int, scale:int, angleInRadians:Number):void
        {
            (target as DisplayObject).filter = new NewsprintFilter(size, scale, angleInRadians);
        }

        /**
         *
         * @param	target
         * @param	vo
         */
        public function addDropShadowFilter(target:IAbstractDisplayObject, vo:IAbstractDropShadowFilter):void
        {
            var blurFilter:BlurFilter = _fragmentStandardFilterPool.getNewObject() as BlurFilter;
            blurFilter = BlurFilter.createDropShadow(vo.distance, vo.angle, vo.color, vo.alpha, vo.blur, vo.resolution);
            (target as DisplayObject).filter = blurFilter;
            vo.reference = blurFilter;
        }

        /**
         *
         * @param	target
         * @param	vo
         */
        public function addGlowFilter(target:IAbstractDisplayObject, vo:IAbstractGlowFilter):void
        {
            var blurFilter:BlurFilter = _fragmentStandardFilterPool.getNewObject() as BlurFilter;
            blurFilter = BlurFilter.createGlow(vo.color, vo.alpha, vo.blur, vo.resolution);
            (target as DisplayObject).filter = blurFilter;
            vo.reference = blurFilter;
        }

        /**
         *
         * @param	target
         * @param	vo
         */
        public function addBlurFilter(target:IAbstractDisplayObject, vo:IAbstractBlurFilter):void
        {
            var blurFilter:BlurFilter = _fragmentStandardFilterPool.getNewObject() as BlurFilter;
            blurFilter.blurX = vo.blurX;
            blurFilter.blurY = vo.blurY;
            blurFilter.resolution = vo.resolution;
            (target as DisplayObject).filter = blurFilter;
            vo.reference = blurFilter;
        }

        /**
         *
         * @param	target
         * @param	filter
         */
        public function addFragmentFilter(target:IAbstractDisplayObject, filter:Object):void
        {
            (target as DisplayObject).filter = filter as FragmentFilter;
        }

        /**
         *
         * @param	target
         */
        public function clearFilter(target:IAbstractDisplayObject):void
        {
            if ( (target as DisplayObject).filter != null)
            {
                (target as DisplayObject).filter.dispose();
                (target as DisplayObject).filter = null;
            }
        }

        public function get currentContainer():IAbstractState
        {
            return _currentState;
        }

        public function get nativeDisplay():Sprite
        {
            return _starling.nativeOverlay;
        }

        public function get is3D():Boolean
        {
            return _is3D;
        }

        public function set is3D(value:Boolean):void
        {
            _is3D = value;
        }

        public function get scene3D():Object
        {
            return _flareBridge.scene;
        }
		
		public function get consoleCommands():IConsoleCommands 
		{
			return _consoleCommands;
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
            //_space = null;
            _currentState = null;
            _assetsManager = null;
            _signalsHub = null;

            state.destroy();
            if (futureState != null)
            {
                futureState.destroy();
            }

            super.destroy();

            Output.out(this + " -> destroyed");
        }

        /**
         *
         * @param	configXML
         * @param	imageSource
         * @return
         */
        public function requestParticleSystem(configXML:XML, imageSource:IAbstractImage):IAbstractParticleSystem
        {
            return new EngineParticleSystem(configXML, imageSource, juggler as Juggler);
        }

        /**
         *
         * @param	configXML
         * @param	imageSource
         * @param	atlasXML
         * @return
         */
        public function requestAdvancedParticleSystem(configXML:XML, imageSource:IAbstractImage, atlasXML:XML=null):IAbstractParticleSystem
        {
            var advancedParticleSystem:IAbstractParticleSystem = new EngineAdvancedParticleSystem(configXML, imageSource, juggler as Juggler, _signalsHub, atlasXML);
            return advancedParticleSystem;
        }

        public function isHit(localPoint:Point, forTouch:Boolean = false):Boolean
        {
            return true;
        }

        /**
         * Returns a Boolean whether the context is available or not (e.g. disposed)
         * @return
         */
        public function  contextStatus():Boolean
        {
            var context:Boolean = true;

            if (!Starling.current.context || Starling.current.context.driverInfo == "Disposed")
            {
                context =  false;
            }

            return context;
        }
		
		/**
		 * 
		 */
		public function set alwaysVerbose(val:Boolean):void
		{
			Output.verbose = val;
		}
		
		/**
		 * 
		 * @param	layer
		 * @param	sortedElements
		 */
		private function autoAddItems(layer:IAbstractLayer, sortedElements:Vector.<EngineLayerLayoutElementVo>): void
		{
			for (var i:uint = 0; i < sortedElements.length; i++ )
                switch (sortedElements[i].type) {
                    case ENGINE_LAYER_PROPERTIES:
                        layer.x = Math.round(sortedElements[i].layerX);
                        layer.y = Math.round(sortedElements[i].layerY);
                        break;

                    case ENGINE_IMAGE:
                        layer.addNewChildAt(LayoutImageValidator.validate(this, _assetsManager, sortedElements[i]), i);
                        break;

                    case ENGINE_BUTTON:
                        var btn:IAbstractButton = LayoutButtonValidator.validate(this, _assetsManager, sortedElements[i]);
                        (btn as IAbstractButton).addEventListener(EngineEvent.TRIGGERED, button_triggeredHandler);
                        (btn as IAbstractButton).addEventListener(TouchEvent.TOUCH, button_touchedHandler);
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
                        break;

                    case ENGINE_FLV:
                        break;
                    default:
                        break;
                }
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function movieClip_Completed(e:Object):void
		{
				var o:GESignalEvent = new GESignalEvent();
				o.eventName = Signals.MOVIE_CLIP_ENDED;
				o.engineEvent = e;
				o.params = null;
					
			_signalsHub.dispatchSignal(Signals.MOVIE_CLIP_ENDED, (e.currentTarget as IAbstractMovie).name, o);
			Output.out("StarlingEngine :: Signals Manager :: dispatching " + Signals.MOVIE_CLIP_ENDED + " from " + (e.currentTarget as IAbstractMovie).name);
			
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function button_triggeredHandler(e:Object):void
		{
				var o:GESignalEvent = new GESignalEvent();
				o.eventName = Signals.GENERIC_BUTTON_PRESSED;
				o.engineEvent = e;
				o.params = null;
				_signalsHub.dispatchSignal(Signals.GENERIC_BUTTON_PRESSED, (e.currentTarget as IAbstractButton).name, o);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function button_touchedHandler(e:Object):void
		{
			var touch:Touch = e.getTouch(e["touches"][0]["target"]);
			
			if (!touch)
			   {
				return;
			   }
			   
				if(touch.phase == TouchPhase.HOVER)//on finger down
				{
					var o:GESignalEvent = new GESignalEvent();
					o.eventName = Signals.GENERIC_BUTTON_OVER;
					o.engineEvent = e;
					o.params = null;
					
					_signalsHub.dispatchSignal(Signals.GENERIC_BUTTON_OVER, (e.currentTarget as IAbstractButton).name, o);
					
					if ((e.currentTarget as IAbstractButton).currentState_ == "up")
					{
						var oOut:GESignalEvent = new GESignalEvent();
						oOut.eventName = Signals.GENERIC_BUTTON_OUT;
						oOut.engineEvent = e;
						oOut.params = null;
						
						_signalsHub.dispatchSignal(Signals.GENERIC_BUTTON_OUT, (e.currentTarget as IAbstractButton).name, oOut);
					}
				}
				
				if(touch.phase == TouchPhase.ENDED)//on finger down
				{
					var oE:GESignalEvent = new GESignalEvent();
					oE.eventName = Signals.GENERIC_BUTTON_ENDED;
					oE.engineEvent = e;
					oE.params = null;
					
					_signalsHub.dispatchSignal(Signals.GENERIC_BUTTON_ENDED, (e.currentTarget as IAbstractButton).name, oE);
				}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function slider_component_changed(e:Object):void
		{
			var o:GESignalEvent = new GESignalEvent();
			o.eventName = Signals.GENERIC_SLIDER_CHANGE;
			o.engineEvent = e["event"];
			o.params = {
				amount:e["amount"]
			};
			
			_signalsHub.dispatchSignal(Signals.GENERIC_SLIDER_CHANGE, e["name"], o);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function toggle_button_triggeredHandler(e:Object):void
		{
			var o:GESignalEvent = new GESignalEvent();
			o.eventName = Signals.GENERIC_TOGGLE_BUTTON_PRESSED;
			o.engineEvent = e;
			o.params = {
				state:e["currentTarget"]["state"]
			};
			
			_signalsHub.dispatchSignal(Signals.GENERIC_TOGGLE_BUTTON_PRESSED, (e.currentTarget as IAbstractButton).name, o);
		}
		
		private var _pendingRemove:Vector.<Object> = new Vector.<Object>;
		/**
		 * 
		 * @param	type
		 * @param	obj
		 */
		private function tryRemove(type:String, obj:GESignalEvent):void
		{
			if (contextStatus())
			{
				Output.out("Sync removing: " + obj["params"]["target"] + " from " +obj["params"]["parent"]);
				if (!obj["params"]["recycle"])
				{
					(obj["params"]["parent"] as IAbstractDisplayObjectContainer).removeChildAndDispose(obj["params"]["target"] as IAbstractDisplayObject, true);
				}
				else
				{
					returnToPool(obj["params"]["target"]);
				}
			}
			else
			{
				_pendingRemove.push(obj["params"]);
			}
		}
		
		/**
		 * 
		 */
		private function onContext3DEventCreate():void
		{
			Output.out("Context Restored");
			var delayedCall:delayedFunctionCall = new delayedFunctionCall(delayedRemove, 100);
			
			var contextSignal:GESignalEvent = new GESignalEvent();
			contextSignal.engineEvent = Signals.CONTEXT_3D_RESTORED;
			contextSignal.eventName = "Restore";
			contextSignal.params = { };
			_signalsHub.dispatchSignal(Signals.CONTEXT_3D_RESTORED, Signals.CONTEXT_3D_RESTORED, contextSignal);
		}
		
		/**
		 * 
		 */
		private function delayedRemove():void
		{
			var obj:Object;
			while (_pendingRemove.length > 0)
			{
				obj = _pendingRemove.pop();
				var recycle:Boolean = obj["recycle"];
				var parent:IAbstractDisplayObjectContainer = (obj["parent"] as IAbstractDisplayObjectContainer);
				var target:IAbstractDisplayObject = (obj["target"] as IAbstractDisplayObject);
				
				if (!recycle)
				{
					parent.removeChildAndDispose(target, true);
				}
				else
				{
					returnToPool(target);
				}
				Output.out("Async removing: " + target.name+" from " + parent.name);
			}
		}
		
		private function onTexturesRestored():void
		{
			Output.out("Textures from AssetManager restored");
		}

    public function get debugMode():Boolean {
        return _debugMode;
    }

    private function updateCustomDebug():void
    {
        //_texturesUsed ++;
        //_statsDebug.tf1.text = "textures used "+_texturesUsed;
    }
}
	
}