package com.unhurdle.spectrum
{
	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import com.unhurdle.spectrum.data.RGBColor;

	public class ColorSwatch extends SpectrumBase
	{
		public function ColorSwatch()
		{
			super();
			size = 24;
			this.setStyle("margin-top","2px");
		}
    override protected function getSelector():String{
      return "spectrum-ColorSwatch";
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
			if(!value.isValid){
				value = new RGBColor([0,0,0,0]);
			}
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
					backgroundStyle.borderRadius = 0;
				} else {
					checkerboard.classList.remove("square");
					backgroundStyle.borderRadius = "";
				}
			}
		}

		private var _squareRight:Boolean;

		public function get squareRight():Boolean{
			return _squareRight;
		}

		public function set squareRight(value:Boolean):void{
			_squareRight = value;
			COMPILE::JS
			{
				if(value){
					checkerboard.classList.add("square-right");
					backgroundStyle.borderTopRightRadius = 0;
					backgroundStyle.borderBottomRightRadius = 0;
				} else {
					checkerboard.classList.remove("square-right");
					backgroundStyle.borderTopRightRadius = "";
					backgroundStyle.borderBottomRightRadius = "";
				}
			}
		}

		private var _squareLeft:Boolean;

		public function get squareLeft():Boolean{
			return _squareLeft;
		}

		public function set squareLeft(value:Boolean):void{
			_squareLeft = value;
			COMPILE::JS
			{
				if(value){
					checkerboard.classList.add("square-left");
					backgroundStyle.borderTopLeftRadius = 0;
					backgroundStyle.borderBottomLeftRadius = 0;
				} else {
					checkerboard.classList.remove("square-left");
					backgroundStyle.borderTopLeftRadius = "";
					backgroundStyle.borderBottomLeftRadius = "";
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
			// withought this, the checkboard gets all the mouse interaction on the screen. Not sure why.
			checkerboard.style.pointerEvents = "none";
			var div2:HTMLElement = newElement("div","spectrum-ColorSlider-gradient");
			div2.setAttribute("role","presentation");
			backgroundStyle = div2.style;
			checkerboard.appendChild(div2);
			elem.appendChild(checkerboard);
			return elem;
		}
	}
}