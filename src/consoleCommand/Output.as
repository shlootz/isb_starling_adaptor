package consoleCommand 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Output 
	{
		public static var verbose:Boolean = false;
		
		public static function out(obj:Object):void
		{
			if(verbose) trace(String(obj));
		}
	}

}