package {

import bridge.BridgeGraphics;
import bridge.IBridgeGraphics;
import bridge.abstract.AbstractPool;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;

import nape.space.Space;

import signals.ISignalsHub;
import signals.Signals;

import signals.SignalsHub;

import starling.animation.Juggler;

import starling.utils.AssetManager;

import starlingEngine.StarlingEngine;

public class Main extends Sprite {

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

    public function Main() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);

        addChild(_bridgeGraphics.engine as DisplayObject);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
    }

    private function loadAssets(event:String, obj:Object):void
    {
        trace("STARLING INITIED");
    }
}
}
