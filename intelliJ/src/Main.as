package {

import bridge.BridgeGraphics;
import bridge.IBridgeGraphics;
import bridge.abstract.AbstractPool;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractLayer;
import bridge.abstract.IAbstractVideo;
import bridge.abstract.filters.IAbstractBlurFilter;
import bridge.abstract.ui.IAbstractLabel;

import flash.display.Bitmap;
import flash.display.BitmapData;

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
import starlingEngine.elements.EngineVideo;
import starlingEngine.filters.BlurFilterVO;

import utils.delayedFunctionCall;

public class Main extends Sprite {

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

    public function Main() {
        addChild(_bridgeGraphics.engine as DisplayObject);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
    }

    private function loadAssets(event:String, obj:Object):void
    {
        (_bridgeGraphics.assetsManager as AssetManager).enqueue(
                "assets/BackgroundModuleAssets.xml",
                "assets/BackgroundModuleSkin.png",
                "assets/BackgroundModuleSymbolsBackgroundLayerLayout.xml",
                "assets/BackgroundModuleSymbolsFrameLayerLayout.xml",
                "assets/FeaturesModuleAssets.xml",
                "assets/FeaturesModuleAssets1.xml",
                "assets/FeaturesModuleSkin.png",
                "assets/FeaturesModuleSkin1.png",
                "assets/FreeSpinsModuleFreeGamesUILayerLayout.xml",
                "assets/GainViewerModuleGainViewerLayerLayout",
                "assets/Image 3.png",
                "assets/InstantBonusModuleInstantBonusLayerLayout.xml",
                "assets/IntroFeaturesModuleIntroLayerLayout.xml",
                "assets/LinesModuleLinesLayerLayout.xml",
                "assets/LogoModuleLogoLayerLayout.xml",
                "assets/MenuModuleMenuLayerLayout.xml",
                "assets/PaytableModule Assets.xml",
                "assets/PayTableModulePayTableLayerLayout.xml",
                "assets/PaytableModuleSkin.png",
                "assets/PreloadeModuleAssets.xml",
                "assets/PreloaderModulePreloaderLayerLayout.xml",
                "assets/PreloaderModuleSkin.png",
                "assets/RaBonusModuleBonusLayerLayout.xml",
                "assets/StripModuleStripLayerLayout.xml",
                "assets/UserInterfaceModuleGameplayButtonsLayerLayout.xml",
                "assets/WinningsAnimationsModuleAssets1.xml",
                "assets/WinningsAnimationsModuleAssets2.xml",
                "assets/WinningsAnimationsModuleSkin1.png",
                "assets/WinningsAnimationsModuleSkin2.png",
                "assets/WinStepsModuleAssets.xml",
                "assets/WinStepsModuleSkin.png"
        );
        (_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void {
            trace("Loading assets, progress:", ratio);
            if (ratio == 1) {
                //testLayerDispose();
                //testFiltersDispose();
                testVideo();
            }
        });
    }

    private function testVideo():void
    {
        var vd:IAbstractVideo = _bridgeGraphics.requestVideo();
        vd.addVideoPath("assets/test2.flv", false);
        vd.loop = false;

        _bridgeGraphics.currentContainer.addNewChild(vd);
    }

    private function testLayerDispose():void
    {
        var layer:IAbstractLayer = _bridgeGraphics.requestLayer("test", 1, _bridgeGraphics.getXMLFromAssetsManager("UserInterfaceModuleGameplayButtonsLayerLayout"), true);
        var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();

        var someImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(100,100,false, 0x000000));
        var blurF:IAbstractBlurFilter = _bridgeGraphics.requestBlurFilter();
        blurF.blurX = 5;
        blurF.blurY = 5;

        someImage.x = 100;
        someImage.y = 100;

        layer.addNewChild(someImage);
        _bridgeGraphics.addBlurFilter(someImage, blurF);

        inLayers.push(layer);

        _bridgeGraphics.updateLayers(_bridgeGraphics.currentContainer, inLayers);

        _bridgeGraphics.returnToPool(layer);
    }

    private function testFiltersDispose():void
    {
        var someImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(100,100,false, 0x000000));
        var blurF:IAbstractBlurFilter = _bridgeGraphics.requestBlurFilter();
        blurF.blurX = 5;
        blurF.blurY = 5;

        someImage.x = 100;
        someImage.y = 100;

        _bridgeGraphics.currentContainer.addNewChild(someImage);
        _bridgeGraphics.addBlurFilter(someImage, blurF);

        _bridgeGraphics.returnToPool(blurF);
        //_bridgeGraphics.returnToPool(someImage);
    }
}
}
