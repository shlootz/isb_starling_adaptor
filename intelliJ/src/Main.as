package {

import bridge.BridgeGraphics;
import bridge.IBridgeGraphics;
import bridge.abstract.AbstractPool;
import bridge.abstract.IAbstractGraphics;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractLayer;
import bridge.abstract.IAbstractMask;
import bridge.abstract.IAbstractMovie;
import bridge.abstract.IAbstractSprite;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.IAbstractVideo;
import bridge.abstract.filters.IAbstractBlurFilter;
import bridge.abstract.ui.IAbstractLabel;

import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;

import nape.space.Space;

import signals.ISignalsHub;
import starlingEngine.signals.Signals;

signals.ISignalsHub

import starling.animation.Juggler;
import starling.display.Quad;

import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

import starlingEngine.StarlingEngine;
import starlingEngine.elements.EngineSprite;
import starlingEngine.elements.EngineVideo;
import starlingEngine.filters.BlurFilterVO;

import utils.delayedFunctionCall;

public class Main extends Sprite {

    private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
            new Point(800, 600),
            StarlingEngine,
            starling.utils.AssetManager,
            starlingEngine.signals.SignalsHub,
            AbstractPool,
            starling.animation.Juggler,
            true,
            true
    );

    public function Main() {
        _bridgeGraphics.engine.is3D = true;
        addChild(_bridgeGraphics.engine as DisplayObject);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
    }

    private function loadAssets(event:String, obj:Object):void
    {
        (_bridgeGraphics.assetsManager as AssetManager).enqueue(
            "assets/BackgroundModuleAssets.png",
            "assets/BackgroundModuleAssets.xml",
            "assets/UserInterfaceModuleGameplayButtonsLayerLayout.xml"
        );
        (_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void {
            trace("Loading assets, progress:", ratio);
            if (ratio == 1) {
                //buildMenu();
                //testTextFields();
                testMovieClips();
            }
        });
    }

    private function testMovieClips():void
    {
        var frames:Vector.<IAbstractImage> = new Vector.<IAbstractImage>();
        for (var i:uint = 0; i<100; i++)
        {
            frames.push(_bridgeGraphics.requestImageFromBitmapData(new BitmapData(10+Math.random()*100, 10+Math.random()*100, false, Math.random()*0xffffff)));
        }

        var mc:IAbstractMovie = _bridgeGraphics.requestMovieFromFrames(frames, 20);
        mc.loop = true;

        _bridgeGraphics.currentContainer.addNewChild(mc);

        mc.play();
        mc.x = 200;
        mc.y = 200;

        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.MOVIE_CLIP_ENDED, function(type:String, obj:Object):void{
            trace("movieClip Ended");
        });
    }

    private function testTextFields():void
    {
        var t:IAbstractTextField = _bridgeGraphics.requestTextField(300,50, "test");
        t.hAlign = HAlign.LEFT;
        t.vAlign = VAlign.TOP;
        var l:IAbstractLabel = _bridgeGraphics.requestLabelFromTextfield(t);

        _bridgeGraphics.currentContainer.addNewChild(l);

        var q:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(t.textBounds.width, t.textBounds.height,false, 0x000000));

        _bridgeGraphics.currentContainer.addNewChild(q);

        l.x = 150;
        l.y = 0;
        q.x = 150;
        q.y = 0;
    }

    private function buildMenu():void
    {
        var layout:XML = _bridgeGraphics.getXMLFromAssetsManager("BackgroundModuleAssets");
        var layer:IAbstractLayer = _bridgeGraphics.requestLayer("UI", 1, layout, true);
        var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
        var holder:IAbstractSprite = _bridgeGraphics.requestSprite("asd");

        inLayers.push(layer)

        _bridgeGraphics.updateLayers(holder , inLayers);

        _bridgeGraphics.addChild(holder);

        trace(holder.width)

        holder.addNewChild(_bridgeGraphics.requestImage("5ofaKindMessage"));
    }
}
}
