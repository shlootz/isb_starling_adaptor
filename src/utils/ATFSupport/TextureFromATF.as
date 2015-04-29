/**
 * Created by adm on 29.04.15.
 */
package utils.ATFSupport {
import flash.display.BitmapData;
import flash.display.BitmapEncodingColorSpace;
import flash.display.JPEGXREncoderOptions;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import starling.textures.Texture;

import starling.textures.Texture;

public class TextureFromATF {
    public function TextureFromATF() {
    }

    public static function CreateTextureFromATF(compressedData:Class):Texture
    {
        var data:ByteArray = new compressedData() as ByteArray;
        var texture:Texture = Texture.fromAtfData(data);

        return texture;
    }

    public static function CreateTextureFromByteArray(compressedData:ByteArray):Texture
    {
        var texture:Texture = Texture.fromAtfData(compressedData);

        return texture;
    }

    public static function CreateATFData(bmp:BitmapData):ByteArray
    {
        if(bmp.width != bmp.height)
            throw new ArgumentError("width and height should be equal");
        if((bmp.width & bmp.width - 1) != 0)
            throw new ArgumentError("width is " + bmp.width + "only data with power of two sizes are authorized!");
        if((bmp.height & bmp.height - 1) != 0)
            throw new ArgumentError("height is " + bmp.height + "only data with power of two sizes are authorized!");
        var ret:ByteArray = new ByteArray,
                time:uint = getTimer(),
                imgBytes:ByteArray = bmp.encode(bmp.rect, new JPEGXREncoderOptions(0, BitmapEncodingColorSpace.COLORSPACE_4_4_4));
        trace('compressed in', getTimer() - time);//this can be pretty long, if you already have jxr assets, use them!

        ret.writeUTFBytes("ATF___");//keep 3 bytes for file size;
        ret.writeByte(0x0);//flags : normal RGB888 texture
//note : this is for opaque textures, 0x1 should work for transparent textures, but doesn't, for some reason

        ret.writeByte(fastLog2n(bmp.width));//log2(width) > up to 11
        ret.writeByte(fastLog2n(bmp.height));//log2(height)
        ret.writeByte(0x1);//number of textures (mipmaps)
        writeU24(ret, imgBytes.length);// - this field seems to not be accurate in proper atf files
        ret.writeBytes(imgBytes);
        ret.position = 3;
        writeU24(ret, ret.length -6);//? without signature and fileSize, contrary to file specs.
        ret.position = 0;
        trace('atf created in', getTimer() - time);//including compression
        return ret;
    }

    private static function writeU24(ret:ByteArray, _value:uint):void
    {
        //trace("writing", _value >> 16, (_value >>16).toString(2).substr(-8));
        ret.writeByte(_value >> 16);
        //trace("writing", _value >> 8, (_value >>8).toString(2).substr(-8));
        ret.writeByte(_value >> 8);
        //trace("writing", _value, (_value).toString(2).substr(-8));
        ret.writeByte(_value);
    }
    private static function fastLog2n(_pow2:uint):uint{//only accurate for powers of two!
        var a:int=0;
        while(_pow2>1){_pow2>>=1; ++a;}
        return a;
    }
}
}
