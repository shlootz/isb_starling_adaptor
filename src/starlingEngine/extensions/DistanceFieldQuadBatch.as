package starlingEngine.extensions
{
import com.adobe.utils.AGALMiniAssembler;

import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.IndexBuffer3D;
import flash.display3D.VertexBuffer3D;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import starling.core.RenderSupport;
import starling.core.Starling;
import starling.core.starling_internal;
import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Image;
import starling.display.Quad;
import starling.errors.MissingContextError;
import starling.events.Event;
import starling.filters.FragmentFilter;
import starling.filters.FragmentFilterMode;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;
import starling.utils.MatrixUtil;
import starling.utils.VertexData;

use namespace starling_internal;
	
	
	/******************************************
	 * 
	 * http://www.valvesoftware.com/publications/2007/SIGGRAPH2007_AlphaTestedMagnification.pdf
	 * 
	 * https://code.google.com/p/libgdx/wiki/DistanceFieldFonts
	 * 
	 *****************************************/

	public class DistanceFieldQuadBatch extends DisplayObject
	{
		private static const QUAD_PROGRAM_NAME:String = "DQB_q";
		
		private var mNumQuads:int;
		private var mSyncRequired:Boolean;
		
		private var mTinted:Boolean;
		private var mTexture:Texture;
		private var mSmoothing:String;
		
		private var mVertexData:VertexData;
		private var mVertexBuffer:VertexBuffer3D;
		private var mIndexData:Vector.<uint>;
		private var mIndexBuffer:IndexBuffer3D;
		
		/** Helper objects. */
		private static var sHelperMatrix:Matrix = new Matrix();
		private static var sRenderAlpha:Vector.<Number> = new <Number>[1.0, 1.0, 1.0, 1.0];
		private static var sRenderMatrix:Matrix3D = new Matrix3D();
		private static var sProgramNameCache:Dictionary = new Dictionary();
		public		   var sDistanceConstants:Vector.<Number> = new <Number>[0.5 - 1.0/16.0, 0.5 + 1.0/16.0, 3, 0.5];
		public		   var sDistanceConstants2:Vector.<Number> = new <Number>[1, 1, 1, 1];
		
		/** Creates a new DistanceQuadBatch instance with empty batch data. */
		public function DistanceFieldQuadBatch()
		{
			mVertexData = new VertexData(0, true);
			mIndexData = new <uint>[];
			mNumQuads = 0;
			mTinted = false;
			mSyncRequired = false;
			
			// Handle lost context. We use the conventional event here (not the one from Starling)
			// so we're able to create a weak event listener; this avoids memory leaks when people 
			// forget to call "dispose" on the QuadBatch.
			Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE, 
				onContextCreated, false, 0, true);
		}
		
		/** Disposes vertex- and index-buffer. */
		public override function dispose():void
		{
			Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			if (mVertexBuffer) mVertexBuffer.dispose();
			if (mIndexBuffer)  mIndexBuffer.dispose();
			
			super.dispose();
		}
		
		private function onContextCreated(event:Object):void
		{
			createBuffers();
			registerPrograms();
		}
		
		/** Creates a duplicate of the QuadBatch object. */
		public function clone():DistanceFieldQuadBatch
		{
			var clone:DistanceFieldQuadBatch = new DistanceFieldQuadBatch();
			clone.mVertexData = mVertexData.clone(0, mNumQuads * 4);
			clone.mIndexData = mIndexData.slice(0, mNumQuads * 6);
			clone.mNumQuads = mNumQuads;
			clone.mTinted = mTinted;
			clone.mTexture = mTexture;
			clone.mSmoothing = mSmoothing;
			clone.mSyncRequired = true;
			clone.blendMode = blendMode;
			clone.alpha = alpha;
			return clone;
		}
		
		private function expand(newCapacity:int=-1):void
		{
			var oldCapacity:int = capacity;
			
			if (newCapacity <  0) newCapacity = oldCapacity * 2;
			if (newCapacity == 0) newCapacity = 16;
			if (newCapacity <= oldCapacity) return;
			
			mVertexData.numVertices = newCapacity * 4;
			
			for (var i:int=oldCapacity; i<newCapacity; ++i)
			{
				mIndexData[int(i*6  )] = i*4;
				mIndexData[int(i*6+1)] = i*4 + 1;
				mIndexData[int(i*6+2)] = i*4 + 2;
				mIndexData[int(i*6+3)] = i*4 + 1;
				mIndexData[int(i*6+4)] = i*4 + 3;
				mIndexData[int(i*6+5)] = i*4 + 2;
			}
			
			createBuffers();
			registerPrograms();
		}
		
		private function createBuffers():void
		{
			var numVertices:int = mVertexData.numVertices;
			var numIndices:int = mIndexData.length;
			var context:Context3D = Starling.context;
			
			if (mVertexBuffer)    mVertexBuffer.dispose();
			if (mIndexBuffer)     mIndexBuffer.dispose();
			if (numVertices == 0) return;
			if (context == null)  throw new MissingContextError();
			
			mVertexBuffer = context.createVertexBuffer(numVertices, VertexData.ELEMENTS_PER_VERTEX);
			mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, numVertices);
			
			mIndexBuffer = context.createIndexBuffer(numIndices);
			mIndexBuffer.uploadFromVector(mIndexData, 0, numIndices);
			
			mSyncRequired = false;
		}
		
		/** Uploads the raw data of all batched quads to the vertex buffer. */
		private function syncBuffers():void
		{
			if (mVertexBuffer == null)
				createBuffers();
			else
			{
				// as 3rd parameter, we could also use 'mNumQuads * 4', but on some GPU hardware (iOS!),
				// this is slower than updating the complete buffer.
				
				mVertexBuffer.uploadFromVector(mVertexData.rawData, 0, mVertexData.numVertices);
				mSyncRequired = false;
			}
		}
		
		/** Renders the current batch with custom settings for model-view-projection matrix, alpha 
		 *  and blend mode. This makes it possible to render batches that are not part of the 
		 *  display list. */ 
		public function renderCustom(mvpMatrix:Matrix, parentAlpha:Number=1.0,
									 blendMode:String=null):void
		{
			if (mNumQuads == 0) return;
			if (mSyncRequired) syncBuffers();
			
			var pma:Boolean = mVertexData.premultipliedAlpha;
			var context:Context3D = Starling.context;
			var tinted:Boolean = mTinted || (parentAlpha != 1.0);
			var programName:String = mTexture ? 
				getImageProgramName(tinted, mTexture.mipMapping, mTexture.repeat, mTexture.format, mSmoothing) : 
				QUAD_PROGRAM_NAME;
			
			sRenderAlpha[0] = sRenderAlpha[1] = sRenderAlpha[2] = pma ? parentAlpha : 1.0;
			sRenderAlpha[3] = parentAlpha;
			
			MatrixUtil.convertTo3D(mvpMatrix, sRenderMatrix);
			RenderSupport.setBlendFactors(pma, blendMode ? blendMode : this.blendMode);
			
			context.setProgram(Starling.current.getProgram(programName));
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, sRenderAlpha, 1);
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 1, sRenderMatrix, true);
			context.setVertexBufferAt(0, mVertexBuffer, VertexData.POSITION_OFFSET, 
				Context3DVertexBufferFormat.FLOAT_2); 
			
			if (mTexture == null || tinted)
				context.setVertexBufferAt(1, mVertexBuffer, VertexData.COLOR_OFFSET, 
					Context3DVertexBufferFormat.FLOAT_4);
			
			if (mTexture)
			{
				context.setTextureAt(0, mTexture.base);
				context.setVertexBufferAt(2, mVertexBuffer, VertexData.TEXCOORD_OFFSET, 
					Context3DVertexBufferFormat.FLOAT_2);
			}

			// fc0 -> constants 	[0.5 - 1.0/16.0, 0.5 + 1.0/16.0, 3, 0.5]
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, sDistanceConstants, 1);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, sDistanceConstants2, 1);
			
			context.drawTriangles(mIndexBuffer, 0, mNumQuads * 2);
			
			if (mTexture)
			{
				context.setTextureAt(0, null);
				context.setVertexBufferAt(2, null);
			}
			
			context.setVertexBufferAt(1, null);
			context.setVertexBufferAt(0, null);
		}
		
		/** Resets the batch. The vertex- and index-buffers remain their size, so that they
		 *  can be reused quickly. */  
		public function reset():void
		{
			mNumQuads = 0;
			mTexture = null;
			mSmoothing = null;
			mSyncRequired = true;
		}
		
		/** Adds an image to the batch. This method internally calls 'addQuad' with the correct
		 *  parameters for 'texture' and 'smoothing'. */ 
		public function addImage(image:Image, parentAlpha:Number=1.0, modelViewMatrix:Matrix=null,
								 blendMode:String=null):void
		{
			addQuad(image, parentAlpha, image.texture, image.smoothing, modelViewMatrix, blendMode);
		}
		
		/** Adds a quad to the batch. The first quad determines the state of the batch,
		 *  i.e. the values for texture, smoothing and blendmode. When you add additional quads,  
		 *  make sure they share that state (e.g. with the 'isStageChange' method), or reset
		 *  the batch. */ 
		public function addQuad(quad:Quad, parentAlpha:Number=1.0, texture:Texture=null, 
								smoothing:String=null, modelViewMatrix:Matrix=null, 
								blendMode:String=null):void
		{
			if (modelViewMatrix == null)
				modelViewMatrix = quad.transformationMatrix;
			
			var tinted:Boolean = texture ? (quad.tinted || parentAlpha != 1.0) : false;
			var alpha:Number = parentAlpha * quad.alpha;
			var vertexID:int = mNumQuads * 4;
			
			if (mNumQuads + 1 > mVertexData.numVertices / 4) expand();
			if (mNumQuads == 0) 
			{
				this.blendMode = blendMode ? blendMode : quad.blendMode;
				mTexture = texture;
				mTinted = tinted;
				mSmoothing = smoothing;
				mVertexData.setPremultipliedAlpha(quad.premultipliedAlpha);
			}
			
			quad.copyVertexDataTo(mVertexData, vertexID);
			mVertexData.transformVertex(vertexID, modelViewMatrix, 4);
			
			if (alpha != 1.0)
				mVertexData.scaleAlpha(vertexID, alpha, 4);
			
			mSyncRequired = true;
			mNumQuads++;
		}
		
		/** Adds another QuadBatch to this batch. Just like the 'addQuad' method, you have to
		 *  make sure that you only add batches with an equal state. */
		public function addQuadBatch(quadBatch:DistanceFieldQuadBatch, parentAlpha:Number=1.0, 
									 modelViewMatrix:Matrix=null, blendMode:String=null):void
		{
			if (modelViewMatrix == null)
				modelViewMatrix = quadBatch.transformationMatrix;
			
			var tinted:Boolean = quadBatch.mTinted || parentAlpha != 1.0;
			var alpha:Number = parentAlpha * quadBatch.alpha;
			var vertexID:int = mNumQuads * 4;
			var numQuads:int = quadBatch.numQuads;
			
			if (mNumQuads + numQuads > capacity) expand(mNumQuads + numQuads);
			if (mNumQuads == 0) 
			{
				this.blendMode = blendMode ? blendMode : quadBatch.blendMode;
				mTexture = quadBatch.mTexture;
				mTinted = tinted;
				mSmoothing = quadBatch.mSmoothing;
				mVertexData.setPremultipliedAlpha(quadBatch.mVertexData.premultipliedAlpha, false);
			}
			
			quadBatch.mVertexData.copyTo(mVertexData, vertexID, 0, numQuads*4);
			mVertexData.transformVertex(vertexID, modelViewMatrix, numQuads*4);
			
			if (alpha != 1.0)
				mVertexData.scaleAlpha(vertexID, alpha, numQuads*4);
			
			mSyncRequired = true;
			mNumQuads += numQuads;
		}
		
		/** Indicates if specific quads can be added to the batch without causing a state change. 
		 *  A state change occurs if the quad uses a different base texture, has a different 
		 *  'tinted', 'smoothing', 'repeat' or 'blendMode' setting, or if the batch is full
		 *  (one batch can contain up to 8192 quads). */
		public function isStateChange(tinted:Boolean, parentAlpha:Number, texture:Texture, 
									  smoothing:String, blendMode:String, numQuads:int=1):Boolean
		{
			if (mNumQuads == 0) return false;
			else if (mNumQuads + numQuads > 8192) return true; // maximum buffer size
			else if (mTexture == null && texture == null) return false;
			else if (mTexture != null && texture != null)
				return mTexture.base != texture.base ||
					mTexture.repeat != texture.repeat ||
					mSmoothing != smoothing ||
					mTinted != (tinted || parentAlpha != 1.0) ||
					this.blendMode != blendMode;
			else return true;
		}
		
		// display object methods
		
		/** @inheritDoc */
		public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
		{
			if (resultRect == null) resultRect = new Rectangle();
			
			var transformationMatrix:Matrix = targetSpace == this ?
				null : getTransformationMatrix(targetSpace, sHelperMatrix);
			
			return mVertexData.getBounds(transformationMatrix, 0, mNumQuads*4, resultRect);
		}
		
		/** @inheritDoc */
		public override function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (mNumQuads)
			{
				support.finishQuadBatch();
				support.raiseDrawCount();
				renderCustom(support.mvpMatrix, alpha * parentAlpha, support.blendMode);
			}
		}
		
		// compilation (for flattened sprites)
		
		/** Analyses an object that is made up exclusively of quads (or other containers)
		 *  and creates a vector of QuadBatch objects representing it. This can be
		 *  used to render the container very efficiently. The 'flatten'-method of the Sprite 
		 *  class uses this method internally. */
		public static function compile(object:DisplayObject, 
									   quadBatches:Vector.<DistanceFieldQuadBatch>):void
		{
			compileObject(object, quadBatches, -1, new Matrix());
		}
		
		private static function compileObject(object:DisplayObject, 
											  quadBatches:Vector.<DistanceFieldQuadBatch>,
											  quadBatchID:int,
											  transformationMatrix:Matrix,
											  alpha:Number=1.0,
											  blendMode:String=null,
											  ignoreCurrentFilter:Boolean=false):int
		{
			var i:int;
			var quadBatch:DistanceFieldQuadBatch;
			var isRootObject:Boolean = false;
			var objectAlpha:Number = object.alpha;
			
			var container:DisplayObjectContainer = object as DisplayObjectContainer;
			var quad:Quad = object as Quad;
			var batch:DistanceFieldQuadBatch = object as DistanceFieldQuadBatch;
			var filter:FragmentFilter = object.filter;
			
			if (quadBatchID == -1)
			{
				isRootObject = true;
				quadBatchID = 0;
				objectAlpha = 1.0;
				blendMode = object.blendMode;
				if (quadBatches.length == 0) quadBatches.push(new DistanceFieldQuadBatch());
				else quadBatches[0].reset();
			}
			
			if (filter && !ignoreCurrentFilter)
			{
				if (filter.mode == FragmentFilterMode.ABOVE)
				{
					quadBatchID = compileObject(object, quadBatches, quadBatchID,
						transformationMatrix, alpha, blendMode, true);
				}
				
				quadBatchID = compileObject(filter.compile(object), quadBatches, quadBatchID,
					transformationMatrix, alpha, blendMode);
				
				if (filter.mode == FragmentFilterMode.BELOW)
				{
					quadBatchID = compileObject(object, quadBatches, quadBatchID,
						transformationMatrix, alpha, blendMode, true);
				}
			}
			else if (container)
			{
				var numChildren:int = container.numChildren;
				var childMatrix:Matrix = new Matrix();
				
				for (i=0; i<numChildren; ++i)
				{
					var child:DisplayObject = container.getChildAt(i);
					var childVisible:Boolean = child.alpha  != 0.0 && child.visible && 
						child.scaleX != 0.0 && child.scaleY != 0.0;
					if (childVisible)
					{
						var childBlendMode:String = child.blendMode == BlendMode.AUTO ?
							blendMode : child.blendMode;
						childMatrix.copyFrom(transformationMatrix);
						RenderSupport.transformMatrixForObject(childMatrix, child);
						quadBatchID = compileObject(child, quadBatches, quadBatchID, childMatrix, 
							alpha*objectAlpha, childBlendMode);
					}
				}
			}
			else if (quad || batch)
			{
				var texture:Texture;
				var smoothing:String;
				var tinted:Boolean;
				var numQuads:int;
				
				if (quad)
				{
					var image:Image = quad as Image;
					texture = image ? image.texture : null;
					smoothing = image ? image.smoothing : null;
					tinted = quad.tinted;
					numQuads = 1;
				}
				else
				{
					texture = batch.mTexture;
					smoothing = batch.mSmoothing;
					tinted = batch.mTinted;
					numQuads = batch.mNumQuads;
				}
				
				quadBatch = quadBatches[quadBatchID];
				
				if (quadBatch.isStateChange(tinted, alpha*objectAlpha, texture, 
					smoothing, blendMode, numQuads))
				{
					quadBatchID++;
					if (quadBatches.length <= quadBatchID) quadBatches.push(new DistanceFieldQuadBatch());
					quadBatch = quadBatches[quadBatchID];
					quadBatch.reset();
				}
				
				if (quad)
					quadBatch.addQuad(quad, alpha, texture, smoothing, transformationMatrix, blendMode);
				else
					quadBatch.addQuadBatch(batch, alpha, transformationMatrix, blendMode);
			}
			else
			{
				throw new Error("Unsupported display object: " + getQualifiedClassName(object));
			}
			
			if (isRootObject)
			{
				// remove unused batches
				for (i=quadBatches.length-1; i>quadBatchID; --i)
					quadBatches.pop().dispose();
			}
			
			return quadBatchID;
		}
		
		// properties
		
		public function get numQuads():int { return mNumQuads; }
		public function get tinted():Boolean { return mTinted; }
		public function get texture():Texture { return mTexture; }
		public function get smoothing():String { return mSmoothing; }
		public function get premultipliedAlpha():Boolean { return mVertexData.premultipliedAlpha; }
		
		private function get capacity():int { return mVertexData.numVertices / 4; }
		
		// program management
		
		private static function registerPrograms():void
		{
			var target:Starling = Starling.current;
			if (target.hasProgram(QUAD_PROGRAM_NAME)) return; // already registered
			
			var assembler:AGALMiniAssembler = new AGALMiniAssembler();
			var vertexProgramCode:String;
			var fragmentProgramCode:String;
			
			// this is the input data we'll pass to the shaders:
			// 
			// va0 -> position
			// va1 -> color
			// va2 -> texCoords
			// vc0 -> alpha
			// vc1 -> mvpMatrix
			// fs0 -> texture
			// fc0 -> constants 	[0.5 - 1.0/16.0, 0.5 + 1.0/16.0, 3, 1]
			
			// Quad:
			
			vertexProgramCode =
				"m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
				"mul v0, va1, vc0 \n";  // multiply alpha (vc0) with color (va1)
			
			fragmentProgramCode =
				"mov oc, v0       \n";  // output color
			
			target.registerProgram(QUAD_PROGRAM_NAME,
				assembler.assemble(Context3DProgramType.VERTEX, vertexProgramCode),
				assembler.assemble(Context3DProgramType.FRAGMENT, fragmentProgramCode));
			
			// Image:
			// Each combination of tinted/repeat/mipmap/smoothing has its own fragment shader.
		
			for each (var tinted:Boolean in [true, false])
			{
				vertexProgramCode = tinted ?
					"m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
					"mul v0, va1, vc0 \n" + // multiply alpha (vc0) with color (va1)
					"mov v1, va2      \n"   // pass texture coordinates to fragment program
					:
					"m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
					"mov v1, va2      \n";  // pass texture coordinates to fragment program

				/*			
//				const float smoothing = 1.0/16.0;
//				float distance = texture2D(u_texture, v_texCoord).a;
//				float alpha = smoothstep(0.5 - smoothing, 0.5 + smoothing, distance);
//				gl_FragColor = vec4(v_color.rgb, alpha);			

//				fc0.x = 0.5 - smoothing		// a
//				fc0.y = 0.5 + smoothing		// b
//				fc0.z = 3
//				fc0.w = 0.5				
				*/			
	
// soft edges				
				fragmentProgramCode = tinted ?
					"tex ft1,  v1, fs0 <???> \n" + 	// sample texture 0
					"mov ft3, fc0 \n" + 
					
					"sub ft2.x, ft1.w, ft3.x \n" +	// smooth step 
					"sub ft2.y, ft3.y, ft3.x \n" +
					"div ft2.x, ft2.x, ft2.y \n" +
					"sat ft2.x, ft2.x \n" +
					"add ft2.y, ft2.x, ft2.x \n" +
					"sub ft2.y, ft3.z, ft2.y \n" +
					"mul ft2.x, ft2.x, ft2.x \n" +
					"mul ft2.x, ft2.y, ft2.x \n" +
					
					"sub ft4.w, ft2.x, ft3.w \n" +	// kill texture if under threshold
					"kil ft4.w \n" +
					
					"mov ft1.xyz, v0.xyz\n" + 		// Place vertex color
					"mov ft1.w, ft2.x\n" +			// place smooth alpha
					"mov oc, ft1 \n"  				
					:
					"tex ft1,  v1, fs0 <???> \n" + 	// sample texture 0
					"mov ft3, fc0 \n" + 
					
					"sub ft2.x, ft1.w, ft3.x \n" + 	// smooth step 
					"sub ft2.y, ft3.y, ft3.x \n" +
					"div ft2.x, ft2.x, ft2.y \n" +
					"sat ft2.x, ft2.x \n" +
					"add ft2.y, ft2.x, ft2.x \n" +
					"sub ft2.y, ft3.z, ft2.y \n" +
					"mul ft2.x, ft2.x, ft2.x \n" +
					"mul ft2.x, ft2.y, ft2.x \n" +
					
					"sub ft4.w, ft2.x, ft3.w \n" +	// kill texture if under threshold
					"kil ft4.w \n" +
					
					"mov ft1.xyz, fc1.xxx\n" + 		// Place vertex color
					"mov ft1.w, ft2.x\n" +			// place smooth alpha
					"mov oc, ft1 \n"  				

// Hard Edges 					
/*				fragmentProgramCode = tinted ?
					"tex ft1,  v1, fs0 <???> \n" + // sample texture 0
					"mov ft3, fc0 \n" + 
					"mov ft2.xyzw, ft1.wwww \n" + 
					
					"sub ft4.w, ft2.x, fc0.w \n" +
					"kil ft4.w \n" +
					
					"mul ft1.xyz, ft2.xxx, v0.xyz\n" + // multiply color with texel color
					"mov ft1.w, ft2.x\n" +
					"mov oc, ft1 \n"  				
					:
					"tex ft1,  v1, fs0 <???> \n" + // sample texture 0
					"mov ft3, fc0 \n" + 
					"mov ft2.xyzw, ft1.wwww \n" + 
					
					"sub ft4.w, ft2.x, fc0.w \n" +
					"kil ft4.w \n" +
					"mov oc, fc1 \n"  				
*/					
				var smoothingTypes:Array = [
					TextureSmoothing.NONE,
					TextureSmoothing.BILINEAR,
					TextureSmoothing.TRILINEAR
				];
				
				var formats:Array = [
					Context3DTextureFormat.BGRA,
					Context3DTextureFormat.COMPRESSED,
					"compressedAlpha" // use explicit string for compatibility
				];
				
				for each (var repeat:Boolean in [true, false])
				{
					for each (var mipmap:Boolean in [true, false])
					{
						for each (var smoothing:String in smoothingTypes)
						{
							for each (var format:String in formats)
							{
								var options:Array = ["2d", repeat ? "repeat" : "clamp"];
								
								if (format == Context3DTextureFormat.COMPRESSED)
									options.push("dxt1");
								else if (format == "compressedAlpha")
									options.push("dxt5");
								
								if (smoothing == TextureSmoothing.NONE)
									options.push("nearest", mipmap ? "mipnearest" : "mipnone");
								else if (smoothing == TextureSmoothing.BILINEAR)
									options.push("linear", mipmap ? "mipnearest" : "mipnone");
								else
									options.push("linear", mipmap ? "miplinear" : "mipnone");
								
								target.registerProgram(
									getImageProgramName(tinted, mipmap, repeat, format, smoothing),
									assembler.assemble(Context3DProgramType.VERTEX, vertexProgramCode),
									assembler.assemble(Context3DProgramType.FRAGMENT,
										fragmentProgramCode.replace("???", options.join()))
								);
							}
						}
					}
				}
			}
		}
		
		private static function getImageProgramName(tinted:Boolean, mipMap:Boolean=true, 
													repeat:Boolean=false, format:String="bgra",
													smoothing:String="bilinear"):String
		{
			var bitField:uint = 0;
			
			if (tinted) bitField |= 1;
			if (mipMap) bitField |= 1 << 1;
			if (repeat) bitField |= 1 << 2;
			
			if (smoothing == TextureSmoothing.NONE)
				bitField |= 1 << 3;
			else if (smoothing == TextureSmoothing.TRILINEAR)
				bitField |= 1 << 4;
			
			if (format == Context3DTextureFormat.COMPRESSED)
				bitField |= 1 << 5;
			else if (format == "compressedAlpha")
				bitField |= 1 << 6;
			
			var name:String = sProgramNameCache[bitField];
			
			if (name == null)
			{
				name = "DQB_i." + bitField.toString(16);
				sProgramNameCache[bitField] = name;
			}
			
			return name;
		}
	}
}