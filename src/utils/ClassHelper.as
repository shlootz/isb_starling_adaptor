/**
 * Created by adm on 06.03.15.
 */
package utils {
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class ClassHelper {
    public function ClassHelper() {

    }
    public static function getClass(obj:Object):Class {

        return Class(getDefinitionByName(getQualifiedClassName(obj)));
    }
}
}
