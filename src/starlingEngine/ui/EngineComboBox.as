package starlingEngine.ui 
{
import bridge.abstract.IAbstractImage;
import bridge.abstract.IAbstractTextField;
import bridge.abstract.ui.IAbstractComboBox;
import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
import bridge.abstract.ui.IAbstractLabel;

import flash.display.Bitmap;
import flash.display.BitmapData;

import starlingEngine.signals.Signals;
import signals.ISignalsHub;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starlingEngine.elements.EngineLabel;
import starlingEngine.elements.EngineSprite;
import starlingEngine.elements.EngineTextField;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineComboBox extends EngineSprite implements IAbstractComboBox
	{
		
		private var _label:IAbstractLabel ;
		private var _textField:IAbstractTextField;
		private var _cb:EngineList;
		private var _toggle:Boolean = false;
		private var _currentSelection:String = "choose";
		private var _currentSelectedIData:Object;
		private var _currentSelectedIndex:uint = 0;
		private var _signalsHub:ISignalsHub;
		
		/**
		 * 
		 * @param	signalsHub
		 * @param	dataProvider
		 * @param	width
		 * @param	height
		 * @param	backgroundImage
		 * @param	font
		 */
		public function EngineComboBox(signalsHub:ISignalsHub, dataProvider:Vector.<IAbstractComboBoxItemRenderer>, width:Number, height:Number, backgroundImage:IAbstractImage, font:String)
		{
			_cb = new EngineList(signalsHub, dataProvider, width, height, backgroundImage, font);
			_cb.y = 20;
			_cb.alpha = .9;
			_signalsHub = signalsHub;
			// MAKE BACKGROUND
			var bkSprite:Sprite = new Sprite();
			var bkBmpData:BitmapData = new BitmapData(width, 20, false, 0xFFFFFF);
			var bkBitmap:Bitmap = new Bitmap(bkBmpData);
			var bgImg:Image = Image.fromBitmap(bkBitmap);
			bkSprite.addChild(bgImg);
			this.addChild(bkSprite);
			bkSprite.addEventListener(TouchEvent.TOUCH, onCbTriggered);
			
			// MAKE DYNAMIC LABEL
			_textField = new EngineTextField(width, 20, "choose", font, 15);
			_label = new EngineLabel(_textField);
			_label.touchable = false;
			this.addNewChild(_label);
			
			//ADD LIST LISTENER
			signalsHub.addListenerToSignal(Signals.LIST_ITEM_TOUCHED_INTERNAL, makeSelection);
			
			//MAKE INITIAL SELECTION
			_label.updateLabel(dataProvider[0].text);
            _label.textField.fontSize = 15;
			_currentSelection = dataProvider[0].text;
			_currentSelectedIData = dataProvider[0].data;
			_currentSelectedIndex =  0;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function onCbTriggered(e:TouchEvent):void 
		{
			var touchBegan:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touchBegan)
			{
				toggle();
			}
		}
		
		private function toggle():void
		{
			if (!_toggle)
				{
					this.addChild(_cb);
				}
				else
				{
					this.removeChild(_cb)
				}
				_toggle = !_toggle;
		}
		
		/**
		 * 
		 * @param	event
		 * @param	obj
		 */
		private function makeSelection(event:String, obj:Object):void
		{
			if (obj["engineEvent"]["currentTarget"]["parent"] === _cb)
			{
				_label.updateLabel(event);
				_currentSelection = event;
				_currentSelectedIData = obj["params"]["selected"]["data"];
				_currentSelectedIndex =  obj["params"]["selectedIndex"];
				toggle();
				
				_signalsHub.dispatchSignal(Signals.LIST_ITEM_TOUCHED, event, obj);
			}
		}
		
		/**
		 * 
		 */
		public function get currentSelection():String
		{
			return _currentSelection
		}
		
		/**
		 * 
		 */
		public function get currentSelectedIndex():uint
		{
			return _currentSelectedIndex
		}
		
		/**
		 * 
		 */
		public function get currentSelectedIData():Object
		{
			return _currentSelectedIData
		}
		
		public function addItem(item:IAbstractComboBoxItemRenderer):void
		{
			_cb.addItem(item as EngineComboBoxItemRenderer);
		}
		
		public function removeItem(item:IAbstractComboBoxItemRenderer):void
		{
			_cb.removeItem(item as EngineComboBoxItemRenderer);
		}
		
		public function clearList():void
		{
			_cb.clearList();
		}

	}

}