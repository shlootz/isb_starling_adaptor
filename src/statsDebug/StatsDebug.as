/**
 * Created by adm on 27.04.15.
 */
package statsDebug {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

public class StatsDebug extends Sprite{

    public static const enabled:Boolean = false;

    private var _tf1:TextField = new TextField();

    private var _textFieldFormat:TextFormat = new TextFormat();

    public function StatsDebug() {

    }

    public function init():void
    {
        _textFieldFormat.color = 0xFFFFFF;
        _textFieldFormat.font = "Verdana";
        _textFieldFormat.size = 12;
        addChild(new Bitmap(new BitmapData(200,200,false,0xFFFFFF)));

        _tf1.setTextFormat(_textFieldFormat);

        addChild(_tf1);

        this.y = 100;
    }

    public function get tf1():TextField {
        return _tf1;
    }

    public function set tf1(value:TextField):void {
        _tf1 = value;
    }
}
}
