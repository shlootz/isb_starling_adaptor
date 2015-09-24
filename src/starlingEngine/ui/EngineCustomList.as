package starlingEngine.ui 
{
	import feathers.controls.List;
	/**
	 * ...
	 * @author ...
	 */
	public class EngineCustomList extends List
	{
		
		public function EngineCustomList() 
		{
			super();
			this.setInvalidationFlag(INVALIDATION_FLAG_STYLES);
		}
		
	}

}