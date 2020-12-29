package com.unhurdle.spectrum.data
{
  import com.unhurdle.spectrum.interfaces.IRGBA;

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
	}
}