/**
 * Created by adm on 02.07.15.
 */
package fpsManager{
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;

public class FPSManager extends Sprite{

    private static var _instance:FPSManager;

    private var _intervarls:Vector.<uint> = new <uint>[25,25,30,40,45,50,60,60];
    private var _step:uint = 4;

    public var currentFPS:int = 60;

    public function FPSManager(s:SingletonEnforcer) {
        if (s == null) throw new Error("Singleton, use MySingleton.instance");
    }

    public static function get instance():FPSManager {
        if (_instance == null)
            _instance = new FPSManager(new SingletonEnforcer());
        return _instance;
    }

    public function init():void
    {
        addEventListener(Event.ENTER_FRAME, calculateFPS);
    }

    private var frameCount:int = 0;
    private var totalTime:Number = 0;
    public function calculateFPS(e:EnterFrameEvent):void
    {
        totalTime += e.passedTime;
        if (++frameCount % 60 == 0)
        {
            currentFPS = frameCount / totalTime
            changeFPS();
            frameCount = totalTime = 0;
        }
    }

    public function changeFPS():void
    {
        _step = Math.floor(currentFPS/10);
        Starling.current.nativeStage.frameRate = _intervarls[_step];
        //trace(_step+" "+_intervarls[_step]+" for "+currentFPS);
    }
}
}
class SingletonEnforcer {}