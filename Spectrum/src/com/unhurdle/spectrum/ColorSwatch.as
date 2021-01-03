package com.unhurdle.spectrum
{
	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
		import com.unhurdle.spectrum.interfaces.IRGBA;
	}

	public class ColorSwatch extends SpectrumBase
	{
		public function ColorSwatch()
		{
			super();
			size = 24;
		}

		private var _size:Number;

		public function get size():Number{
			return _size;
		}
		public function set size(value:Number):void{
			_size = value;
			width = height = value;
		}

		private var _color:IRGBA;

		public function get color():IRGBA
		{
			return _color;
		}

		public function set color(value:IRGBA):void
		{
			_color = value;
			COMPILE::JS
			{
				if(value){
					var haveAlpha:Boolean = !isNaN(value.alpha);
					var prefix:String = haveAlpha ? "rgba(" : "rgb(";
					var style:String = prefix + value.r + ", " + value.g + ", " + value.b;
					if(haveAlpha){
						style += ", " + value.alpha;
					}
					style += ")";
					backgroundStyle.backgroundColor = style;
				}
			}
		}
		private var _square:Boolean;

		public function get square():Boolean{
			return _square;
		}

		public function set square(value:Boolean):void{
			_square = value;
			COMPILE::JS
			{
				if(value){
					checkerboard.classList.add("square");
				} else {
					checkerboard.classList.remove("square");
				}
			}
		}

		COMPILE::JS
		private var checkerboard:HTMLElement;

		COMPILE::JS
		private var backgroundStyle:CSSStyleDeclaration;
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			checkerboard = newElement("div","spectrum-ColorSlider-checkerboard");
			checkerboard.setAttribute("role","presentation");
			var div2:HTMLElement = newElement("div","spectrum-ColorSlider-gradient");
			div2.setAttribute("role","presentation");
			backgroundStyle = div2.style;
			checkerboard.appendChild(div2);
			elem.appendChild(checkerboard);
			return elem;
		}
	}
}