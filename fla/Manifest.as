package
{
	/**
	 * ...
	 * @author Eu
	 */
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
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import flappybird.FlappyBirdGameState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.AsyncErrorEvent;
	import flash.events.IEventDispatcher;
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
	import flash.display3D.Context3D;
	import nape.space.Space;
	import org.osflash.signals.natives.NativeSignal;
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
	import starlingEngine.elements.EngineBlitMask;
	import starlingEngine.elements.EngineDisplayObject;
	import starlingEngine.elements.EngineDisplayObjectContainer;
	import starlingEngine.elements.EngineImage;
	import starlingEngine.elements.EngineJuggler;
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
	import starlingEngine.events.EngineEventDispatcher;
	import starlingEngine.events.GESignalEvent;
	import starlingEngine.extensions.ColorArgb;
	import starlingEngine.extensions.krecha.filters.FreezFilter;
	import starlingEngine.extensions.krecha.PixelHitArea;
	import starlingEngine.extensions.krecha.PixelImageTouch;
	import starlingEngine.extensions.krecha.ScrollImage;
	import starlingEngine.extensions.krecha.ScrollTile;
	import starlingEngine.extensions.Particle;
	import starlingEngine.extensions.PDParticle;
	import starlingEngine.extensions.pixelmask.PixelMaskDisplayObject;
	import starlingEngine.extensions.quadtree.Quadtree;
	import starlingEngine.extensions.quadtree.QuadtreeNode;
	import starlingEngine.extensions.QuadtreeSprite;
	import starlingEngine.filters.BlurFilterVO;
	import starlingEngine.filters.DropShadowFilterVO;
	import starlingEngine.filters.GlowFilterVO;
	import starlingEngine.StarlingEngine;
	import starlingEngine.transitions.EngineLayerTransitionIn;
	import starlingEngine.transitions.EngineLayerTransitionOut;
	import starlingEngine.transitions.EngineStateTransition;
	import starlingEngine.ui.EngineButton;
	import starlingEngine.ui.EngineInputText;
	import starlingEngine.ui.EngineSlider;
	import starlingEngine.ui.EngineToggleButton;
	import starlingEngine.validators.LayoutButtonValidator;
	import starlingEngine.validators.LayoutImageValidator;
	import starlingEngine.validators.LayoutMovieClipValidator;
	import starlingEngine.validators.LayoutSliderValidator;
	import starlingEngine.validators.LayoutTextFieldValidator;
	import starlingEngine.validators.LayoutToggleButtonValidator;
	import starlingEngine.video.display.Video;
	import starlingEngine.video.events.VideoEvent;
	import fl.transitions.Tween;
	import starling.display.Graphics;
	import starling.display.GraphicsEndFill;
	import starling.display.GraphicsLine;
	import starling.display.GraphicsMaterialFill;
	import starling.display.GraphicsPath;
	import starling.display.GraphicsPathCommands;
	import starling.display.GraphicsSolidFill;
	import starling.display.GraphicsTextureFill;
	import starling.display.IGraphicsData;
	import starling.display.IGraphicsFill;
	import nape.shape.Shape;
	import starling.display.graphics.Fill;
	import starling.display.graphics.Graphic;
	import starling.display.graphics.NGon;
	import starling.display.graphics.Plane;
	import starling.display.graphics.RoundedRectangle;
	import starling.display.graphics.Stroke;
	import starling.display.graphics.StrokeVertex;
	import starling.display.graphics.TriangleFan;
	import starling.display.graphics.TriangleStrip;
	import starling.display.graphics.VertexList;
	import starling.display.graphicsEx.GraphicsEx;
	import starling.display.graphicsEx.GraphicsExColorData;
	import starling.display.graphicsEx.GraphicsExThicknessData;
	import starling.display.graphicsEx.GraphicsNaturalSpline;
	import starling.display.graphicsEx.ShapeEx;
	import starling.display.graphicsEx.StrokeEx;
	import starling.display.materials.FlatColorMaterial;
	import starling.display.materials.IMaterial;
	import starling.display.materials.StandardMaterial;
	import away3d.materials.TextureMaterial;
	import flash.display3D.Program3D;
	import starling.display.shaders.fragment.TextureFragmentShader;
	import starling.display.shaders.fragment.TextureVertexColorFragmentShader;
	import starling.display.shaders.fragment.VertexColorFragmentShader;
	import starling.display.shaders.vertex.AnimateUVVertexShader;
	import away3d.materials.methods.RimLightMethod;
	import starling.display.shaders.vertex.RippleVertexShader;
	import starling.display.shaders.vertex.StandardVertexShader;
	import starling.display.shaders.AbstractShader;
	import starling.display.shaders.IShader;
	import starling.display.Shape;
	import starling.textures.GradientTexture;
	 
	public class Manifest extends Sprite
	{
		
		public function Manifest() 
		{
			//engine
			 var _starlingEngine:StarlingEngine = new StarlingEngine(null, 0,0);	
			//context 
			 var _context:Context3D = new Context3D();
			 //bridge
			 var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
																				new Point(0, 0),
																				StarlingEngine,
																				starling.utils.AssetManager,
																				signals.SignalsHub,
																				AbstractPool,
																				starling.animation.Juggler,
																				nape.space.Space,
																				true
																				);
			//greensock	- removed, use swc from greensock														
			
			//signals
			var signal:NativeSignal;
			
			//starling Graphics API
			var a:Graphics;
			var b:GraphicsEndFill;
			var c:GraphicsLine;
			var d:GraphicsMaterialFill;
			var e:GraphicsPath;
			var f:GraphicsPathCommands;
			var g:GraphicsSolidFill;
			var h:GraphicsTextureFill;
			var i:IGraphicsData;
			var j:IGraphicsFill;
			var k:Shape;
			var l:Fill;
			var m:Graphic;
			var n:NGon;
			var o:Plane;
			var p:RoundedRectangle;
			var q:Stroke;
			var r:StrokeVertex;
			var s:TriangleFan;
			var t:TriangleStrip;
			var u:VertexList;
			var v:GraphicsEx;
			var w:GraphicsExColorData;
			var xa:GraphicsExThicknessData;
			var ya:GraphicsNaturalSpline;
			var za:ShapeEx;
			var aa:StrokeEx;
			var ab:FlatColorMaterial;
			var ac:IMaterial;
			var ad:StandardMaterial;
			var ae:TextureMaterial;
			var af:TextureFragmentShader;
			var ag:TextureVertexColorFragmentShader;
			var ah:VertexColorFragmentShader;
			var ai:AnimateUVVertexShader;
			var aj:RippleVertexShader;
			var ak:StandardVertexShader;
			var al:AbstractShader;
			var am:IShader;
			var an:GradientTexture;
			
			var starlingClasses:Vector.<Class>;
			starlingClasses.push(EngineBlitMask)
			starlingClasses.push(EngineDisplayObject)
			//starlingClasses.push(EngineDisplayObjectContainer)
			starlingClasses.push(EngineImage)
			//starlingClasses.push(EngineJuggler)
			starlingClasses.push(EngineLabel)
			starlingClasses.push(EngineLayer)
			starlingClasses.push(EngineLayerLayoutElementVo)
			starlingClasses.push(EngineLayerVO)
			starlingClasses.push(EngineMask)
			starlingClasses.push(EngineMovie)
			starlingClasses.push(EngineScrollTile)
			starlingClasses.push(EngineSprite)
			starlingClasses.push(EngineState)
			starlingClasses.push(EngineTextField)
			starlingClasses.push(EngineTexture)
			starlingClasses.push(EngineVideo)
			starlingClasses.push(EngineEvent)
			//starlingClasses.push(EngineEventDispatcher)
			starlingClasses.push(GESignalEvent)
			
			starlingClasses.push(FreezFilter)
			starlingClasses.push(PixelHitArea)
			//starlingClasses.push(PixelImageTouch)
			starlingClasses.push(ScrollImage)
			starlingClasses.push(ScrollTile)
			starlingClasses.push(PixelMaskDisplayObject)
			starlingClasses.push(Quadtree)
			starlingClasses.push(QuadtreeNode)
			starlingClasses.push(ColorArgb)
			starlingClasses.push(Particle)
			starlingClasses.push(ParticleSystem)
			starlingClasses.push(PDParticle)
			starlingClasses.push(PDParticleSystem)
			starlingClasses.push(QuadtreeSprite)
			
			starlingClasses.push(BlurFilterVO)
			starlingClasses.push(DropShadowFilterVO)
			starlingClasses.push(GlowFilterVO)
			
			starlingClasses.push(EngineLayerTransitionIn)
			starlingClasses.push(EngineLayerTransitionOut)
			starlingClasses.push(EngineStateTransition)
			
			starlingClasses.push(EngineButton)
			//starlingClasses.push(EngineInputText)
			starlingClasses.push(EngineSlider)
			starlingClasses.push(EngineToggleButton)
			
			starlingClasses.push(LayoutButtonValidator)
			starlingClasses.push(LayoutImageValidator)
			starlingClasses.push(LayoutMovieClipValidator)
			starlingClasses.push(LayoutSliderValidator)
			starlingClasses.push(LayoutTextFieldValidator)
			starlingClasses.push(LayoutToggleButtonValidator)
			
			starlingClasses.push(Video)
			starlingClasses.push(VideoEvent)
			
			//starling engine cusotom
	
			//Citrus TO DO
		}
		
	}

}