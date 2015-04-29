/**
 * Created by adm on 27.04.15.
 */
package statsDebug {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;

public class StatsDebug extends Sprite{

    public static const enabled:Boolean = false;

    private var _tf1:TextField = new TextField();
    private var _tf2:TextField = new TextField();
    private var _tf3:TextField = new TextField();
    private var _tf4:TextField = new TextField();

    public function StatsDebug() {

    }

    public function init():void
    {
        addChild(new Bitmap(new BitmapData(200,200,true,0x000000)));
        addChild(_tf1);
        addChild(_tf2);
        addChild(_tf3);
        addChild(_tf4);

        _tf2.y = _tf1.y + _tf1.height;
        _tf3.y = _tf2.y + _tf2.height;
        _tf4.y = _tf3.y + _tf3.height;

        this.y = 100;
    }

    public function get tf1():TextField {
        return _tf1;
    }

    public function set tf1(value:TextField):void {
        _tf1 = value;
    }

    public function get tf2():TextField {
        return _tf2;
    }

    public function set tf2(value:TextField):void {
        _tf2 = value;
    }

    public function get tf3():TextField {
        return _tf3;
    }

    public function set tf3(value:TextField):void {
        _tf3 = value;
    }

    public function get tf4():TextField {
        return _tf4;
    }

    public function set tf4(value:TextField):void {
        _tf4 = value;
    }
}
}
