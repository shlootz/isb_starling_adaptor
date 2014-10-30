/**
 *	Copyright (c) 2012 Devon O. Wolfgang
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */
 
package starlingEngine.filters {
    import flash.display3D.Context3D;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Program3D;
	import starling.filters.FragmentFilter;
 
    import starling.textures.Texture;
 
    public class PixelateFilter extends FragmentFilter
    {
        private var mQuantifiers:Vector.<Number> = new <Number>[1, 1, 1, 1];
        private var mPixelSize:int;
        private var mShaderProgram:Program3D;
 
        /**
         *
         * @param       pixelSize               size of pixel effect
         */
        public function PixelateFilter(pixelSize:int)
        {
            mPixelSize = pixelSize;
        }
 
        public override function dispose():void
        {
            if (mShaderProgram) mShaderProgram.dispose();
            super.dispose();
        }
 
        protected override function createPrograms():void
        {
            var fragmentProgramCode:String =
                "div ft0, v0, fc0                                               \n" +
                "frc ft1, ft0                                                   \n" +
                "sub ft0, ft0, ft1                                              \n" +
                "mul ft0, ft0, fc0                                              \n" +
                "tex oc, ft0, fs0<2d, clamp, nearest>"
 
            mShaderProgram = assembleAgal(fragmentProgramCode);
        }
 
        protected override function activate(pass:int, context:Context3D, texture:Texture):void
        {
            // already set by super class:
            //
            // vertex constants 0-3: mvpMatrix (3D)
            // vertex attribute 0:   vertex position (FLOAT_2)
            // vertex attribute 1:   texture coordinates (FLOAT_2)
            // texture 0:            input texture
 
			// thank you, Daniel Sperl! ( http://forum.starling-framework.org/topic/new-feature-filters/page/2 )
            mQuantifiers[0] = mPixelSize / texture.width;
            mQuantifiers[1] = mPixelSize / texture.height;
 
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, mQuantifiers, 1);
            context.setProgram(mShaderProgram);
        }
 
        public function get pixelSize():int { return mPixelSize; }
        public function set pixelSize(value:int):void { mPixelSize = value; }
    }
}