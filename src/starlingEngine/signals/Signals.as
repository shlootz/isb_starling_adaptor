package starlingEngine.signals 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Some default signals already used within the engine
	 */
	public class Signals 
	{
		//Context signals
		public static const CONTEXT_3D_RESTORED:String = "GEContext3DRestored";
		
		//General signals
		public static const CHANGE_GRAPHICS_STATE:String = "GEchangeGraphicsState"
		public static const REMOVE_AND_DISPOSE:String = "GERemoveAndDispose"
		
		//Layer tranzition in complete
		public static const LAYER_TRANSITION_IN_COMPLETE:String = "GElayerTransitionInComplete"
		
		//Layer tranzition out complete
		public static const LAYER_TRANSITION_OUT_COMPLETE:String = "GElayerTransitionOutComplete"
		
		//Init signals
		public static const STARLING_READY:String = "GEstarlingReady"
		
		//Generic button
		public static const GENERIC_BUTTON_PRESSED:String = "GEbuttonPressed"
		public static const GENERIC_BUTTON_OVER:String = "GEbuttonOver"
		public static const GENERIC_BUTTON_ENDED:String = "GEbuttonEnded"
		public static const GENERIC_BUTTON_OUT:String = "GEbuttonOut"
		
		//Stage
		public static const MOUSE_WHEEL:String = "EMouseWheel"
		
		//Generic slider changed
		public static const GENERIC_SLIDER_CHANGE:String = "GEsliderChanged"
		
		//Generic toggle Button
		public static const GENERIC_TOGGLE_BUTTON_PRESSED:String = "GEtoggleButtonPressed"
		
		//Generic movieclip ended
		public static const MOVIE_CLIP_ENDED:String = "GEmovieClipEnded"
		
		//Some display object has been touched, either by a touch event or mouse event
		public static const DISPLAY_OBJECT_TOUCHED:String = "GEdisplayObjectTouched"
		
		//Generic list item signal
		public static const LIST_ITEM_TOUCHED_INTERNAL:String = "GElistItemTouchedInternal";
		public static const LIST_ITEM_TOUCHED:String = "GElistItemTouched";
		
		//Generic list item signal
		public static const TEXT_INPUT_CHANGED:String = "GETextInputChanged";
		public static const TEXT_INPUT_FOCUS_IN:String = "GETextInputFocusIn";
		public static const TEXT_INPUT_FOCUS_OUT:String = "GETextInputFocusOut";
		
		//Particles signal
		public static const PARTICLE_SYSTEM_COMPLETED:String = "GEParticleSystemCompleted";
		
		//FLV
		public static const FLV_MOVIE_ENDED:String = "GEFLVMovieEnded";
		public static const FLV_MOVIE_STARTED:String = "GEFLVMovieStarted";
	}

}