package com.unhurdle.spectrum
{
	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.geom.Point;
	import com.unhurdle.spectrum.data.RGBColor;
	import org.apache.royale.utils.HSV;
	import org.apache.royale.utils.rgbToHsv;
	import org.apache.royale.utils.number.getPercent;
	import org.apache.royale.utils.number.pinValue;

	public class ColorArea extends SpectrumBase
	{
		public static const DEFAULT_SIZE:Number = 192;
		public function ColorArea()
		{
			super();
			width = height = size;
		}
		override protected function getSelector():String{
			return "spectrum-ColorArea";
		}

		private var _size:Number = 192;

		public function get size():Number{
			return _size;
		}

		public function set size(value:Number):void{
			_size = value;
			width = height = value;
			drawCanvas();
		}

		public function get appliedColor():IRGBA{
			return handle.appliedColor;
		}

		public function set appliedColor(value:IRGBA):void{
			if(!value){
				return;
			}
			handle.visible = value.isValid;
			if(value.isValid){
				hsv = rgbToHsv(value.r,value.g,value.b);
				drawCanvas();
			}
		}

		private var _hsv:HSV;

		public function get hsv():HSV
		{
			return _hsv;
		}

		public function set hsv(value:HSV):void
		{
			_hsv = value;
			positionHandle();
		}

		public function get hue():Number
		{
			return hsv ? hsv.h : 0;
		}

		public function set hue(value:Number):void
		{
			if(!hsv){
				hsv = new HSV();
				hsv.s = 100;
				hsv.v = 100;
			}
			// If there's no visible hue, we assume that should be reset
			if(hsv.s == 0){
				hsv.s = 100;
			}
			if(hsv.v == 0){
				hsv.v = 100;
			}
			hsv.h = value;
			positionHandle();
			drawCanvas();
		}

		private var handle:ColorHandle;

		private var addedOnce:Boolean;
		
		COMPILE::JS
		override public function addedToParent():void{
			super.addedToParent();
			//TODO disabled?
			if(!addedOnce){
				addEventListener('mousedown', onMouseDown);
			}
			addedOnce = true;
			drawCanvas();

		}
		private function positionHandle():void{
			handle.visible = true;
			handle.x = (hsv.s / 100) * width;
			handle.y = height - hsv.v * height / 100;
			setHandleColor();
		}
		// private var imageData:ImageData;
		// private function getImageData():void{
		// 	var ctx:CanvasRenderingContext2D = canvas.getContext("2d") as CanvasRenderingContext2D;
  	// 	imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);			
		// }

		COMPILE::JS
		protected function onMouseDown(e:MouseEvent):void {
			handle.toggle("is-dragged",true);
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}
		
		COMPILE::JS
		protected function onMouseUp():void {
			handle.toggle("is-dragged",false);
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}

		COMPILE::JS
		protected function onMouseMove(e:MouseEvent):void {
			//TODO disabled?
			// if(disabled){
			// 	return;
			// }
			calculateColor(getClientOffset(e));
		}

		COMPILE::JS
		private function calculateColor(point:Point):void{
			// if(!imageData){
			// 	getImageData();
			// }
    // locate index of current pixel
    	// var i:int = (point.y * imageData.width + point.x) * 4;
			// var data:Uint8ClampedArray = imageData.data;
			// handle.appliedColor = new RGBColor([data[i],data[i+1],data[i+2],data[i+3]]);
			hsv.s = getPercent(point.x,width);
			// The v scale goes bottom to top so we need to inverse the value.
			hsv.v = 100 - getPercent(point.y,height);
			positionHandle();
			// setHandleColor();
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));
		}
		private function setHandleColor():void{
			handle.appliedColor = RGBColor.fromHSV(hsv);
		}

		COMPILE::JS
		private function getClientOffset(event:MouseEvent):Point{
			if(event["touches"]){
				event = event["touches"][0];
			}
			var clientRect:ClientRect = canvas.getBoundingClientRect();
			var point:Point = new Point(event.clientX,event.clientY);
			point.x -= clientRect.left;
			point.x = pinValue(point.x,0,width);
			point.y -= clientRect.top;
			point.y = pinValue(point.y,0,height);
			return point;
		}

		COMPILE::SWF
		private function drawCanvas():Boolean{return true}

		COMPILE::JS
		private function drawCanvas():Boolean{
			//only draw if added
			if(!addedOnce){
				return false;
			}
			canvas.width = size;
			canvas.height = size;
			var context:CanvasRenderingContext2D = canvas.getContext('2d') as CanvasRenderingContext2D;
			context.rect(0, 0, canvas.width, canvas.height);

			var gradB:CanvasGradient = context.createLinearGradient(0, 0, 0, canvas.height);
			gradB.addColorStop(0, 'white');
			gradB.addColorStop(1, 'black');
			var hueColor:HSV = new HSV();
			hueColor.h = hue;
			hueColor.s = 100;
			hueColor.v = 100;
			var colorToApply:IRGBA = RGBColor.fromHSV(hueColor);
			if(!hsv){
				hsv = hueColor;
				hsv.v = 0;
			}
			var gradC:CanvasGradient = context.createLinearGradient(0, 0, canvas.width, 0);
			colorToApply.alpha = 0;
			gradC.addColorStop(0, colorToApply.styleString);
			colorToApply.alpha = 1;
			gradC.addColorStop(1, colorToApply.styleString);

			context.fillStyle = gradB;
			context.fillRect(0, 0, canvas.width, canvas.height);
			context.fillStyle = gradC;
			context.globalCompositeOperation = 'multiply';
			context.fillRect(0, 0, canvas.width, canvas.height);
			context.globalCompositeOperation = 'source-over';
			return true;
		}

		COMPILE::JS
		private var canvas:HTMLCanvasElement;
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			canvas = newElement('canvas',appendSelector("-gradient")) as HTMLCanvasElement;
			elem.appendChild(canvas);
			handle = new ColorHandle();
			addElement(handle);
			return elem;
		}
	}
}