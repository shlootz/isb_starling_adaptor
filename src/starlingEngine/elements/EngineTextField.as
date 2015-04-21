package starlingEngine.elements 
{
import bridge.abstract.IAbstractTextField;

import flash.filters.BevelFilter;
import flash.filters.DropShadowFilter;

import flash.filters.GlowFilter;
import flash.filters.GradientBevelFilter;

import flash.geom.Rectangle;
import flash.text.TextFormat;

import starling.display.DisplayObject;
import starling.text.TextField;

import utils.ClassHelper;

/**
	 * ...
	 * @author Alex Popescu
	 */
	public class EngineTextField extends TextField implements IAbstractTextField
	{

        private static const FONT_BLEED_COMPENSATION:uint = 5;
        private static const MIN_WIDTH:uint = 30;
        private static const MIN_HEIGHT:uint = 30;

        private var _initialFontSize:uint = 0;

		public function EngineTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false, nativeFiltersArr:Array = null) 
		{
			super(width, height, text, fontName, fontSize, color, bold);
			if (nativeFiltersArr)
			{
				super.nativeFilters = nativeFiltersArr;
			}
		}
		
		/**
		 * Indicates whether the font size is scaled down so that the complete text fits
		 * into the text field.
		 */
		override public function get autoScale () : Boolean
		{
			return super.autoScale;
		}
		override public function set autoScale (value:Boolean) : void
		{
			super.autoScale = value;
		}

		/**
		 * Specifies the type of auto-sizing the TextField will do.
		 * Note that any auto-sizing will make auto-scaling useless. Furthermore, it has 
		 * implications on alignment: horizontally auto-sized text will always be left-, 
		 * vertically auto-sized text will always be top-aligned.
		 */
		override public function get autoSize () : String
		{
			return super.autoSize;
		}
		override public function set autoSize (value:String) : void
		{
			super.autoSize = value;
		}

		/**
		 * Indicates if TextField should be batched on rendering. This works only with bitmap
		 * fonts, and it makes sense only for TextFields with no more than 10-15 characters.
		 * Otherwise, the CPU costs will exceed any gains you get from avoiding the additional
		 * draw call.
		 */
		override public function get batchable () : Boolean
		{
			return super.batchable;
		}
		override public function set batchable (value:Boolean) : void
		{
			super.batchable = value;
		}

		/// Indicates whether the text is bold.
		override public function get bold () : Boolean
		{
			return super.bold;
		}
		override public function set bold (value:Boolean) : void
		{
			super.bold = value;
		}

		/// Draws a border around the edges of the text field. Useful for visual debugging.
		override public function get border () : Boolean
		{
			return super.border;
		}
		override public function set border (value:Boolean) : void
		{
			super.border = value;
		}

		/**
		 * The color of the text. For bitmap fonts, use Color.WHITE to use the
		 * original, untinted color.
		 */
		override public function get color () : uint
		{
			return super.color;
		}
		override public function set color (value:uint) : void
		{
			super.color = value;
		}

		/// The name of the font (true type or bitmap font).
		override public function get fontName () : String
		{
			return super.fontName;
		}
		override public function set fontName (value:String) : void
		{
			super.fontName = value;
		}

		/**
		 * The size of the font. For bitmap fonts, use BitmapFont.NATIVE_SIZE for 
		 * the original size.
		 */
		override public function get fontSize () : Number
		{
			return super.fontSize;
		}
		override public function set fontSize (value:Number) : void
		{
            if(_initialFontSize == 0)
            {
                _initialFontSize = value;
            }
			super.fontSize = value;
		}

		/// The horizontal alignment of the text.
		override public function get hAlign () : String
		{
			return super.hAlign;
		}
		override public function set hAlign (value:String) : void
		{
			super.hAlign = value;
		}

		/// The height of the object in pixels.
		override public function set height (value:Number) : void
		{
			super.height = value;
		}

		/// Indicates whether the text is italicized.
		override public function get italic () : Boolean
		{
			return super.italic;
		}
		override public function set italic (value:Boolean) : void
		{
			super.italic = value;
		}

		/// Indicates whether kerning is enabled.
		override public function get kerning () : Boolean
		{
			return super.kerning;
		}
		override public function set kerning (value:Boolean) : void
		{
			super.kerning = value;
		}

		/**
		 * The native Flash BitmapFilters to apply to this TextField. 
		 * Only available when using standard (TrueType) fonts!
		 */
		override public function get nativeFilters () : Array
		{
			return super.nativeFilters;
		}
		override public function set nativeFilters (value:Array) : void
		{
			super.nativeFilters = value;
		}

		/// The displayed text.
		override public function get text () : String
		{
			return super.text;
		}
		override public function set text (value:String) : void
		{
			super.text = value;
		}

        /**
         * Forces a lower font size to fit a certain text field
         */
        public function fitFont():void
        {
            if(this.width > MIN_WIDTH) {
                if (!calculateFont("\n")) {
                    calculateFont(" ");
                }
            }
        }

        private function calculateFont(splitCharacter:String):Boolean
        {
            var strings:Array = text.split(splitCharacter);
            var success:Boolean = false;

            if (strings.length > 1 || splitCharacter == " ")
            {
                strings.sort(longest);

                var longestWord:String = strings[0];
                var textField:TextField = new TextField(500, 500, longestWord, this.fontName, this.fontSize);
                var actualWidth:Number = textField.textBounds.width;
                var percentage:Number = 1;
                var newFontSize:Number = this.fontSize;

                trace("!!!!!!!!!!!! "+calculateNativeFilterBleed());
                percentage = (this.width - FONT_BLEED_COMPENSATION - calculateNativeFilterBleed())/actualWidth;
                newFontSize = Math.floor(newFontSize * percentage);

                textField.dispose();

                if(newFontSize <= _initialFontSize) {
                    this.fontSize = newFontSize;
                }
                else
                {
                    this.fontSize = _initialFontSize;
                }
                success = true;
            }

            return success;
        }

        private function calculateNativeFilterBleed():Number
        {
            var offset:Number = 0;
            if(nativeFilters.length > 0) {
                for (var j:uint = 0; j < nativeFilters.length; j++) {
                    var rootClass:Class = ClassHelper.getClass(nativeFilters[j]);
                    if (rootClass === GlowFilter) {
                        offset = (nativeFilters[j] as GlowFilter).blurX * 2
                    }
                    else {
                        if (rootClass === BevelFilter) {
                            offset = (nativeFilters[j] as BevelFilter).blurX * 2
                        }
                        else {
                            if (rootClass === DropShadowFilter) {
                                offset = (nativeFilters[j] as DropShadowFilter).blurX * 2
                            }
                            else {
                                if (rootClass === GradientBevelFilter) {
                                    offset = (nativeFilters[j] as GradientBevelFilter).blurX * 2
                                }
                            }
                        }
                    }
                }
            }

            return offset
        }

        //Puts the longest word first
        private function longest(a:Object, b:Object):int
        {
            if (a.length > b.length)
            {
                return -1;
            }
            else if (a.length < b.length)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// Indicates whether the text is underlined.
		override public function get underline () : Boolean
		{
			return super.underline;
		}
		override public function set underline (value:Boolean) : void
		{
			super.underline = value;
		}

		/// The vertical alignment of the text.
		override public function get vAlign () : String
		{
			return super.vAlign;
		}
		override public function set vAlign (value:String) : void
		{
			super.vAlign = value;
		}

		/// The width of the object in pixels.
		override public function set width (value:Number) : void
		{
			super.width = value;
		}

		/// Disposes the underlying texture data.
		override public function dispose () : void
		{
			super.dispose();
		}

		override protected function formatText (textField:flash.text.TextField, textFormat:TextFormat) : void
		{
			super.formatText(textField, textFormat);
		}

		/**
		 * Returns a rectangle that completely encloses the object as it appears in another 
		 * coordinate system. If you pass a 'resultRectangle', the result will be stored in this 
		 * rectangle instead of creating a new object.
		 */
		override public function getBounds (targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
		{
			return super.getBounds(targetSpace, resultRect);
		}

		/**
		 * Forces the text field to be constructed right away. Normally, 
		 * it will only do so lazily, i.e. before being rendered.
		 */
		override public function redraw () : void
		{
			super.redraw();
		}
	}

}