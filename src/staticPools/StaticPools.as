/**
 * Created by adm on 01.07.15.
 */
package staticPools {
import starling.text.TextField;

public class StaticPools {

    public static var bufferedTextField:TextField;

    public function StaticPools() {
    }

    public static function textBuffer():void
    {
        bufferedTextField = new TextField(500, 500, "0", "Verdana", 50);
    }
}
}
