package com.unhurdle.spectrum.colorpicker
{

	import org.apache.royale.html.ColorPicker;

	public class ColorPicker extends org.apache.royale.html.ColorPicker
	{
		private var _position:String = "bottom";

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position = value;
		}

		public function ColorPicker()
		{
		}

	}
}
