/**
 * Created by adm on 02.07.15.
 */
package fontManager{
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Dictionary;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;
import starling.extensions.textureAtlas.DynamicAtlas;

public class FontManager extends Sprite{

    static protected var fontAtlasses:Dictionary = new Dictionary();

    public function FontManager() {

    }

    public static function registerBitmapFont(width:Number, height:Number, text:String, font:String = "Verdana", size:Number = 12, color:Number = 0x000000, filters:Array = null, charMarginX:int = 0, customID:String = ""):void
    {
        var nativeTF:flash.text.TextField = new flash.text.TextField();
        nativeTF.width = width;
        nativeTF.height = height;
        nativeTF.text = text;
//        nativeTF.filters = filters;

        var nativeTFFormat:TextFormat = new TextFormat();
        nativeTFFormat.font = font;
        nativeTFFormat.size = size;
        nativeTFFormat.color = color;
        nativeTF.defaultTextFormat = nativeTFFormat;

        DynamicAtlas.bitmapFontFromTextField(nativeTF, charMarginX);

//        var newFontOBJ:FontOBJ = new FontOBJ();

//        if(fontAtlasses[size] == null)
//        {
//            fontAtlasses[size] = newFontOBJ;
//            DynamicAtlas.bitmapFontFromTextField(nativeTF, charMarginX);
//        }
//            else
//        {
//            (fontAtlasses[size] as FontOBJ).chars += text;
//            DynamicAtlas.bitmapFontFromTextField(nativeTF, charMarginX);
//        }
    }
}
}

import starling.textures.TextureAtlas;

class FontOBJ
{
    public var chars:String;
    public var size:int;
    public var fontName:String;
    public var filters:Array;
    public var atlas:TextureAtlas;

    public function FontOBJ() {

    }
}