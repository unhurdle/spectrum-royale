package com.unhurdle.spectrum
{

	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.geom.Point;
	import org.apache.royale.events.MouseEvent;
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import org.apache.royale.utils.number.pinValue;
	import org.apache.royale.utils.number.getPercent;
	import com.unhurdle.spectrum.data.RGBColor;
	import org.apache.royale.events.ValueEvent;

	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]

	public class AlphaColorSlider extends ColorSlider
	{
		public function AlphaColorSlider()
		{
			super();
			colorStops = ["rgb(0, 0, 0)"];
		}

		public function get colorStyle():String{
				return colorStops[0];
		}
		public function set colorStyle(val:String):void{
				if(val != colorStops[0]){
					colorStops[0] = val;
					changeBackgroundColor();
				}
		}

		public function get baseColor():IRGBA{
			var color:IRGBA = appliedColor.clone();
			color.alpha = 1;
			return color;
		}

		public function set baseColor(value:IRGBA):void{
			//trigger a handle redraw
			var alpha:Number = appliedColor ? appliedColor.alpha : 1;
			appliedColor = new RGBColor([value.r,value.g,value.b,alpha]);
		}

		override public function set appliedColor(value:IRGBA):void{
			super.appliedColor = value;
			var base:IRGBA = value.clone();
			colorStyle = base.styleString;
		}

		private var _opacity:Number;

		public function get opacity():Number{
			if(!appliedColor || isNaN(appliedColor.alpha)){
				return 100;
			}
			return appliedColor.alpha * 100;
		}

		public function set opacity(value:Number):void{
			if(!appliedColor){
				appliedColor = new RGBColor([0,0,0]);
			}
			appliedColor.alpha = pinValue(value/100,0,1);
		}
		
		COMPILE::JS
		override protected function changeBackgroundColor():void{
			if(!addedOnce){
				return;
			}
			var gradientDir:String;
			if(vertical){
				gradientDir = "bottom";
			}
			else{
				gradientDir = "right";
			}
			var startStr:String = "linear-gradient(to " + gradientDir + ", ";;

			startStr += colorStyle;
			var endStr:String =" 0%, rgba(0, 0, 0, 0) 100%)";
			gradient.style.background = startStr + endStr;
		}
		override protected function onMouseMove(e:MouseEvent):void {
			if(disabled){
				return;
			}
			//opaque at beginning
			var percent:Number = 100 - getMousePercentagePosition(e);
			var color:IRGBA = handle.appliedColor.clone();
			color.alpha = percent/100;
			handle.appliedColor = color;
			calculateHandlePosition();
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));			
		}
		override protected function calculateHandlePosition():void{
			if(appliedColor && !isNaN(appliedColor.alpha)){
				setHandlePosition(100 - (appliedColor.alpha * 100));
			} else {
				setHandlePosition(0);
			}
		}

	}
}