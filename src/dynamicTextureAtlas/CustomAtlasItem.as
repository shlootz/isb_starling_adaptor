/**
 * Created by adm on 09.07.15.
 */
package dynamicTextureAtlas {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

public class CustomAtlasItem extends Sprite{
    public function CustomAtlasItem() {
        this.addChild(new Bitmap(new BitmapData(100,100, false,0x000000)));
    }
}
}
