/**
 * Created by adm on 23.03.15.
 */
package starlingEngine {

import citrus.core.starling.ViewportMode;

import flash.display.Sprite;

import org.flexunit.asserts.assertTrue;

public class StarlingEngineTest extends Sprite{

    private var _engine:StarlingEngine;

    public function StarlingEngineTest() {

    }

    [Before]
    public function setUp():void {
        _engine = new StarlingEngine(new Function(), 800,600,ViewportMode.FULLSCREEN, true);
        addChild(_engine);
    }

    [After]
    public function tearDown():void {

    }

    [Test]
    public function testEngine():void {
        assertTrue(_engine.debugMode);
    }

    [Test(async, description="Async")]
    public function testEngineSprite():void {

    }
}
}
