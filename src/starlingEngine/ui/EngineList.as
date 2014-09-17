package starlingEngine.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import bridge.abstract.ui.IAbstractToggle;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	import starlingEngine.elements.EngineImage;
	import starlingEngine.elements.EngineSprite;
	import starlingEngine.events.EngineEvent;
	import starlingEngine.events.GESignalEvent;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineList extends EngineSprite implements IAbstractSprite
	{
		
		private var _dataProvider:Vector.<IAbstractComboBoxItemRenderer> = new Vector.<IAbstractComboBoxItemRenderer>();
		private var _list:List;
		private var _signalsHub:SignalsHub;
		
		public function EngineList(signalsHub:SignalsHub, dataProvider:Vector.<IAbstractComboBoxItemRenderer>, width:Number, height:Number, backgroundImage:IAbstractImage, font:String) 
		{
			_signalsHub = signalsHub;
			// CREATE THE LIST //
			_dataProvider = dataProvider;
			
			_list = new List();
			_list.width = width;
			_list.height = height;
			
			_list.backgroundSkin = backgroundImage as Image;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.gap = 0;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
			layout.paddingLeft = 15;
			_list.layout = layout;
			
			var providerArray:Array = new Array();
			
			for (var i:uint = 0; i < _dataProvider.length; i++ )
			{
			var o:Object = {
				text:_dataProvider[i].text,
				thumbnail:Texture.fromTexture((_dataProvider[i].thumbnail as Image).texture),
				data:_dataProvider[i].data
			}
				providerArray.push(o)
			}
			
			var groceryList:ListCollection = new ListCollection(providerArray);
			_list.dataProvider = groceryList;
			
			_list.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(font, 15, 0x333333);
				 renderer.labelField = "text";
				 renderer.iconSourceField = "thumbnail";
				 renderer.useHandCursor = true;
				 return renderer;
			 };
			
			_list.itemRendererProperties.labelField = "text";
			_list.itemRendererProperties.iconSourceField = "thumbnail";
			_list.itemRendererProperties.accessorySourceField = "accessory";
			
			_list.addEventListener( "change", list_changeHandler );
			
			addChild(_list);
		}
		
		public function addItem(newItem:EngineComboBoxItemRenderer):void
		{
			_list.dataProvider.addItem(newItem);
		}
		
		public function removeItem(item:EngineComboBoxItemRenderer):void
		{
			_list.dataProvider.removeItem(item);
		}
		
		public function clearList():void
		{
			_list.dataProvider.removeAll();
		}
		
		private function list_changeHandler( e: Object ):void
		{
			if (e["target"]["selectedItem"]!= null)
			{
				var list:List = List( e.currentTarget );
				
				var o:GESignalEvent = new GESignalEvent()
				o.eventName = Signals.LIST_ITEM_TOUCHED;
				o.engineEvent = e;
				o.params = {
					selected:list.dataProvider.getItemAt(list.selectedIndex),
					data:e["target"]["selectedItem"]["data"]
				}
				
				_signalsHub.dispatchSignal(Signals.LIST_ITEM_TOUCHED, o.params["selected"]["text"], o);
			}
		}
		
	}

}