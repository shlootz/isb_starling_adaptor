package starlingEngine.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.LabelProperties;
	import feathers.controls.Button;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineButton extends Button implements IAbstractButton
	{
		
		private var _idName:String;
		private var _customLabel:IAbstractLabel;
		
		public function EngineButton() 
		{
			super();
			this.useHandCursor = true;
		}
		
		public function set idName(value:String):void
		{
			_idName = value;
		}
		
		public function get idName():String
		{
			return _idName;
		}
		
		override public function get width():Number
		{
			return upSkin_.width;
		}
		
		override public function get height():Number
		{
			return upSkin_.height;
		}
		
		override public function get autoFlatten () : Boolean
		{
			return super.autoFlatten;
		}
		override public function set autoFlatten (value:Boolean) : void
		{
			super.autoFlatten = value;
		}

		public function get currentState_ () : String
		{
			return super.currentState;
		}
		public function set currentState_ (value:String) : void
		{
			super.currentState = value;
		}

		public function get defaultIcon_ () : IAbstractDisplayObject
		{
			return super.defaultIcon as IAbstractDisplayObject;
		}
		public function set defaultIcon_ (value:IAbstractDisplayObject) : void
		{
			super.defaultIcon = value as DisplayObject;
		}

		override public function get defaultLabelProperties () : Object
		{
			return super.defaultLabelProperties;
		}
		override public function set defaultLabelProperties (value:Object) : void
		{
			super.defaultLabelProperties = value;
		}

		public function get defaultSelectedIcon_ () : IAbstractDisplayObject
		{
			return super.defaultSelectedIcon  as IAbstractDisplayObject;
		}
		public function set defaultSelectedIcon_ (value:IAbstractDisplayObject) : void
		{
			super.defaultSelectedIcon = value as DisplayObject;
		}

		override public function get defaultSelectedLabelProperties () : Object
		{
			return super.defaultSelectedLabelProperties;
		}
		override public function set defaultSelectedLabelProperties (value:Object) : void
		{
			super.defaultSelectedLabelProperties = value;
		}

		public function get defaultSelectedSkin_ () : IAbstractDisplayObject
		{
			return super.defaultSelectedSkin as IAbstractDisplayObject;
		}
		public function set defaultSelectedSkin_ (value:IAbstractDisplayObject) : void
		{
			super.defaultSelectedSkin = value as DisplayObject;
		}

		public function get defaultSkin_ () : IAbstractDisplayObject
		{
			return super.defaultSkin as IAbstractDisplayObject;
		}
		public function set defaultSkin_ (value:IAbstractDisplayObject) : void
		{
			super.defaultSkin = value as DisplayObject;
		}

		public function get disabledIcon_ () : IAbstractDisplayObject
		{
			return super.disabledIcon as IAbstractDisplayObject;
		}
		public function set disabledIcon_ (value:IAbstractDisplayObject) : void
		{
			super.disabledIcon = value as DisplayObject;
		}

		override public function get disabledLabelProperties () : Object
		{
			return super.disabledLabelProperties;
		}

		public function get disabledSkin_ () : IAbstractDisplayObject
		{
			return super.disabledSkin as IAbstractDisplayObject;
		}
		public function set disabledSkin_ (value:IAbstractDisplayObject) : void
		{
			super.disabledSkin = value as DisplayObject;
		}

		public function get downIcon_ () : IAbstractDisplayObject
		{
			return super.downIcon as IAbstractDisplayObject;
		}
		public function set downIcon_ (value:IAbstractDisplayObject) : void
		{
			super.downIcon = value as DisplayObject;
		}

		override public function get downLabelProperties () : Object
		{
			return super.downLabelProperties;
		}
		override public function set downLabelProperties (value:Object) : void
		{
			super.downLabelProperties = value;
		}

		public function get downSkin_ () : IAbstractDisplayObject
		{
			return super.downSkin as IAbstractDisplayObject;
		}
		public function set downSkin_ (value:IAbstractDisplayObject) : void
		{
			super.downSkin = value as DisplayObject;
		}

		override public function get gap () : Number
		{
			return super.gap;
		}
		override public function set gap (value:Number) : void
		{
			super.gap = value;
		}

		override public function get horizontalAlign () : String
		{
			return super.horizontalAlign;
		}
		override public function set horizontalAlign (value:String) : void
		{
			super.horizontalAlign = value;
		}

		public function get hoverIcon_ () : IAbstractDisplayObject
		{
			return super.hoverIcon as IAbstractDisplayObject;
		}
		public function set hoverIcon_ (value:IAbstractDisplayObject) : void
		{
			super.hoverIcon = value as DisplayObject;
		}

		override public function get hoverLabelProperties () : Object
		{
			return super.hoverLabelProperties;
		}
		override public function set hoverLabelProperties (value:Object) : void
		{
			super.hoverLabelProperties = value;
		}

		public function get hoverSkin_ () : IAbstractDisplayObject
		{
			return super.hoverSkin as IAbstractDisplayObject;
		}
		public function set hoverSkin_ (value:IAbstractDisplayObject) : void
		{
			super.hoverSkin = value as DisplayObject;
		}

		override public function get iconOffsetX () : Number
		{
			return super.iconOffsetX;
		}
		override public function set iconOffsetX (value:Number) : void
		{
			super.iconOffsetX = value;
		}

		override public function get iconOffsetY () : Number
		{
			return super.iconOffsetY;
		}
		override public function set iconOffsetY (value:Number) : void
		{
			super.iconOffsetY = value;
		}

		override public function get iconPosition () : String
		{
			return super.iconPosition;
		}
		override public function set iconPosition (value:String) : void
		{
			super.iconPosition = value;
		}

		override public function set isEnabled (value:Boolean) : void
		{
			super.isEnabled = value;
		}

		override public function get isLongPressEnabled () : Boolean
		{
			return super.isLongPressEnabled;
		}
		override public function set isLongPressEnabled (value:Boolean) : void
		{
			super.isLongPressEnabled = value;
		}

		override public function get isSelected () : Boolean
		{
			return super.isSelected;
		}
		override public function set isSelected (value:Boolean) : void
		{
			super.isSelected = value;
		}

		override public function get isToggle () : Boolean
		{
			return super.isToggle;
		}
		override public function set isToggle (value:Boolean) : void
		{
			super.isToggle = value;
		}

		override public function get label () : String
		{
			return super.label;
		}
		override public function set label (value:String) : void
		{
			super.label = value;
		}

		override public function get labelFactory () : Function
		{
			return super.labelFactory;
		}
		override public function set labelFactory (value:Function) : void
		{
			super.labelFactory = value;
		}

		override public function get labelOffsetX () : Number
		{
			return super.labelOffsetX;
		}
		override public function set labelOffsetX (value:Number) : void
		{
			super.labelOffsetX = value;
		}

		override public function get labelOffsetY () : Number
		{
			return super.labelOffsetY;
		}
		override public function set labelOffsetY (value:Number) : void
		{
			super.labelOffsetY = value;
		}

		override public function get longPressDuration () : Number
		{
			return super.longPressDuration;
		}
		override public function set longPressDuration (value:Number) : void
		{
			super.longPressDuration = value;
		}

		override public function get padding () : Number
		{
			return super.padding;
		}
		override public function set padding (value:Number) : void
		{
			super.padding = value;
		}

		override public function get paddingBottom () : Number
		{
			return super.paddingBottom;
		}
		override public function set paddingBottom (value:Number) : void
		{
			super.paddingBottom = value;
		}

		override public function get paddingLeft () : Number
		{
			return super.paddingLeft;
		}
		override public function set paddingLeft (value:Number) : void
		{
			super.paddingLeft = value;
		}

		override public function get paddingRight () : Number
		{
			return super.paddingRight;
		}
		override public function set paddingRight (value:Number) : void
		{
			super.paddingRight = value;
		}

		override public function get paddingTop () : Number
		{
			return super.paddingTop;
		}
		override public function set paddingTop (value:Number) : void
		{
			super.paddingTop = value;
		}

		public function get selectedDisabledIcon_ () : IAbstractDisplayObject
		{
			return super.selectedDisabledIcon as IAbstractDisplayObject;
		}
		public function set selectedDisabledIcon_ (value:IAbstractDisplayObject) : void
		{
			super.selectedDisabledIcon = value as DisplayObject;
		}

		override public function get selectedDisabledLabelProperties () : Object
		{
			return super.selectedDisabledLabelProperties;
		}
		override public function set selectedDisabledLabelProperties (value:Object) : void
		{
			super.selectedDisabledLabelProperties = value;
		}

		public function get selectedDisabledSkin_ () : IAbstractDisplayObject
		{
			return super.selectedDisabledSkin as IAbstractDisplayObject;
		}
		public function set selectedDisabledSkin_ (value:IAbstractDisplayObject) : void
		{
			super.selectedDisabledSkin = value as DisplayObject;
		}

		public function get selectedDownIcon_ () : IAbstractDisplayObject
		{
			return super.selectedDownIcon as IAbstractDisplayObject;
		}
		public function set selectedDownIcon_ (value:IAbstractDisplayObject) : void
		{
			super.selectedDownIcon = value as DisplayObject;
		}

		override public function get selectedDownLabelProperties () : Object
		{
			return super.selectedDownLabelProperties;
		}
		override public function set selectedDownLabelProperties (value:Object) : void
		{
			super.selectedDownLabelProperties = value;
		}

		public function get selectedDownSkin_ () : IAbstractDisplayObject
		{
			return super.selectedDownSkin as IAbstractDisplayObject;
		}
		public function set selectedDownSkin_ (value:IAbstractDisplayObject) : void
		{
			super.selectedDownSkin = value as DisplayObject;
		}

		public function get selectedHoverIcon_ () : IAbstractDisplayObject
		{
			return super.selectedHoverIcon as IAbstractDisplayObject;
		}
		public function set selectedHoverIcon_ (value:IAbstractDisplayObject) : void
		{
			super.selectedHoverIcon = value as DisplayObject;
		}

		override public function get selectedHoverLabelProperties () : Object
		{
			return super.selectedHoverLabelProperties;
		}
		override public function set selectedHoverLabelProperties (value:Object) : void
		{
			super.selectedHoverLabelProperties = value;
		}

		public function get selectedHoverSkin_ () : IAbstractDisplayObject
		{
			return super.selectedHoverSkin as IAbstractDisplayObject;
		}
		public function set selectedHoverSkin_ (value:IAbstractDisplayObject) : void
		{
			super.selectedHoverSkin = value as DisplayObject;
		}

		public function get selectedUpIcon_ () : IAbstractDisplayObject
		{
			return super.selectedUpIcon as IAbstractDisplayObject;
		}
		public function set selectedUpIcon_ (value:IAbstractDisplayObject) : void
		{
			super.selectedUpIcon = value as DisplayObject;
		}

		override public function get selectedUpLabelProperties () : Object
		{
			return super.selectedUpLabelProperties;
		}
		override public function set selectedUpLabelProperties (value:Object) : void
		{
			super.selectedUpLabelProperties = value;
		}

		public function get selectedUpSkin_ () : IAbstractDisplayObject
		{
			return super.selectedUpSkin as IAbstractDisplayObject;
		}
		public function set selectedUpSkin_ (value:IAbstractDisplayObject) : void
		{
			super.selectedUpSkin = value as DisplayObject;
		}

		public function get stateNames_ () : Vector.<String>
		{
			return super.stateNames;
		}

		override public function get stateToIconFunction () : Function
		{
			return super.stateToIconFunction;
		}
		override public function set stateToIconFunction (value:Function) : void
		{
			super.stateToIconFunction = value;
		}

		override public function get stateToLabelPropertiesFunction () : Function
		{
			return super.stateToLabelPropertiesFunction;
		}
		override public function set stateToLabelPropertiesFunction (value:Function) : void
		{
			super.stateToLabelPropertiesFunction = value;
		}

		override public function get stateToSkinFunction () : Function
		{
			return super.stateToSkinFunction;
		}
		override public function set stateToSkinFunction (value:Function) : void
		{
			super.stateToSkinFunction = value;
		}

		public function get upIcon_ () : IAbstractDisplayObject
		{
			return super.upIcon as IAbstractDisplayObject;
		}
		public function set upIcon_ (value:IAbstractDisplayObject) : void
		{
			super.upIcon = value as DisplayObject;
		}

		override public function get upLabelProperties () : Object
		{
			return super.upLabelProperties;
		}
		override public function set upLabelProperties (value:Object) : void
		{
			super.upLabelProperties = value;
		}

		public function get upSkin_ () : IAbstractDisplayObject
		{
			return super.upSkin as IAbstractDisplayObject;
		}
		public function set upSkin_ (value:IAbstractDisplayObject) : void
		{
			super.upSkin = value as DisplayObject;
		}

		override public function get verticalAlign () : String
		{
			return super.verticalAlign;
		}
		override public function set verticalAlign (value:String) : void
		{
			super.verticalAlign = value;
		}

		public function autoSizeIfNeeded_ () : Boolean
		{
			return super.autoSizeIfNeeded();
		}

		public function button_removedFromStageHandler_ (event:Event) : void
		{
			super.button_removedFromStageHandler(event);
		}

		public function createLabel_ () : void
		{
			super.createLabel();
		}

		public function draw_ () : void
		{
			super.draw();
		}

		public function focusInHandler_ (event:Event) : void
		{
			super.focusInHandler(event);
		}

		public function focusOutHandler_ (event:Event) : void
		{
			super.focusOutHandler(event);
		}

		public function layoutContent_ () : void
		{
			super.layoutContent();
		}

		public function longPress_enterFrameHandler_ (event:Event) : void
		{
			super.longPress_enterFrameHandler(event);
		}

		public function positionLabelAndIcon_ () : void
		{
			super.positionLabelAndIcon();
		}

		public function positionSingleChild_ (displayObject:IAbstractDisplayObject) : void
		{
			super.positionSingleChild(displayObject as DisplayObject);
		}

		public function refreshIcon_ () : void
		{
			super.refreshIcon();
		}

		public function refreshLabel_ () : void
		{
			super.refreshLabel();
		}

		public function refreshLabelStyles_ () : void
		{
			super.refreshLabelStyles();
		}

		public function refreshMaxLabelWidth_ (forMeasurement:Boolean) : void
		{
			super.refreshMaxLabelWidth(forMeasurement);
		}

		public function refreshSkin_ () : void
		{
			super.refreshSkin();
		}

		public function scaleSkin_ () : void
		{
			super.scaleSkin();
		}
		
		public function addCustomLabel(customLabel:IAbstractLabel, align:String = "center", customAlign:Point = null):void
		{
			_customLabel = customLabel;
			this.addChild(_customLabel as DisplayObject);
			alignLabel(align, customAlign);
		}
		
		public function get customLabel():IAbstractLabel
		{
			return _customLabel;
		}
		
		public function updateCustomLabel(labelText:String):void
		{
			_customLabel.updateLabel(labelText);
		}
		
		private function alignLabel(align:String = "center", customAlign:Point = null):void
		{
			switch(align)
			{
				case LabelProperties.ALIGN_CENTER:
					_customLabel.x = int(this.upSkin.width / 2 - _customLabel.width / 2);
					_customLabel.y = int(this.upSkin.height / 2 - _customLabel.height / 2);
				break;
				
				case LabelProperties.ALIGN_BOTTOM:
					_customLabel.x = int(this.upSkin.width / 2 - _customLabel.width / 2);
					_customLabel.y = int(this.upSkin.height - _customLabel.height / 2);
				break;
				
				case LabelProperties.ALIGN_TOP:
					_customLabel.x = int(this.upSkin.width / 2 - _customLabel.width / 2);
					_customLabel.y = 0;
				break;
				
				case LabelProperties.ALIGN_LEFT:
					_customLabel.x = 0;
					_customLabel.y =  int(this.upSkin.height / 2 - _customLabel.height / 2);
				break;
				
				case LabelProperties.ALIGN_RIGHT:
					_customLabel.x = int(this.upSkin.width - _customLabel.width / 2);
					_customLabel.y = int(this.upSkin.height / 2 - _customLabel.height / 2);
				break;
				
				case LabelProperties.ALIGN_CUSTOM:
					_customLabel.x = customAlign.x;
					_customLabel.y = customAlign.y;
				break;
			}
			
		}
		
	}

}