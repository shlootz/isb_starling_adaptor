/**
 * Created by adm on 09.07.15.
 */
package dynamicTextureAtlas {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class CustomBitmapData extends CustomAtlasItem{
    public function CustomBitmapData(width:Number, height:Number, visible:Boolean = true, color:uint = 0x000000) {
        super(width, height);
        this.addChild(new Bitmap(new BitmapData(width,height, visible,color)));
    }
}
}
