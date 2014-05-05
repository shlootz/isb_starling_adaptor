package starlingEngine.elements 
{
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractVideo;
	import flash.net.NetConnection;
	import flash.net.NetStream;
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
		
		public function EngineVideo() 
		{
			
		}
		
		/**
		 * 
		 * @param	path
		 */
		public function addVideoPath(path:String):void
		{
			_netConnection = new NetConnection()
			_netConnection.connect(null);
			_netConnection.client = { };
			_netConnection.client.onMetaData = function ():void { };
			_netStream = new NetStream(_netConnection);
			_netStream.play(path);
			_video = new Video(_netStream); 
			
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
		
	}

}