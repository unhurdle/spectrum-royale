package view.components
{
	import org.apache.royale.html.Slider;

	/**
	 *  The HueSelector is a slider that lets you select a hue for a color picker.
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.6
	 */
	public class MyAlphaSelector extends Slider
	{
		/**
		 *  Constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		private var _color:uint;

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
            adjustBackGround();
		}

		public function MyAlphaSelector()
		{
			super();
			typeNames = "AlphaSelector";
			minimum = 0;
			maximum = 100;
            adjustBackGround()
		}

        private function adjustBackGround():void
        {
			var r:uint = (_color >> 16 ) & 255;
			var g:uint = (_color >> 8 ) & 255;
			var b:uint = _color & 255;
            var from:String = "rgba(" + r + ", " + g + ", " + b + ", 1)";
            var to:String = "rgba(" + r + ", " + g + ", " + b + ", 0)";
            var str:String = "linear-gradient(to bottom, " + from + ", " + to + ")";
            element.style.background = str;
        }


	}
}
