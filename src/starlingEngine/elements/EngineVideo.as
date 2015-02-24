package starlingEngine.elements 
{
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractVideo;
	import citrus.ui.starling.UI;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import signals.ISignalsHub;
	import signals.Signals;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starlingEngine.events.GESignalEvent;
	import starlingEngine.video.display.Video;
	import utils.delayedFunctionCall;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineVideo extends EngineSprite implements IAbstractVideo
	{
		
		private static const RETRIES_LIMIT:uint = 10;
		
		private var _video:Video;
		private var _netConnection:NetConnection;
        private var _netStream:NetStream;
		private var _statsTimer:Timer = new Timer(100, 0);
		private var _prevDecodedFrames:Number = -1;
		private var _loop:Boolean = true;
		private var _path:String = "";
		private var _signalsHub:ISignalsHub;
		private var _retriesCount:uint = 0;
		private var _started:Boolean = false;
		private var _assetsManager:AssetManager;
		private var _preBuffer:Boolean = false;
		private var _bufferComplete:Boolean = false;
		
		public function EngineVideo(signalsHub:ISignalsHub, assetManager:Object) 
		{
			_signalsHub = signalsHub;
			_assetsManager = assetManager as AssetManager;
			this.name = "FLV" + String(Math.random() * 999999);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * 
		 * @param	path
		 */
		public function addVideoPath(path:String, preBuffer:Boolean = true):void
		{
			_preBuffer = preBuffer;
			_path = path;
			_netConnection = new NetConnection()
			_netConnection.connect(null);
			_netConnection.client = { };
			_netConnection.client.onMetaData = function ():void { };
			_netStream = new NetStream(_netConnection);
			_netStream.play(path);
			_video = new Video(_netStream, null, true, true, this, _assetsManager);
			this.addNewChild(_video);
			
			_statsTimer.addEventListener(TimerEvent.TIMER, statsTimer_timerHandler);
			_statsTimer.start();
		}
		
		private function onAddedToStage():void
		{
			if (_prevDecodedFrames != _netStream.decodedFrames || _netStream.decodedFrames == 0)
			{
				var addedDelayedFunctionCall:delayedFunctionCall = new delayedFunctionCall(onAddedToStage, 100);
			}
			else
			{
				this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				_netStream.seek(0);
				
				if (_netStream.decodedFrames > 1 && !_started)
				{
						emitStartSignal();
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function statsTimer_timerHandler(e:TimerEvent):void
        {
          //trace("decoded/dropped frames:\t " + _netStream.decodedFrames +"/" + _netStream.info.droppedFrames + "\nFPS:\t" + _netStream.currentFPS.toFixed(1) + "\nvideo:\t" + _video.width + "x" + _video.height + "\ntextureClass: " + _video.texture.root.base + "\ntexture:\t" + _video.texture.root.nativeWidth + "x" + _video.texture.root.nativeHeight + "\ndraw:\t" + _video.drawTime.toFixed(2) + " ms" + "\nupload:\t" + _video.uploadTime.toFixed(2) + " ms" + "\ncomplete:\t" + (_video.drawTime + _video.uploadTime).toFixed(2) + " ms");
		  //trace(_prevDecodedFrames +" != " + _netStream.decodedFrames + " || " + _netStream.decodedFrames + " == 0");
		  
			if (_prevDecodedFrames != _netStream.decodedFrames || _netStream.decodedFrames == 0)
			{
				_prevDecodedFrames = _netStream.decodedFrames;
				_retriesCount = 0;
			}
			else
			{
				if (_loop)
				{
					_netStream.seek(0);
					_bufferComplete = true;
				}
				
				if (_retriesCount < RETRIES_LIMIT)
				{
					_retriesCount++
				}
				else
				{
					_bufferComplete = true;
					emitStopSignal(e);
					_statsTimer.removeEventListener(TimerEvent.TIMER, statsTimer_timerHandler);
				}
			}
        }
		
		/**
		 * 
		 */
		private function emitStartSignal():void
		{
			_started = true;
			var o:GESignalEvent = new GESignalEvent()
					o.eventName = Signals.FLV_MOVIE_STARTED;
					o.engineEvent = null;
					o.params = {loop:_loop}
					_signalsHub.dispatchSignal(Signals.FLV_MOVIE_STARTED,this.name, o);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function emitStopSignal(e:TimerEvent):void
		{
			_started = false;
			var o:GESignalEvent = new GESignalEvent()
					o.eventName = Signals.FLV_MOVIE_ENDED;
					o.engineEvent = e;
					o.params = { loop:_loop }
					if (_started)
					{
						_signalsHub.dispatchSignal(Signals.FLV_MOVIE_ENDED, this.name, o);
					}
		}
		
		/**
		 * 
		 * @param	stream
		 */
		public function addVideoStream(stream:NetStream):void
		{
			_video = new Video(stream, null, true, true, null, _assetsManager);
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
		
		public function get video():Object
		{
			return _video.video;
		}
		
		public function get bufferComplete():Boolean 
		{
			return _bufferComplete;
		}
		
	}

}