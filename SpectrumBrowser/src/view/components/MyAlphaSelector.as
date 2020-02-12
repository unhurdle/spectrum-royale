package view.components
{
	import org.apache.royale.html.Slider;
	import com.unhurdle.spectrum.VideoPlayerSlider;
	import org.apache.royale.utils.CSSUtils;

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
			var from:String = CSSUtils.attributeFromColor(_color);
			var toStr:String = "0x" + _color.toString(16) + "00"; // add alpha
			var toColor:uint = parseInt(toStr);
			var to:String = CSSUtils.attributeFromColor(toColor);
            var str:String = "linear-gradient(to bottom, " + from + ", " + to + ")";
            element.style.background = str;
        }


	}
}
