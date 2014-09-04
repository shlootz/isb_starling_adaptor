package
{
import bridge.abstract.AbstractPool;
import bridge.abstract.IAbstractDisplayObjectContainer;
import bridge.abstract.IAbstractGraphics;
import bridge.abstract.IAbstractVideo;
import bridge.abstract.events.IAbstractSignalEvent;
import bridge.abstract.IAbstractDisplayObject;
import bridge.abstract.IAbstractEngineLayerVO;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractLayer;
import bridge.abstract.IAbstractMovie;
import bridge.abstract.IAbstractSprite;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.filters.IAbstractBlurFilter;
import bridge.abstract.filters.IAbstractDropShadowFilter;
import bridge.abstract.filters.IAbstractGlowFilter;
import bridge.abstract.transitions.IAbstractLayerTransitionIn;
import bridge.abstract.transitions.IAbstractLayerTransitionOut;
import bridge.abstract.ui.IAbstractButton;
import bridge.abstract.ui.IAbstractLabel;
import bridge.abstract.ui.IAbstractSlider;
import bridge.abstract.ui.IAbstractToggle;
import bridge.BridgeGraphics;
import bridge.IBridgeGraphics;

import citrus.objects.vehicle.nape.Nugget;

import com.greensock.TweenLite;
import feathers.controls.Slider;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.text.TextField;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;
import nape.space.Space;
import signals.ISignalsHub;
import signals.Signals;
import signals.SignalsHub;
import starling.animation.IAnimatable;
import starling.animation.Juggler;
import starling.display.Image;
import starling.display.Quad;
import starling.textures.GradientTexture;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starlingEngine.elements.EngineLabel;
import starlingEngine.StarlingEngine;
import starlingEngine.ui.EngineSlider;
import starlingEngine.ui.EngineToggleButton;
/**
 * ...
 * @author Eu
 */

[SWF(backgroundColor='#ffffff',frameRate='60')]

public class Main extends Sprite
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

    public function Main()
    {
        addChild(_bridgeGraphics.engine as DisplayObject);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
    }

    private function loadAssets(event:String, obj:Object):void
    {
        (_bridgeGraphics.assetsManager).enqueue("assets/spritesheets/spriteSheetBackgrounds.png",
                "assets/spritesheets/spriteSheetBackgrounds.xml",
                "assets/spritesheets/spriteSheetElements.png",
                "assets/spritesheets/spriteSheetElements.xml",
                "assets/spritesheets/spriteSheetElements.xml",
                "assets/spritesheets/spriteSheetPayTable.xml",
                "assets/spritesheets/preloader1x.png",
                "assets/spritesheets/preloader1x.xml",
                "assets/layouts/layerLayout.xml",
                "assets/layouts/preloader1xLayout.xml",
                "assets/layouts/buttonLayout.xml",
                "assets/layouts/UserInterface.xml",
                "assets/layouts/Paytable.xml",
                "assets/layouts/PaytablePage1.xml",
                "assets/layouts/PaytablePage2.xml",
                "assets/layouts/PaytablePage3.xml",
                "assets/layouts/PaytablePage4.xml",
                "assets/layouts/PaytablePage5.xml",
                "assets/layouts/PaytablePage6.xml"
        );
        (_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
        {
            trace("Loading assets, progress:", ratio);
            if (ratio == 1)
            {
                _transIn.injectAnimation(animIn);
                _transOut.injectAnimation(animIn);

                ((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_IN_COMPLETE, transInComplete);
                ((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.LAYER_TRANSITION_OUT_COMPLETE, transOutComplete);
                ((_bridgeGraphics.signalsManager) as SignalsHub).addListenerToSignal(Signals.GENERIC_SLIDER_CHANGE, onSlider);
                //showPaytable();
                //makeUILayer();
                //makeSlider();
                //testMovieClips();
                //testFLV();
                //testLabel();
                testGraphics();
            }

        });
    }

    private function testGraphics():void
    {
        var bgMatrix:Matrix = new Matrix();
        var maxSquare:Number;
        var stageH:Number = 480;
        var stageW:Number = 600;

//I am making a gradient to fit my stage, but I don't want to distort the circular shape, the * 2.48 is to match the 248% scale I used in photoshop when visualising the gradient.
        if (stageH <= stageW) { maxSquare = stageH * 2.48 } else { maxSquare = stageW * 2.48 }

        var boxRotation:Number = Math.PI/2; // 90° Rotation value in radians, in photoshop the angle was set to 90 degrees for me, 0 might be fine for you.
//Setting the starting x/y values, as the gradient is larger than the stage to center it I need to offset it a bit.
        var tx:Number = (stageW/2)-(maxSquare/2);
        var ty:Number = (stageH/2)-(maxSquare/2);
//width,height,angle,offsetX,offsetY
        bgMatrix.createGradientBox(maxSquare, maxSquare, boxRotation, tx, ty);

        var bgGradientTexture:Texture = GradientTexture.create(
                600, 	//Define Width and Height to draw to, if less than defined in bgMatrix will clip the gradient
                480,
                "radial", 	//Gradient type
                [0x00a2ff, 0x0335a6], //Colours
                [1, 1], 	//Alpha values 0-1
                [0, 255], 	//Ratio, where the colour is input into the gradient space, 0 left, 255 right, can be placed anywhere between
                bgMatrix) 	//Matrix to use, optional but gives finer control of the gradient appearance

        var img:Image = new Image(bgGradientTexture)
        _bridgeGraphics.addChild(img);
    }

    private var lb:IAbstractLabel;
    private function testLabel():void
    {
        var tf:IAbstractTextField = _bridgeGraphics.requestTextField(200,100,"Larisa", "Verdana", 30);
        lb = _bridgeGraphics.requestLabelFromTextfield(tf);

        lb.x = lb.y = 250;
        _bridgeGraphics.addChild(lb);

        addEventListener(Event.ENTER_FRAME, updateLabel)

        lb.updateLabel("Larisa updated");
    }

    private function updateLabel(e:Event):void
    {
        lb.updateLabel(String(Math.random()*9999999));
    }


    private function testFLV():void
    {
        /*var f:IAbstractVideo = _bridgeGraphics.requestVideo();
        f.addVideoPath("assets/symbol5.flv");

        _bridgeGraphics.addChild(f);*/

        var vid:Video = new Video(320, 240);
        addChild(vid);

        var nc:NetConnection = new NetConnection();
        nc.connect(null);

        var ns:NetStream = new NetStream(nc);
        vid.attachNetStream(ns);

        var listener:Object = new Object();
        listener.onMetaData = function(evt:Object):void {};
        ns.client = listener;

        ns.play("assets/symbol5.flv");

        var mClip:IAbstractMovie = _bridgeGraphics.requestMovie("s");
    }

    private function testMovieClips():void
    {
        var mc:IAbstractMovie = _bridgeGraphics.requestMovie("s", 24);
        _bridgeGraphics.currentContainer.addNewChild(mc);
        mc.x = mc.y = 250;
        mc.play();

        var holder:IAbstractSprite = _bridgeGraphics.requestSprite("tete");

        var graphics:IAbstractGraphics = _bridgeGraphics.requestGraphics(holder);

        graphics.beginFill(0x000000);
        graphics.drawCircle(50, 50, 50);
        graphics.endFill();

        var dropShadow:IAbstractDropShadowFilter = _bridgeGraphics.requestDropShadowFilter();
        dropShadow.alpha = .8;
        dropShadow.blur = 5;

        var glowFilter:IAbstractGlowFilter = _bridgeGraphics.requestGlowFilter();

        var blurFilter:IAbstractBlurFilter = _bridgeGraphics.requestBlurFilter();

        //_bridgeGraphics.addDropShadowFilter(holder, dropShadow);
        //_bridgeGraphics.addGlowFilter(holder, glowFilter);
        //_bridgeGraphics.addBlurFilter(holder, blurFilter);

        _bridgeGraphics.currentContainer.addNewChild(holder);
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
        getQualifiedClassName(_bridgeGraphics.requestSprite())
        var aPool:AbstractPool = new AbstractPool("Test", 	getDefinitionByName(getQualifiedClassName(_bridgeGraphics.requestSprite())) as Class, 20);

        var testSprite:IAbstractSprite = _bridgeGraphics.requestSprite("test");
        testSprite.addNewChild(_bridgeGraphics.requestImage("Background"));
        testSprite.updateMouseGestures(_bridgeGraphics.signalsManager, true);
        _bridgeGraphics.addChild(testSprite);

        var img:IAbstractImage = _bridgeGraphics.requestImage("Background");
        var img2:IAbstractImage = _bridgeGraphics.requestImage("Background");

        var testas:IAbstractLayer = _bridgeGraphics.requestLayer("asd", 2, null, false);
        _bridgeGraphics.returnToPool(img);
        _bridgeGraphics.returnToPool(img2);
        _bridgeGraphics.returnToPool(testSprite);

        testSprite = _bridgeGraphics.requestSprite("test");
        testSprite.addNewChild(_bridgeGraphics.requestImage("Bonus-Background"));
        testSprite.updateMouseGestures(_bridgeGraphics.signalsManager, true);
        _bridgeGraphics.addChild(testSprite);
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

        _layersVO.retrieveLayer("Paytable").updateMouseGestures((_bridgeGraphics.signalsManager as ISignalsHub), true);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.DISPLAY_OBJECT_TOUCHED, doTouched);
    }

    private function doTouched(type:String, event:IAbstractSignalEvent):void
    {
        trace(type);
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

        var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
        var outLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
        
        inLayers.push(inLayer);
        if (_currentPage)
        {
            outLayers.push(_currentPage);
        }

        _bridgeGraphics.updateLayers(_paytablePagesHolder, inLayers, outLayers, _transIn, _transOut);
        _currentPage = inLayer;
    }

    private function animIn(obj1:IAbstractDisplayObject, obj2:IAbstractDisplayObject):void
    {
        TweenLite.to(obj1, Math.random()*2, { x:Math.random() * 250, onComplete:  _transIn.onTransitionComplete, onCompleteParams:[obj1, obj2]} );
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