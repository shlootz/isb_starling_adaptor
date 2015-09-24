package  
{
	import bridge.abstract.AbstractPool;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.ui.IAbstractComboBox;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import signals.ISignalsHub;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.utils.AssetManager;
	import starlingEngine.signals.Signals;
	import starlingEngine.StarlingEngine;
	import starlingEngine.ui.EngineComboBoxItemRenderer;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class testInit extends Sprite
	{
		 [SWF(frameRate="60", width="800", height="600",backgroundColor="0x333333")]

    private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
            new Point(800, 600),
            StarlingEngine,
            starling.utils.AssetManager,
            SignalsHub,
            AbstractPool,
            starling.animation.Juggler,
            true,
            false
    );
	
		public function testInit() 
		{
			  addChild(_bridgeGraphics.engine as flash.display.DisplayObject);
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
		}
		
		 private function loadAssets(event:String, obj:Object):void
		{
			(_bridgeGraphics.assetsManager as AssetManager).enqueue(
				"assets/bitmapfonts/Debug.fnt",
				"assets/bitmapfonts/Debug.png"
			);
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void {
				trace("Loading assets, progress:", ratio);
				if (ratio == 1) {
					testComboBox();
			}
		});
		}
		
		private var _combinationsComboBox:IAbstractComboBox;
		private var _combinationsComboBox2:IAbstractComboBox;
		private var _combinationsComboBox3:IAbstractComboBox;
		private var _combinationsComboBox4:IAbstractComboBox;
		
		private function testComboBox():void
		{
			var bk:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(800,600, false, 0x333333));
			_bridgeGraphics.currentContainer.addNewChild(bk);

			var dataProvider:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>;
			var debugCombinations:Vector.<String> = new Vector.<String>();
			debugCombinations.push("1asdfsadf");
			debugCombinations.push("2sdgfdga");
			debugCombinations.push("3sdfg4sdfg");
			debugCombinations.push("4sdfg3g");
			debugCombinations.push("5sdfgdsfg4");

			for (var i:uint = 0; i<debugCombinations.length; i++)
			{
				var item:IAbstractComboBoxItemRenderer = new EngineComboBoxItemRenderer(debugCombinations[i], null);
				item.data = debugCombinations[i];
				dataProvider.push(item);
			}

			var backgroundImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(100,30,false,0x00000));

			_combinationsComboBox = _bridgeGraphics.requestComboBox(dataProvider, 120, 100, backgroundImage, "Debug");
			_combinationsComboBox2 = _bridgeGraphics.requestComboBox(dataProvider, 120, 100, backgroundImage, "Debug");
			_combinationsComboBox3 = _bridgeGraphics.requestComboBox(dataProvider, 120, 100, backgroundImage, "Debug");
			_combinationsComboBox4 = _bridgeGraphics.requestComboBox(dataProvider, 120, 100, backgroundImage, "Debug");
			_combinationsComboBox.name = "combinationsComboBox";


			_combinationsComboBox.x = 50;
			_combinationsComboBox.y = 200;

			_combinationsComboBox2.x = 150;
			_combinationsComboBox2.y = 200;

			_combinationsComboBox3.x = 250;
			_combinationsComboBox3.y = 200;

			_combinationsComboBox4.x = 350;
			_combinationsComboBox4.y = 200;

			_bridgeGraphics.currentContainer.addNewChild(_combinationsComboBox);
			_bridgeGraphics.currentContainer.addNewChild(_combinationsComboBox2);
			_bridgeGraphics.currentContainer.addNewChild(_combinationsComboBox3);
			_bridgeGraphics.currentContainer.addNewChild(_combinationsComboBox4);
    }
	}
}