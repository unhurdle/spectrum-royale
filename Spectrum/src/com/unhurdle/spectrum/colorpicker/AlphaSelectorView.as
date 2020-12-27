package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStrandWithModel;
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.html.elements.Div;
	import org.apache.royale.core.IParent;
	
	COMPILE::JS
	{
		import org.apache.royale.utils.html.getStyle;
	}
	
	public class AlphaSelectorView extends ColorPickerSliderView
	{
		private var _model:IColorModel;
		private var _drawingLayer:Div;
		public function AlphaSelectorView()
		{
		}
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			_drawingLayer = new Div();
			COMPILE::JS
			{
				getStyle(_drawingLayer).position = "absolute";
			}
			_drawingLayer.percentWidth = 100;
			_drawingLayer.percentHeight = 100;
			(value as IParent).addElement(_drawingLayer);
			_model = (value as IStrandWithModel).model as IColorModel;
			_model.addEventListener("change", adjustBackGround);
			adjustBackGround();
		}

		private function adjustBackGround(e:Event=null):void
		{
			var color:uint = _model.color;
			var r:uint = (color >> 16 ) & 255;
			var g:uint = (color >> 8 ) & 255;
			var b:uint = color & 255;
			var from:String = "rgba(" + r + ", " + g + ", " + b + ", 1)";
			var to:String = "rgba(" + r + ", " + g + ", " + b + ", 0)";
			var str:String = "linear-gradient(to bottom, " + from + ", " + to + ")";
			COMPILE::JS
			{
				getStyle(_drawingLayer).background = str;
			}
		}

	}
}
