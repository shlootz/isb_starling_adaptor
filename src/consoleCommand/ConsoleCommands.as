package consoleCommand {
	import bridge.abstract.console.IConsoleCommands;
	import citrus.core.Console;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ConsoleCommands implements IConsoleCommands
	{
		
		private var _console:Console;
		
		/**
		 * 
		 * @param	console
		 */
		public function ConsoleCommands(console:Console) 
		{
			_console = console;
            _console.enabled = false;
		}
		
		/**
		 * 
		 * @param	name
		 * @param	listener
		 */
		public function registerCommand(name:String, listener:Function):void
		{
			_console.addCommand(name, listener);
		}
		
	}

}