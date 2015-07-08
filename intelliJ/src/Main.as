package {

import bridge.BridgeGraphics;
import bridge.IBridgeGraphics;
import bridge.abstract.AbstractPool;
import bridge.abstract.IAbstractDisplayObject;
import bridge.abstract.IAbstractGraphics;
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractLayer;
import bridge.abstract.IAbstractMask;
import bridge.abstract.IAbstractMovie;
import bridge.abstract.IAbstractSprite;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.IAbstractVideo;
import bridge.abstract.filters.IAbstractBlurFilter;
import bridge.abstract.ui.IAbstractButton;
import bridge.abstract.ui.IAbstractComboBox;
import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
import bridge.abstract.ui.IAbstractLabel;

import citrus.core.State;

import com.greensock.TweenLite;
import com.greensock.easing.Cubic;
import com.greensock.easing.Elastic;
import com.greensock.easing.Linear;

import feathers.controls.TextArea;
import feathers.controls.text.TextFieldTextRenderer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.display.Stage3D;
import flash.display3D.Context3D;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.textures.VideoTexture;
import flash.events.Event;
import flash.events.VideoTextureEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.text.GridFitType;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.ByteArray;

import nape.geom.Mat23;

import signals.ISignalsHub;
import signals.SignalsHub;

import starling.core.Starling;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite3D;
import starling.filters.WarpFilter;

//import starling.display.Sprite3D;

import starling.filters.ColorMatrixFilter;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.textures.ConcreteTexture;
import starling.utils.getNextPowerOfTwo;

import starlingEngine.elements.EngineDisplayObject;
import starlingEngine.elements.EngineDisplayObjectContainer;
import starlingEngine.elements.EngineLabel;
import starlingEngine.elements.EngineLayer;
import starlingEngine.elements.EngineTextField;

import starlingEngine.signals.Signals;
import starlingEngine.ui.EngineComboBoxItemRenderer;

import utils.ATFSupport.TextureFromATF;

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

    [SWF(frameRate="30", width="800", height="600",backgroundColor="0x333333")]

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

    public function Main() {
    // _bridgeGraphics.engine.is3D = true;
        addChild(_bridgeGraphics.engine as DisplayObject);
        (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, loadAssets);
    }

    private function loadAssets(event:String, obj:Object):void
    {
        (_bridgeGraphics.assetsManager as AssetManager).enqueue(
            "assets/atf/PaytableModuleAssets.xml",
            "assets/atf/PaytableModuleSkin.atf",
            "assets/UserInterfaceModuleGameplayButtonsLayerLayout.xml",
            "assets/StripModuleStripLayerLayout.xml",
            "assets/BackgroundModuleAssets.png",
            "assets/BackgroundModuleAssets.xml"
        );
        (_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void {
            trace("Loading assets, progress:", ratio);
            if (ratio == 1) {
  //              buildMenu();
                buildSymbols();
                //testTextFields();
                //testMovieClips();
//                for(var i:uint = 0; i<20; i++)
//                {
//                    testAutoSize();
//                    testFeathersText();
//                }

                //testComboBox();
                //testATF();
                //testMovieClipFlip();
                //testAtlas();
                //testVideoTexture();
//              //testSprite3D();
                //testFilters();
                //testButtons();
//                initImages();
//                testWarpEffect("close");
            }
        });
    }

    private function buildSymbols():void
    {
        var spr:Sprite3D = new Sprite3D();
        for(var i:uint = 0; i<200; i++)
        {
            var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Symbol");
            mc.x = Math.random()*800;
            mc.y = Math.random()*600;
            mc.play();
            spr.addChild(mc as starling.display.DisplayObject);

        }

        spr.rotationX = .3;
        spr.rotationY = .3;

        _bridgeGraphics.currentContainer.addNewChild(spr);
    }

    private var warpFilter:WarpFilter;
    private var imgToWarp:IAbstractImage;
    private var endPoint:Point = new Point(300,300);
    private var hideBehind:IAbstractImage;

    private var closeSettings:Object = {
        l1:.5,
        l2:0,
        l3:0,
        l4:0,
        r1:.5,
        r2:1,
        r3:1,
        r4:1
    }

    private var openSetings:Object = {
        l1:0,
        l2:0,
        l3:0,
        l4:0,
        r1:1,
        r2:1,
        r3:1,
        r4:1
    }

    private function initImages():void
    {
        warpFilter = new WarpFilter();

        imgToWarp = _bridgeGraphics.requestImage("Generic-Page");
        hideBehind = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(300, 100, false, 0x000000));

        imgToWarp.x = 100;
        imgToWarp.y = 100;

        imgToWarp.width = 400;
        imgToWarp.height = 400;

        hideBehind.x = 200;
        hideBehind.y = 350;

        _bridgeGraphics.currentContainer.addNewChild(imgToWarp);
        //_bridgeGraphics.currentContainer.addNewChild(hideBehind);
        _bridgeGraphics.addFragmentFilter(imgToWarp, warpFilter);
    }

    private function testWarpEffect(type:String):void
    {

        var destination:Point;

        if(type == "open")
        {
            trace("OPEN");
            TweenLite.to(warpFilter, .5, {l1:openSetings.l1, r1:openSetings.r1, l2:openSetings.l2, r2:openSetings.r2, l3:openSetings.l3, r3:openSetings.r3, l4:openSetings.l4, r4:openSetings.r4, ease:Cubic.easeInOut, onComplete:function():void{
                //TweenLite.to(warpFilter, 1, {l3:10, l4:10, r3:-10, r4:-10});
                //TweenLite.to(imgToWarp, 1, {y:destination.y});
                testWarpEffect("close");
            }});
        }
        if(type == "close")
        {
            trace("CLOSE");
            TweenLite.to(warpFilter, .5, {l1:closeSettings.l1, r1:closeSettings.r1, l2:closeSettings.l2, r2:closeSettings.r2, l3:closeSettings.l3, r3:closeSettings.r3, l4:closeSettings.l4, r4:closeSettings.r4, ease:Cubic.easeIn, onComplete:function():void{
                TweenLite.to(warpFilter, .5, {l1:10, l2:10, r1:-10, r2:-10, onComplete:function():void{testWarpEffect("open");}});
                //TweenLite.to(imgToWarp, 1, {y:destination.y});
               // testWarpEffect("open");
            }});
        }
    }

    private function testButtons():void
    {
        var layer:IAbstractLayer = _bridgeGraphics.requestLayer("test",1,(_bridgeGraphics.assetsManager as AssetManager).getXml("UserInterfaceModuleGameplayButtonsLayerLayout"),true);
        _bridgeGraphics.drawLayerLayout(layer);
        _bridgeGraphics.currentContainer.addNewChild(layer);
    }

    private function testFilters():void
    {
        var cmf:ColorMatrixFilter = new ColorMatrixFilter();
    }

    private function testSprite3D():void
    {
//        var spr:Sprite3D = new Sprite3D;
    }

    private var vidClient:Object;
    private var cTexture:ConcreteTexture;
    private var vTexture:VideoTexture;
    private var nc:NetConnection;
    private var ns:NetStream;
    private var image:Image;
    private var context3D:Context3D;
    private function testVideoTexture():void
    {
        trace( this, "supports video texture", Context3D.supportsVideoTexture );
        context3D = Starling.context;

        vidClient = new Object();
        vidClient.onMetaData = onMetaData;

        nc = new NetConnection();
        nc.connect(null);

        ns = new NetStream(nc);
        ns.client = vidClient;
        ns.play("assets/test.mp4");

        vTexture = context3D.createVideoTexture();
        vTexture.attachNetStream(ns);
        vTexture.addEventListener(VideoTextureEvent.RENDER_STATE, renderFrame);

        cTexture = new ConcreteTexture(vTexture, Context3DTextureFormat.BGRA, 800, 600, false, true, true);

        image = new Image(cTexture);
        _bridgeGraphics.addChild(image);
    }

    private function renderFrame(e:VideoTextureEvent):void
    {
        //
    }

    private function onMetaData(metadata:Object):void
    {
        //
    }

    private function testAtlas():void
    {
        _bridgeGraphics.storeAtlasATF("asd", _bridgeGraphics.getXMLFromAssetsManager("PaytableModuleAssets"), new ByteArray());
    }

    private function testMovieClipFlip():void
    {
        var btn:IAbstractButton = _bridgeGraphics.requestButton("asa");

        var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Paytable-Line-");
        var mc2:IAbstractMovie = _bridgeGraphics.requestMovie("Paytable-Line-");

        mc.play();
        mc2.play();

        btn.upSkin_ = mc;
        btn.hoverSkin_ = mc2;

        btn.x = 0;
        btn.y = 0;

        btn.pivotX = btn.width/2;
        btn.pivotY = btn.height/2;
        btn.scaleX = -1;

        _bridgeGraphics.currentContainer.addNewChild(btn);

        trace("!!!!!!!!!! "+mc.isPlaying);
    }

    private function testATF():void
    {
        //var bmpData:BitmapData = new BitmapData(256,256,false, 0x000000);
        //var img:Image = new Image(TextureFromATF.CreateTextureFromByteArray(TextureFromATF.CreateATFData(bmpData)));

        var newImg:IAbstractImage = _bridgeGraphics.requestImage("Paytable-ScrollBonus-Prew");
        newImg.x = 200;
        newImg.y = 200;
        _bridgeGraphics.addChild(newImg);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function testComboBox():void
    {
        var dp:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>();
        var bkImage:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(200,30, false, 0xff0000));
        for (var i:uint = 0; i<10; i++)
        {
            dp.push(new EngineComboBoxItemRenderer(String(Math.random()*9999)));
        }
        var cb:IAbstractComboBox = _bridgeGraphics.requestComboBox(dp, 200,30, bkImage, "Verdana");

        _bridgeGraphics.currentContainer.addNewChild(cb);
        cb.x = 200;
        cb.y = 200;
    }

    private function testAutoSize():void
    {
        var al:IAbstractLabel;
       //var theText:String = "ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ARRÊTER AUTO SPIN ";
       //var theText:String = "APUESTA MAX.";
       //var theText:String = "SCROLLS OF RA BONUS SYMBOLS ON REELS 1, 3 AND 5 AT THE SAME TIME WILL ACTIVATE THE INSTANT BONUS";
       var theText:String = "";
       var val:Number = Math.round(Math.random()*999);
       //var theText:String = "10";

        var tf:IAbstractTextField = _bridgeGraphics.requestTextField(59.92, 76.09, theText,"Verdana", 30);
        tf.nativeFilters = new Array((new DropShadowFilter(1, 45, 0xFF0000, 1, 3 , 3)));
        //var tf:IAbstractTextField = _bridgeGraphics.requestTextField(60.95, 77.75, theText,"Verdana", 20);
        tf.autoScale = true;

        al = _bridgeGraphics.requestLabelFromTextfield(tf);
        al.x = Math.random()*800;
        al.y = Math.random()*600;

        _bridgeGraphics.currentContainer.addNewChild(al);

        addEventListener(Event.ENTER_FRAME, function (e:Event):void{
            val = val+10;
            al.updateLabel(String(val));
        });

        //al.updateLabel("PARAR AS\nVOLTAS\nAUTOMÁTICAS");

        //var btn:IAbstractButton = _bridgeGraphics.requestButton("test");
        //btn.addCustomLabel(al);

        //btn.x = 200;
        //btn.y = 200;

        //_bridgeGraphics.currentContainer.addNewChild(btn);
    }

    private function testFeathersText():void
    {
        var val:Number = Math.round(Math.random()*999);
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.text = "About binomial theorem I'm teeming with a lot o' news";

        textRenderer.textFormat = new TextFormat( "Arial", 20, 0x000000 );
        textRenderer.embedFonts = false;

        textRenderer.width = 10+Math.round(Math.random()*100);
        textRenderer.wordWrap = true;

        addEventListener(Event.ENTER_FRAME, function (e:Event){
            val = val+10;
            //textRenderer.text = (String(val));
        });

        textRenderer.x = Math.random()*800;
        textRenderer.y = Math.random()*600;

        _bridgeGraphics.currentContainer.addNewChild(textRenderer);
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

        _bridgeGraphics.pauseRender();

        addEventListener(Event.ENTER_FRAME, checkRender);
    }

    private function checkRender(e:Event):void
    {
        if(!_bridgeGraphics.contextStatus())
        {
            _bridgeGraphics.pauseRender();
        }
        else
        {
            _bridgeGraphics.resumeRender();
        }
    }

    private var l:IAbstractLabel;
    private function testTextFields():void
    {
        var t:IAbstractTextField = _bridgeGraphics.requestTextField(50,100, "1234567890", "Verdana", 100, 0x000000);
        t.hAlign = HAlign.LEFT;
        t.vAlign = VAlign.TOP;
        l = _bridgeGraphics.requestLabelFromTextfield(t);

        //var q:IAbstractImage = _bridgeGraphics.requestImageFromBitmapData(new BitmapData(t.textBounds.width, t.textBounds.height,false, 0x000000));

        //_bridgeGraphics.currentContainer.addNewChild(q);
        _bridgeGraphics.currentContainer.addNewChild(l);

        l.x = 150;
        l.y = 150;
        //q.x = 150;
        //q.y = 150;

        l.updateLabel("12345 67890",true);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);

        var interval:delayedFunctionCall = new delayedFunctionCall(loseContext, 500)
    }

    private function loseContext():void
    {
        Starling.context.dispose();
        var interval:delayedFunctionCall = new delayedFunctionCall(loseContext, 500)
    }

    private var _filter:ColorMatrixFilter;
    private var _val:Number = 0;
    private var _reverse:Boolean = false;

    private function buildMenu():void
    {

        var layout:XML = _bridgeGraphics.getXMLFromAssetsManager("StripModuleStripLayerLayout");
        var layer:IAbstractLayer = _bridgeGraphics.requestLayer("UI", 1, layout, true);
        var inLayers:Vector.<IAbstractLayer> = new Vector.<IAbstractLayer>();
        var holder:IAbstractSprite = _bridgeGraphics.requestSprite("asd");

        inLayers.push(layer)

        _bridgeGraphics.updateLayers(holder , inLayers);

        _bridgeGraphics.addChild(holder);

        _filter = new ColorMatrixFilter();

        var textFields:Array = new Array();

        textFields.push(layer.getElement("stripBalanceLabel"));
        textFields.push(layer.getElement("stripWinLabel"));
        textFields.push(layer.getElement("stripTotalBetLabel"));
        textFields.push(layer.getElement("stripWinValueLabel"));
        textFields.push(layer.getElement("stripBalanceValueLabel"));
        textFields.push(layer.getElement("stripTotalBetValueLabel"));
        textFields.push(layer.getElement("stripCreditLabel"));
        textFields.push(layer.getElement("stripCreditValueLabel"));

        trace((_bridgeGraphics.engine as StarlingEngine).createGroupOfLabels(textFields));

        _bridgeGraphics.addFragmentFilter(holder, _filter);
    }

    private var increment:Number = 0;
    var images:Array = ["Next-Button-Disable", "Next-Button-Down", "Next-Button-Over", "Next-Button-Up", "Page-Option-Down", "Page-Option-Over", "Page-Option-Up", "Paytable-Line-1", "Paytable-Line-2", "Paytable-Line-3", "Paytable-Line-4", "Paytable-Line-5", "Paytable-Line-6", "Paytable-Line-7", "Paytable-Line-8", "Paytable-Line-9", "Paytable-Line-10", "Paytable-Line-11", "Paytable-Line-12", "Paytable-Line-13", "Paytable-Line-14", "Paytable-Line-15", "Paytable-Line-16", "Paytable-Line-17", "Paytable-Line-18", "Paytable-Line-19"]

    private function onEnterFrame(e:Event):void
    {
        //var size:uint = getNextPowerOfTwo(Math.random()*11);
        //var bmpData:BitmapData = new BitmapData(size,size,false, Math.random()*0xffffff);
        //var img:Image = new Image(TextureFromATF.CreateTextureFromByteArray(TextureFromATF.CreateATFData(bmpData)));

//        var img:IAbstractImage = _bridgeGraphics.requestImage(images[Math.floor(Math.random()*images.length)]);
//
//        img.x = Math.random()*800;
//        img.y = Math.random()*600;
//
//        _bridgeGraphics.currentContainer.addNewChild(img);
        //bmpData.dispose();
        l.updateLabel(String(Math.random()*999999));
    }
}
}
