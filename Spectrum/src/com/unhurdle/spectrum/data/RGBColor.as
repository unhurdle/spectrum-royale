package com.unhurdle.spectrum.data
{
  import com.unhurdle.spectrum.interfaces.IRGBA;
  import org.apache.royale.utils.HSV;

  public class RGBColor implements IRGBA
  {
		public function RGBColor(initialValue:Object=null){
			if(initialValue && initialValue.length){
				if(initialValue[0]){
					r = initialValue[0];
				}
				if(initialValue[1]){
					g = initialValue[1];
				}
				if(initialValue[2]){
					b = initialValue[2];
				}
				if(initialValue[3]){
					alpha = initialValue[3];
				}
			}
		}

		private var _r:Number;

		public function get r():Number{
			return _r;
		}
		public function set r(value:Number):void{
			_r = value;
		}

		private var _g:Number;
		public function get g():Number{
			return _g;
		}
		public function set g(value:Number):void{
			_g = value;
		}

		private var _b:Number;
		public function get b():Number{
			return _b;
		}
		public function set b(value:Number):void{
			_b = value;
		}

		private var _alpha:Number;
		public function get alpha():Number{
			return _alpha;
		}
		public function set alpha(value:Number):void{
			_alpha = value;
		}

		public function get colorValue():uint{
			throw new Error("Method not implemented.");
		}
		public function get styleString():String{
			if(isNaN(r) || isNaN(g) || isNaN(b)){
				return "";
			}
			var hasAlpha:Boolean = !isNaN(alpha);
      var prefix:String = hasAlpha ? "rgba(" : "rgb(";
      var str:String = prefix + r + "," + g + "," + b;
      if(hasAlpha){
        return str + "," + alpha + ")";
      }
      return str + ")";
		}
		public function clone():RGBColor{
			return new RGBColor([r,g,b,alpha]);
		}
		public static function fromHSV(hsv:HSV):RGBColor{
			var h:Number = hsv.h == 360 ? 1 : hsv.h / 360 * 6;
			var s:Number = hsv.s == 100 ? 1 : hsv.s / 100;
			var v:Number = hsv.v == 100 ? 1 : hsv.v / 100;

			var i:Number = Math.floor(h);
			var f:Number = h - i;
			var p:Number = v * (1 - s);
			var q:Number = v * (1 - f * s);
			var t:Number = v * (1 - (1 - f) * s);
			var r:Number;
			var g:Number;
			var b:Number;
			switch(i % 6){
					case 0: r = v, g = t, b = p; break;
					case 1: r = q, g = v, b = p; break;
					case 2: r = p, g = v, b = t; break;
					case 3: r = p, g = q, b = v; break;
					case 4: r = t, g = p, b = v; break;
					case 5: r = v, g = p, b = q; break;
			}
			return new RGBColor([r*255,g*255,b*255]);
		}
	}
}
