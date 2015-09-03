/**
 * Created by adm on 02.07.15.
 */
package fpsManager{
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;

public class FPSManager extends Sprite{

    private static var BALANCED_OFFSET:int = 5;
    private static var NON_OPTIMISTICAL_OFFSET:int = -10;
    private static var AUTOMATIC:int = 0;

    private static var _instance:FPSManager;

    public var alertCallback:Function;
    public var level:int = FPSManager.AUTOMATIC;

    private var _intervarls:Vector.<uint> = new <uint>[10,20,30,40,50,60,60];
    private var _step:uint = 4;
    private var _currentCap:uint;
    private var _currentLevel:uint = 5;

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
            frameCount = totalTime = 0;

            if(currentFPS == _intervarls[_currentLevel])
            {
                _currentLevel++
                if(_currentLevel < 6) {
                    currentFPS = _intervarls[_currentLevel];
                }
            }

            changeFPS();
        }
    }

    public function changeFPS():void
    {
        alertCallback.call();
        _step = Math.floor((currentFPS-1)/10);
		if (_step < _intervarls.length)
		{
			Starling.current.nativeStage.frameRate = _intervarls[_step] + level;
		}
        _currentCap = _intervarls[_step];
        _currentLevel = _step;
    }

    public function get currentCap():uint
    {
        return _currentCap;
    }
}
}
class SingletonEnforcer {}