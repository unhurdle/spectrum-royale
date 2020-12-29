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

	public class ColorArea extends SpectrumBase
	{
		public static var DEFAULT_SIZE:Number = 192;
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
			handle.appliedColor = value;
		}

		private var _baseColor:IRGBA;
		public function get baseColor():IRGBA{
			return _baseColor;
		}
		public function set baseColor(value:IRGBA):void{
			_baseColor = value;
			if(drawCanvas()){
				calculateColor(new Point(handle.x,handle.y));
				imageData = null;
			}
		}

		private var handle:ColorHandle;

		private var addedOnce:Boolean;
		
		COMPILE::JS
		override public function addedToParent():void{
			super.addedToParent();
			//TODO disabled?
			if(!addedOnce){
				addEventListener('mousedown', onMouseDown);
				handle.addEventListener("colorChanged",function(ev:ValueEvent):void{
					positionHandle();
					dispatchEvent(new ValueEvent("colorChanged",ev));
				});
			}
			addedOnce = true;
			drawCanvas();

		}
		private function positionHandle():void{
			var color:IRGBA = handle.appliedColor;
			var hsv:HSV = rgbToHsv(color.r,color.g,color.b);
			handle.x = (hsv.s / 100) * width;
			handle.y = height - hsv.v * height / 100;
		}
		private var imageData:ImageData;
		private function getImageData():void{
			var ctx:CanvasRenderingContext2D = canvas.getContext("2d") as CanvasRenderingContext2D;
  		imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);			
		}

		COMPILE::JS
		protected function onMouseDown(e:MouseEvent):void {
			handle.toggle("is-dragged",true);
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			canvas.addEventListener('mousemove', onMouseMove);
		}
		
		COMPILE::JS
		protected function onMouseUp():void {
			handle.toggle("is-dragged",false);
			window.removeEventListener('mouseup', onMouseUp);
			canvas.removeEventListener('mousemove', onMouseMove);
			imageData = null;
		}

		COMPILE::JS
		protected function onMouseMove(e:MouseEvent):void {
			//TODO disabled?
			// if(disabled){
			// 	return;
			// }
			calculateColor(getClientOffset(e));
		}
		private function calculateColor(point:Point):void{
			if(!imageData){
				getImageData();
			}
    // locate index of current pixel
    	var i:int = (point.y * imageData.width + point.x) * 4;
			var data:Uint8ClampedArray = imageData.data;
			handle.appliedColor = new RGBColor([data[i],data[i+1],data[i+2],data[i+3]]);
			handle.x = point.x;
			handle.y = point.y;
		}
		private function getClientOffset(event:MouseEvent):Point{
			if(event["touches"]){
				event = event["touches"][0];
			}
			var point:Point = new Point(event.pageX,event.pageY);
			point.x -= canvas.offsetLeft;
			point.y -= canvas.offsetTop;
			return point;
		}

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
			var colorToApply:IRGBA = baseColor.clone();
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