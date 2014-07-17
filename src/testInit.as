package  
{
	import bridge.abstract.AbstractPool;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import nape.space.Space;
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.utils.AssetManager;
	import starlingEngine.StarlingEngine;
	/**
	 * ...
	 * @author Eu
	 */
	public class testInit extends Sprite
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
																		
		
		public function testInit() 
		{
			addChild(_bridgeGraphics.engine as DisplayObject);
			 //(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
		}
		
	}

}