package com.unhurdle.spectrum
{
	COMPILE::JS{
			import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.utils.PointerDrag;
	import org.apache.royale.events.ValueEvent;
	import com.unhurdle.spectrum.data.RGBColor;
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import org.apache.royale.utils.rgbToHsv;
	import org.apache.royale.utils.number.pinValue;

	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]

	public class ColorSlider extends SpectrumBase
	{
		public function ColorSlider(){
			super();
			colorStops = ["rgb(255, 0, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)", "rgb(0, 255, 255)", "rgb(0, 0, 255)", "rgb(255, 0, 255)", "rgb(255, 0, 0)"];
      hueSlider = true;
		}
		
		override protected function getSelector():String{
			return "spectrum-ColorSlider";
		}
		protected var handle:ColorHandle;
		COMPILE::JS
		protected var gradient:HTMLElement;
		COMPILE::JS
		private var input:HTMLInputElement;
		private var pointerDrag:PointerDrag;

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			var checkerboardContainer:HTMLElement = newElement("div",appendSelector("-checkerboard"));
			checkerboardContainer.setAttribute("role","presentation");
			gradient = newElement("div",appendSelector("-gradient"));
			gradient.setAttribute("role","presentation");
			checkerboardContainer.appendChild(gradient);
			elem.appendChild(checkerboardContainer);
			handle = new ColorHandle();
			// handle.style.left = "40%"
			handle.className = appendSelector("-handle");
			handle.element.style.left = '0%';
			addElement(handle);
			input = newElement("input",appendSelector("-slider")) as HTMLInputElement;
			input.type = "range";
			input.step = "1";
			input.min = "0";
			input.max = "100";
			elem.appendChild(input);
			input.addEventListener("input", handleNativeInput);
			return elem;
		}

		private var _disabled:Boolean = false;

		public function get disabled():Boolean{
			return _disabled;
		}

		public function set disabled(value:Boolean):void{
			if(value != _disabled){
				_disabled = value;
				handle.disabled = value;
				COMPILE::JS
				{
					input.disabled = value;
					if(pointerDrag){
						pointerDrag.enabled = !value;
					}
				}
				toggle("is-disabled",value);
			}
		}

		private var _vertical:Boolean = false;

		public function get vertical():Boolean{
			return _vertical;
		}

		public function set vertical(value:Boolean):void{
			if(value != _vertical){
				_vertical = value;
				toggle(valueToSelector("vertical"),value);
				changeBackgroundColor();
				COMPILE::JS{
					handle.element.style.left = "50%";
					if(pointerDrag){
						pointerDrag.setTouchAction(value ? "pan-x" : "pan-y");
					}
				}
			}
		}

		private var _appliedColor:IRGBA;

		public function get appliedColor():IRGBA{
			return handle.appliedColor;
		}

		public function set appliedColor(value:IRGBA):void{
			if(!value){
				return;
			}
			handle.visible = value.isValid;
			if(hueSlider){
				if(value.alpha != 1) return;
				var hueVal:IRGBA = value.clone();
				handle.appliedColor = hueVal;
			} else {
				handle.appliedColor = value.clone();
			}
      if(addedOnce){
        calculateHandlePosition();
      }
		}
    private var hueSlider:Boolean;
		private var _colorStops:Array;

		public function get colorStops():Array{
			return _colorStops;
		}

		public function set colorStops(value:Array):void{
      hueSlider = false;
			_colorStops = value;
			changeBackgroundColor();
			if(addedOnce){
				getRGBColors();
				if(!handle.appliedColor){
					handle.appliedColor = rgbColors[0];
				}
        calculateHandlePosition();
			}
		}
		private function getRGBColors():void{
			rgbColors = [];
			for(var i:int=0;i<colorStops.length;i++){
				rgbColors[i] = colorToRGBA(colorStops[i]);
			}
		}
		private var rgbColors:Array;
    protected function calculateHandlePosition():void{
			if(!appliedColor){// if no set color just put the handle at zero
					setHandlePosition(0);
					return;
			}
      if(hueSlider){
        var c:IRGBA = appliedColor;
        var hue:Number = rgbToHsv(c.r,c.g,c.b).h;
        setHandlePosition(hue / 3.6);
      } else {
        //TODO figure out the placement based on colorstops and h,s and v values
      }
    }
    protected function setHandlePosition(percent:Number):void{
      //make sure it's between 0 and 100
			percent = pinValue(percent,0,100);
      var percentVal:String = percent + "%"
			COMPILE::JS
			{
				input.value = "" + percent;
			}
      if(vertical){
        handle.setStyle("top",percentVal);
      }else{
        handle.setStyle("left",percentVal);
      }
    }
		protected var addedOnce:Boolean;
		override public function addedToParent():void{
			super.addedToParent();
			COMPILE::JS
			{
				if(!addedOnce){
					pointerDrag = new PointerDrag(element, handlePointerStart, handlePointerMove, handlePointerEnd, vertical ? "pan-x" : "pan-y");
				}
			}
			getRGBColors();
			addedOnce = true;
			changeBackgroundColor();
      calculateHandlePosition();
		}

		COMPILE::JS
		private function handlePointerStart(event:PointerEvent):Boolean {
			if(disabled || event.target === input){
				return false;
			}
			handle.toggle("is-dragged",true);
			return true;
		}

		COMPILE::JS
		private function handlePointerEnd():void {
			handle.toggle("is-dragged",false);
		}

		COMPILE::JS
		private function handlePointerMove(event:PointerEvent):void {
			if(disabled){
				return;
			}
			updateFromPercent(getPointerPercentagePosition(event));
		}

		COMPILE::JS
		private function handleNativeInput():void {
			updateFromPercent(Number(input.value));
		}

		protected function updateFromPercent(percent:Number):void {
			handle.visible = true;
			var num:Number = percent/(100/(colorStops.length - 1));
			if(isInt(num)){
				handle.appliedColor = colorToRGBA(colorStops[num]);
			}else{
				var ind:int = num - num % 1;
				var color1:String = colorStops[ind];
				var color2:String = colorStops[ind + 1];
				var rgb1:RGBColor = colorToRGBA(color1);
				var rgb2:RGBColor = colorToRGBA(color2);
				handle.appliedColor = findColor(rgb1,rgb2,getWeightColor(ind+1,ind,percent));

			}
      setHandlePosition(percent);
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));			
		}

		COMPILE::JS
		private function getPointerPercentagePosition(event:PointerEvent):Number{
			var bounds:ClientRect = element.getBoundingClientRect();
			if(vertical){
				if(bounds.height == 0){
					return 0;
				}
				return pinValue(event.clientY - bounds.top,0,bounds.height) / bounds.height * 100;
			}else{
				if(bounds.width == 0){
					return 0;
				}
				return pinValue(event.clientX - bounds.left,0,bounds.width) / bounds.width * 100;
			}
		}

		private function isInt(n:Number):Boolean{
			return Number(n) === n && n % 1 === 0;
		}

		private function getWeightColor(num1:Number, num2:Number, percent:Number):Number {
			var w1:Number = num1 *(100/(colorStops.length - 1));
			var w2:Number = num2 *(100/(colorStops.length - 1));
			var weight:Number = (percent - w1) / (w2 - w1);
			return weight;
		}

		protected function findColor(color1:RGBColor, color2:RGBColor, weight:Number):RGBColor {
			var w1:Number = weight;
			var w2:Number = 1 - w1;
			var rgb:Array = [Math.round(color1.r * w1 + color2.r * w2),
			Math.round(color1.g * w1 + color2.g * w2),
			Math.round(color1.b * w1 + color2.b * w2)];
			return new RGBColor(rgb);
		}

		COMPILE::JS
		private static var canvas:HTMLCanvasElement;
		
		COMPILE::JS
		protected static function getCanvas():HTMLCanvasElement{
			if(!canvas){
				canvas = newElement('canvas') as HTMLCanvasElement;
			}
			return canvas
		}
		COMPILE::SWF
		protected function colorToRGBA(color:String):* {
			return null;
		}
		COMPILE::JS
		protected function colorToRGBA(color:String):RGBColor {
			var cvs:HTMLCanvasElement = getCanvas();
			cvs.height = 1;
			cvs.width = 1;
			var ctx:CanvasRenderingContext2D = cvs.getContext('2d') as CanvasRenderingContext2D;
			ctx.fillStyle = color;
			ctx.fillRect(0, 0, 1, 1);
			// It's technically a Uint8ClampedArray, but it's easier to pretend it's a regular array
			return new RGBColor(ctx.getImageData(0, 0, 1, 1).data);
		}

		protected function changeBackgroundColor():void{
			if(!addedOnce){
				return;
			}
			var gradientDir:String;
			if(!!vertical){
				gradientDir = "bottom";
			}
			else{
				gradientDir = "right";
			}
			var startStr:String = "linear-gradient(to " + gradientDir + ", ";;
			for each(var c:String in colorStops){
				startStr += c +", ";
			}
			startStr = startStr.slice(0,startStr.length-2);
			startStr += ")";
			COMPILE::JS
			{
				gradient.style.background = startStr;
			}
		}
	}
}
