package starlingEngine.elements 
{
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractVideo;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import signals.ISignalsHub;
	import signals.Signals;
	import starlingEngine.events.GESignalEvent;
	import starlingEngine.video.display.Video;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineVideo extends EngineSprite implements IAbstractVideo
	{
		
		private var _video:Video;
		private var _netConnection:NetConnection;
        private var _netStream:NetStream;
		private var _statsTimer:Timer = new Timer(100, 0);
		private var _prevDecodedFrames:Number = -1;
		private var _loop:Boolean = true;
		private var _path:String = "";
		private var _signalsHub:ISignalsHub;
		
		public function EngineVideo(signalsHub:ISignalsHub) 
		{
			_signalsHub = signalsHub;
			this.name = "FLV" + String(Math.random() * 999999);
		}
		
		/**
		 * 
		 * @param	path
		 */
		public function addVideoPath(path:String):void
		{
			_path = path;
			_netConnection = new NetConnection()
			_netConnection.connect(null);
			_netConnection.client = { };
			_netConnection.client.onMetaData = function ():void { };
			_netStream = new NetStream(_netConnection);
			_netStream.play(path);
			_video = new Video(_netStream, null, true, true);
			this.addChild(_video);
			
			_statsTimer.addEventListener(TimerEvent.TIMER, statsTimer_timerHandler);
			_statsTimer.start();
		}
		
		private function statsTimer_timerHandler(e:TimerEvent):void
        {
          //  trace("decoded/dropped frames:\t " + _netStream.decodedFrames +"/" + _netStream.info.droppedFrames + "\nFPS:\t" + _netStream.currentFPS.toFixed(1) + "\nvideo:\t" + _video.width + "x" + _video.height + "\ntextureClass: " + _video.texture.root.base + "\ntexture:\t" + _video.texture.root.nativeWidth + "x" + _video.texture.root.nativeHeight + "\ndraw:\t" + _video.drawTime.toFixed(2) + " ms" + "\nupload:\t" + _video.uploadTime.toFixed(2) + " ms" + "\ncomplete:\t" + (_video.drawTime + _video.uploadTime).toFixed(2) + " ms");
			if (_prevDecodedFrames != _netStream.decodedFrames)
			{
				_prevDecodedFrames = _netStream.decodedFrames;
			}
			else
			{
				if (_loop)
				{
					_netStream.seek(0);
				}
				else
				{
					_statsTimer.removeEventListener(TimerEvent.TIMER, statsTimer_timerHandler);
				}
				
				emitSignal(e);
			}
        }
		
		private function emitSignal(e:TimerEvent):void
		{
			var o:GESignalEvent = new GESignalEvent()
					o.eventName = Signals.FLV_MOVIE_ENDED;
					o.engineEvent = e;
					o.params = {loop:_loop}
					_signalsHub.dispatchSignal(Signals.FLV_MOVIE_ENDED,this.name, o);
		}
		
		/**
		 * 
		 * @param	stream
		 */
		public function addVideoStream(stream:NetStream):void
		{
			_video = new Video(stream, null, true, true);
			this.addChild(_video);
		}
		
		/**
		 * 
		 */
		public function pause():void
		{
			_netStream.pause();
		}
		
		/**
		 * 
		 */
		public function resume():void
		{
			_netStream.resume();
		}
		
		/**
		 * 
		 */
		public function stop():void
		{
			_netStream.close();
		}
		
		public function start(forceRecording:Boolean = false):void
		{
			_video.start(forceRecording);
		}
		
		/**
		 * 
		 */
		public function get stream():NetStream
		{
			return _netStream;
		}
		
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
		
		public  function resizeVideo(width:int = 800, height:int = 600):void 
		{
			_video.resizeVideo(width, height);
		}
		
	}

}